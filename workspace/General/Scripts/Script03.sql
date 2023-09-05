-- 입력값이 숫자인 함수
-- ROUND(숫자, 소수점자리수)
SELECT COMMISSION_PCT, ROUND(COMMISSION_PCT,1) 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- dual 테이블은 결과를 확인하기 위한 가상의 테이블(오라클, mySQL만 가능)
SELECT ROUND(15.3124,-1) --반올림하여 1의 자리까지 표현
	  ,ROUND(15.3124,1)	 --반올림하여 소수점 아래 1의 자리까지 표현
	  ,ROUND(15.3124,2)  --반올림하여 소수점 아래 2의 자리까지 표현
	  ,ROUND(15.3124)    --생략시 반올림하여 1의 자리까지 표현
FROM dual;

--TRUNC 절삭기능을 하는 함수
SELECT TRUNC(15.3124, -1)
	  ,TRUNC(15.3124, 1)
	  ,TRUNC(15.3124, 2)
	  ,TRUNC(15.3124) 
FROM dual;

-- 각종 함수들
SELECT MOD (10, 3)	--10을 3으로 나눔
	 ,CEIL(13.513)	--무조건 올림
	 ,FLOOR(13.513) --무조건 내림
	 ,SIGN(15)		--음수, 양수 확인 : 양수 = 1
	 ,SIGN(-64)		--음수, 양수 확인 : 음수 = -1
	 ,POWER(3, 2) 	--제곱
	 ,SQRT(25)		--제곱시 25가 되는 숫자를 알려줌
	 ,ROUND(SQRT(5),2) --이런식으로도 활용 가능 
FROM dual;

--where절
-- 직원id가 홀수인 직원의 직원id와 직원이름조회
SELECT EMPLOYEE_ID, FIRST_NAME 
FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID, 2) = 1
ORDER BY EMPLOYEE_ID;

--LOWER : 대문자를 소문자로 , UPPER : 소문자를 대문자로
SELECT FIRST_NAME
	  ,LOWER(FIRST_NAME)
	  ,UPPER(FIRST_NAME) 
FROM EMPLOYEES;

--INITCAP : 맨 앞글자만 대문자로
SELECT EMAIL, INITCAP(EMAIL) 
FROM EMPLOYEES;

--SUBSTR n부터 n개 짜르기			2번부터~2개 자르기
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 2, 2) 
FROM EMPLOYEES;

--REPLACE : 어떤 문자에서 어떤 문자를 어떤 문자로 변환
SELECT REPLACE('apple','pl','o')
FROM dual;

--CONCAT : 문자로 합쳐서 보여줌 , INSTR : 특정 문자의 위치를 알려줌 LENGTH : 총 길이를 알려줌
SELECT CONCAT('ap', 10)
	  ,INSTR('apple','pl')
	  ,INSTR('hello world', 'o', 6) --INSTR는 앞에서 부터 찾기 시작하는데 6을 지정해주면 6부터 찾음
	  ,LENGTH('apple')
FROM dual;

--사원의 이름 중 e가 두개 존재하는 사원의 이름 조회
--이때 두번째 e부터 끝까지 잘라낸 결과 조회하기

--e의 위치와 두번째 e의 위치를 알아보기 위한 코딩
SELECT FIRST_NAME
	  ,INSTR(LOWER(FIRST_NAME), 'e') 
	  ,INSTR(LOWER(FIRST_NAME), 'e', INSTR(LOWER(FIRST_NAME), 'e')+1) 
FROM EMPLOYEES;

SELECT FIRST_NAME 
	,SUBSTR(
 		FIRST_NAME
		,INSTR(LOWER(FIRST_NAME), 'e', INSTR(LOWER(FIRST_NAME), 'e')+1)
		,LENGTH(FIRST_NAME)-INSTR(LOWER(FIRST_NAME), 'e', INSTR(LOWER(FIRST_NAME), 'e')+1)+1
	) AS "결과"
FROM EMPLOYEES
WHERE INSTR(LOWER(FIRST_NAME), 'e', INSTR(LOWER(FIRST_NAME), 'e')+1) <> 0;

