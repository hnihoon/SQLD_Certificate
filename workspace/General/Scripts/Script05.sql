--부서별 봉급 총합
SELECT DEPARTMENT_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

--DEPARTMENT_ID에 들어있는 값과 JOB_ID에 들어있는 값이 모두 같은 행들은 같은 그룹으로 분류가 된다.
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID;

--ROLLUP
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

--ROLLUP 함수는 앞에 작성한 컬럼을 기준으로 소계를 집계하기 때문에
--순서가 달라지면 결과값도 달라진다.
SELECT JOB_ID, DEPARTMENT_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID, DEPARTMENT_ID)
ORDER BY DEPARTMENT_ID;

--CUBE() 는 각각의 컬럼 별 모든 조합의 소계를 보여주기 때문에
--컬럼순서가 달라져도 조회결과는 달라지지 않는다.
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY) 
FROM EMPLOYEES
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID);

--GROUPING SETS() 소그룹의 결과는 안보여주고, 소그룹별 소계만 보여준다.
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY) 
FROM EMPLOYEES
GROUP BY GROUPING SETS(DEPARTMENT_ID,JOB_ID);

--GROUPING() 해당컬럼의 소계를 구하고 있다면 결과는 1아니면 0
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
	  , GROUPING(DEPARTMENT_ID)
	  , GROUPING(JOB_ID) 
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

--GROUPING() 해당컬럼 모두 묶은 상태라면 결과는 1 아니면 0
-- 			 결과가 1인지 0인지에 따라 CASE 표현식이나 
--			 DECODE()함수를 사용할 수 있다.
SELECT SUM(SALARY)
	  , CASE 
		  	 WHEN GROUPING(DEPARTMENT_ID) = 0 THEN TO_CHAR(DEPARTMENT_ID) 
	   		 ELSE '모든부서'
	    END 부서ID,
	    CASE 
	    	WHEN GROUPING(JOB_ID) = 0 THEN JOB_ID
	    	ELSE '모든직업군'
	    END 직업군 
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

--행의 갯수가 다를 경우 같이 조회할 수 없음
--SELECT FIRST_NAME, SALARY, AVG(SALARY) 
--FROM EMPLOYEES;

--over() 를 붙여서 사용해주면 전체 갯수만큼 출력해줌
SELECT FIRST_NAME, SALARY, AVG(SALARY) OVER() 
FROM EMPLOYEES;

--over(PARTITION BY) GROUP BY 와 같은 역할
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
	  ,AVG(SALARY) over() 전체직원평균봉급
	  ,AVG(SALARY) over(PARTITION BY DEPARTMENT_ID) 부서별평균봉급 
FROM EMPLOYEES;

--over(ORDER BY) : PARTITION 내에서 정렬을 해주고 싶을 때 사용
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID 
	  ,AVG(SALARY) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) 
FROM EMPLOYEES;

--WINDOWING절 생략
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID 
	 , SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID  
	 					ORDER BY SALARY
	 					) AS "생략"	
FROM EMPLOYEES; 

--WINDOWING절 UNBOUNDED PRECEDING : 파티션 첫번째 행
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID 
	 , SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID  
	 					ORDER BY SALARY
	 					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	 					) AS "UPCR"	
FROM EMPLOYEES;

--WINDOWING절 값 PRECEDING : 현재행을 기준으로 값만큼 앞의 행
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID 
	 , SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID  
	 					ORDER BY SALARY
	 					ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
	 					) AS "3PCR"	
FROM EMPLOYEES;

--WINDOWING절 RANGE BETWEEN 시작값 AND 종료값
SELECT FIRST_NAME, SALARY
	 , SUM(SALARY) OVER(ORDER BY SALARY RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
FROM EMPLOYEES;

--WINDOWING절 RANGE BETWEEN 값 PRECEDING AND 값 FOLLOWING
SELECT FIRST_NAME, SALARY
	 , SUM(SALARY) OVER(ORDER BY SALARY RANGE BETWEEN 100 PRECEDING AND 100 FOLLOWING) 
FROM EMPLOYEES;
