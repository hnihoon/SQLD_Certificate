--문자를 숫자로 TO_NUMBER
SELECT TO_NUMBER('15000') + 100 --15000이 숫자로 변환되어 연산 가능해짐
FROM DUAL;

--문자를 날짜로 TO_DATE
--TO_DATE(문차,패턴)
-- y : 년도
-- m : 월 
-- d : 일
-- hh : 시 
-- mi : 분 
-- ss : 초
SELECT TO_DATE('050501', 'mmddyy')
	  ,TO_DATE('2023-09/12 12:24-5', 'yyyy-mm/dd hh:mi-ss')
FROM dual;

--hh : 시간 1~12 표현방식
--hh24 : 시간 0~23 표현방식
SELECT TO_DATE('000101 19', 'yymmdd hh')
	  ,TO_DATE('000101 19', 'yymmdd hh24')
FROM dual;

--날짜를 문자로 TO_CHAR
-- day : 요일
-- am or pm : 오전 or 오후
SELECT SYSDATE 
	  ,TO_CHAR(SYSDATE) 
	  ,TO_CHAR(SYSDATE, 'mm-dd yyyy hh24-mi-ss day am month ddd')
	  ,TO_CHAR(SYSDATE, 'yyyy"년"mm"월"dd"일"')
FROM dual;

--숫자를 문자로 
-- 9 : 자릿수를 의미 비어있는 자리는 공백이 채워짐
-- 0 : 비어있는 자리를 0으로 채움
-- . : 소수점 위치를 의미
-- , : 콤마 위치를 의미
-- $ : $기호를 의미
-- L : 지역 통화 기호를 의미(원화)
SELECT TO_CHAR(SALARY, 'L0999,999.99')
	  ,TO_CHAR(SALARY, '$999,999') 
FROM EMPLOYEES;

--CAST 연산자 : 값을 다른 형태로 바꿈 (값, AS 바꾸고자 하는 형태)
SELECT CAST (EMPLOYEE_ID AS VARCHAR2(3))
	  ,CAST('1511' AS NUMBER(5))
	  ,CAST(SYSDATE AS VARCHAR2(100))
FROM EMPLOYEES;

-- 사원들의 커미션 포함 봉급 조회하기
SELECT COMMISSION_PCT
	  ,NVL(COMMISSION_PCT, 0)
	  ,SALARY + SALARY * NVL(COMMISSION_PCT,0) AS 커미션포함봉급
	  ,SALARY AS 커미션제외봉급
FROM EMPLOYEES;

--NVL 연산자 : (앞에값이 NULL인 경우, 뒤 값으로 변환)
SELECT COMMISSION_PCT, NVL(COMMISSION_PCT,0)
	,SALARY + SALARY *NVL(COMMISSION_PCT,0) 커미션포함봉급
	,SALARY 커미션제외봉급
FROM EMPLOYEES;

-- DECODE(값1, 값2, 값3, 값4) : 값1, 값2가 같다면 값3 출력 다르면 값4 출력
-- 80번 부서는 직원봉급을 10%인상
-- 전체 직원이 받아야하는 봉급을 조회
SELECT DEPARTMENT_ID, SALARY 원래봉급
	,DECODE(DEPARTMENT_ID, 80, SALARY*1.1, SALARY) 조정봉급
FROM EMPLOYEES;

-- 80번 부서는 10%인상, 50번 부서는 10%인하
SELECT DEPARTMENT_ID, SALARY 원래봉급
	,DECODE(DEPARTMENT_ID, 80, SALARY*1.1 , DECODE(DEPARTMENT_ID, 50, SALARY*0.9, SALARY)) 조정봉급 
FROM EMPLOYEES;

-- DECODE생략 가능한 경우
SELECT DEPARTMENT_ID, SALARY 원래봉급
	,DECODE(DEPARTMENT_ID, 80, SALARY*1.1 , 50, SALARY*0.9, SALARY) 조정봉급 
FROM EMPLOYEES;

-- CASE WHEN THEN END 연산자
SELECT EMPLOYEE_ID, SALARY
	,CASE
		WHEN EMPLOYEE_ID =155 THEN 0
		WHEN EMPLOYEE_ID BETWEEN 150 AND 160 THEN SALARY * 1.1
		WHEN EMPLOYEE_ID >=170 THEN SALARY * 0.9
		ELSE SALARY
	 END 조정봉급
FROM EMPLOYEES;

-- CASE연산자 문제1)
-- 80번 부서는 10%인상, 50번 부서는 10%인하
-- >직원 이름, 부서ID, 원래봉급, 조정봉급, 비고 를 조회하라 부서ID순서대로 정렬하여 조회하기
-- >비고에는 인상되면 인상, 인하되면 인하, 그대로면 해당없음 이라고 표현
SELECT FIRST_NAME 이름, DEPARTMENT_ID 부서ID, SALARY 원래봉급
	,CASE 
		WHEN DEPARTMENT_ID = 80 THEN SALARY * 1.1
		WHEN DEPARTMENT_ID = 50 THEN SALARY * 0.9
		ELSE SALARY 
	END	조정봉급
	,CASE 
		WHEN DEPARTMENT_ID = 80 THEN '인상'
		WHEN DEPARTMENT_ID = 50 THEN '인하'
		ELSE '해당없음'
	 END 비고