--LPAD : 일정 길이를 지정하고 부족한 부분을 원하는 내용으로 채워줌(왼쪽)
--RPAD : 일정 길이를 지정하고 부족한 부분을 원하는 내용으로 채워줌(오른쪽)
SELECT LPAD('apple',10,'h')
	  ,RPAD('apple',10,'h')
FROM dual;

--LTRIM : 특정 문자를 다른 문자가 나오기 전까지 왼쪽부터 지움
--RTRIM : 특정 문자를 다른 문자가 나오기 전까지 오른쪽부터 지움
SELECT LTRIM('aaa bbab baaa', 'a') 
	  ,RTRIM('aaa bbab baaa' , 'a') 
FROM dual;

-- TRIM : 문자 양쪽에 띄어쓰기를 지워줌
SELECT TRIM('         오늘 가입했습니다.        ') 
FROM dual;

--사원의 이름과 이메일 주소를 출력하고자 한다.
--이때 사원의 이메일 주소는 개인정보 보호를 위해 앞의 두 글자를 제외한 나머지 부분은 *로 채워서 조회하기
SELECT FIRST_NAME, EMAIL
	,RPAD(SUBSTR(EMAIL, 1, 2), LENGTH(EMAIL), '*') || '@gmail.com' AS "이메일"
FROM EMPLOYEES;

--MONTHS_BETWEEN : 두 날짜간 개월수 차이를 계산해줌
SELECT SYSDATE, HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE) 
FROM EMPLOYEES;

--ADD_MONTHS : 일정 날짜로부터 n개월을 더해줌
SELECT sysdate, ADD_MONTHS(sysdate, 5)
FROM dual;

--NEXT_DAY(sysdate, 1) : 1=일요일 , 2=월요일, 3=화요일, 4=수요일, 5=목요일, 6=금요일, 7=토요일
-- ㄴ 현재 날짜로부터 돌아오는 일요일을 나타냄
SELECT SYSDATE, NEXT_DAY(sysdate, 1) 
FROM dual;

SELECT SYSDATE, NEXT_DAY(sysdate, '토') 
FROM dual;

SELECT SYSDATE, NEXT_DAY(sysdate, 4) 
FROM dual;

--LAST_DAY : 달의 마지막 요일을 알려줌
SELECT HIRE_DATE, LAST_DAY(HIRE_DATE) 
FROM EMPLOYEES;

--ROUND로 날짜 반올림 해보기
SELECT SYSDATE 
	  ,ROUND(SYSDATE, 'year')  --반올림하여 년도까지 표현
	  ,ROUND(SYSDATE, 'month') --반올림하여 월가지 표현
	  ,ROUND(SYSDATE)		   --기본값, 반올림하여 일까지 표현 
	  ,ROUND(SYSDATE, 'day')   --반올림하여 일까지 표현
	  ,ROUND(SYSDATE, 'dd')    --반올림하여 요일까지 표현
FROM dual;

--TRUNC로 날짜 절삭 해보기
SELECT SYSDATE 
	  ,TRUNC(SYSDATE, 'year')  --절삭하여 년도까지 표현
	  ,TRUNC(SYSDATE, 'month') --절삭하여 월가지 표현
	  ,TRUNC(SYSDATE)		   --기본값, 절삭하여 일까지 표현 
	  ,TRUNC(SYSDATE, 'day')   --절삭하여 일까지 표현
	  ,TRUNC(SYSDATE, 'dd')    --절삭하여 요일까지 표현
FROM dual;

--직원의 이름과, 고용일, 연차를 조회하시오
--단, 연차는 다음과 같이 계산이 된다.
--2021년 1월 입사자는 현재(2022년 12월) --> 2년차
--2021년 12월 입사자는 현재 2년차
SELECT FIRST_NAME, HIRE_DATE
	 ,MONTHS_BETWEEN(TRUNC(SYSDATE, 'year'),TRUNC(HIRE_DATE, 'year'))/12+1
FROM EMPLOYEES;