FROM EMPLOYEES
ORDER BY 부서ID;

--CASE연산자 문제1)에서 조건 한번에 적용하는 방법
SELECT FIRST_NAME 이름, DEPARTMENT_ID 부서ID, SALARY 원래봉급
	,CASE DEPARTMENT_ID
		WHEN 80 THEN SALARY * 1.1
		WHEN 50 THEN SALARY * 0.9
		ELSE SALARY 
	END	조정봉급
	,CASE DEPARTMENT_ID
		WHEN 80 THEN '인상'
		WHEN 50 THEN '인하'
		ELSE '해당없음'
	 END 비고
FROM EMPLOYEES
ORDER BY 부서ID;

-- CASE연산자 문제2)
-- >봉급이 10000만달러 이상인 직원은 상
-- >500이상 10000만미인 직원은 중
-- >5000미만인 직원은 하로 표현하여 직원 이름, 봉급, 비고 조회하기
SELECT FIRST_NAME 이름, SALARY 봉급
	,CASE 
		WHEN SALARY >=10000 THEN '상'
		WHEN SALARY >=5000 THEN '중'
		ELSE '하'
	END 비고
FROM EMPLOYEES
ORDER BY 봉급;

-- CASE연산자 문제3)
-- >입사일이 윤년인 직원은 윤년, 입사일이 평년인 직원은 평년이라고 작성하여
-- >직원이름, 입사일, 비고 조회하기
-- >4의배수O 100의배수O 400의배수O --> 2000 윤년
-- >4의배수O 100의배수O 400의배수X --> 1900 2100... 윤년X
-- >4의배수O 100의배수X 400의배수X --> 2012 2004 윤년
-- >4의배수X 100의배수X 400의배수X --> 2003 평년

-- CASE연산자 문제3) 방법1)
SELECT FIRST_NAME 이름, HIRE_DATE 입사일
	,CASE 
		WHEN 
		MOD(CAST(TO_CHAR(HIRE_DATE,'yyyy') AS NUMBER(4)),400) = 0
		OR MOD(CAST(TO_CHAR(HIRE_DATE,'yyyy') AS NUMBER(4)),4) = 0
		AND MOD(CAST(TO_CHAR(HIRE_DATE,'yyyy') AS NUMBER(4)),100) <> 0
		THEN'윤년'
		ELSE '평년'
	 END 비고
FROM EMPLOYEES;

-- CASE연산자 문제3) 방법2)
SELECT FIRST_NAME 이름, HIRE_DATE 입사일
	,CAST(TO_CHAR(HIRE_DATE,'yyyy') AS NUMBER(4)) "숫자로 바꾼 년도"
	,CASE --MOD : 값 나누가 값 (값, 나누고자 하는 값)
		WHEN MOD(CAST(TO_CHAR(HIRE_DATE,'yyyy') AS NUMBER(4)), 400) = 0 THEN '윤년'
		WHEN MOD(CAST(TO_CHAR(HIRE_DATE,'yyyy') AS NUMBER(4)),100) = 0 THEN '평년'
		WHEN MOD(CAST(TO_CHAR(HIRE_DATE,'yyyy') AS NUMBER(4)),4) = 0 THEN '윤년'
		ELSE '평년'
	 END 비고
FROM EMPLOYEES
ORDER BY 입사일;

-- 집계함수
-- SUM() : 합계
-- AVG() : 평균
-- COUNT : 갯수
-- MIN : 컬럼내 최소값
-- MAX : 컬럼내 최대값
SELECT SUM(SALARY), AVG(SALARY), COUNT(SALARY), MIN(SALARY), MAX(SALARY)  
FROM EMPLOYEES;

-- FIRST_NAME 은 총 107개의 컬럼을 가지고 있고, SUM()은 1개의 컬럼으로 결과를 보여주기에 같이 실행 불가 
SELECT FIRST_NAME SUM(SALARY)
FROM EMPLOYEES;

-- 집계함수는 NULL 값을 제외하고 계산한다.
-- COMMISSION_PCT의 총 갯수는 107개 입니다.
SELECT COUNT(COMMISSION_PCT), SUM(COMMISSION_PCT) 
FROM EMPLOYEES;

--해당 테이블에 있는 전체 행의 갯수
SELECT COUNT(*) 
FROM EMPLOYEES;

--GROUP BY절
--그룹화를 할 때 사용한다
--DEPARTMENT_ID 에는 총 12종류가 있음  
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE EMPLOYEE_ID > 150
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- WHERE에는 집계함수를 사용할 수 없음
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE EMPLOYEE_ID > 150 AND AVG(SALARY) > 5000
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- HAVING : GROUP BY 에서 사용하는 조건문
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE EMPLOYEE_ID > 150
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > 5000
ORDER BY DEPARTMENT_ID;


