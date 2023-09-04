SELECT * FROM EMPLOYEES;

-- salary가 10000보다 크거나 같은 직원의 이름 조회하기
SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE SALARY >= 10000;

-- 입사일이 2005년 1월 1일 이후인 직원의 이름 조회하기
SELECT FIRST_NAME, HIRE_DATE 
FROM EMPLOYEES
WHERE HIRE_DATE > TO_DATE('20050101', 'yyyymmdd');

SELECT FIRST_NAME, HIRE_DATE 
FROM EMPLOYEES
WHERE HIRE_DATE > '20050101';

-- 이름이 David인 사람의 봉금 조회하기
SELECT SALARY 
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

select SALARY 
from EMPLOYEES
where FIRST_NAME = 'david';

-- 문자의 크기는 컴퓨터 상의 문자에 해당하는 숫자 크기로 계산
-- 각각에 문자에는 해당하는 숫자값을 정리해놓은 규칙 : 아스키 코드가 있다.
SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME > 'M';

SELECT FIRST_NAME ,SALARY 
FROM EMPLOYEES
WHERE 100 > 50;

--SQL 연산자
SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES
WHERE SALARY BETWEEN 5000 AND 10000;
--	  SALARY 가 5000이상 10000이하 인 모든 FIRST_NAME, SALARY를 가져옴

SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES
WHERE FIRST_NAME IN ('David', 'Peter', 'John');
--    FIRST_NAME 이 'David'같거나, 'Peter'랑 같거나,'John이랑 같으면 가져옴  

--LIKE 패턴 설정 시 규칙
-- % : ~로 보면됨
-- _ : 자릿수로 보면됨
SELECT PHONE_NUMBER, FIRST_NAME, EMAIL 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%vi%';

SELECT PHONE_NUMBER, FIRST_NAME, EMAIL 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%e%e_';

SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES
WHERE SALARY > ANY (5000, 10000, 8000);
-- SALARY > 5000 혹은 SALARY > 10000 혹은 SALARY > 8000

SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES
WHERE SALARY > ALL (5000, 10000, 8000);

SELECT PHONE_NUMBER,COMMISSION_PCT 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

SELECT PHONE_NUMBER,COMMISSION_PCT 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

-- 논리연산자
-- 부서 ID가 50이면서 봉급이 10000이상인 직원의 이름 조회
SELECT FIRST_NAME, DEPARTMENT_ID, SALARY 
FROM EMPLOYEES
WHERE DEPARTMENT_ID =50 AND SALARY >= 5000;
-- DEPARTMENT_ID 가 50 이면서 SALARY 5000보다 크거나 같은 경우만

SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES
WHERE SALARY > 5000 AND SALARY <10000;
-- SALARY가 5000보다 크면서 SALARY가 10000보다 작은 경우만

-- 이름에 vi가 포함되어 있거나 salary가 5000이상, 10000이하인 직원 이름 조회
SELECT FIRST_NAME, SALARY 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%vi%' OR SALARY BETWEEN 5000 AND 10000;
-- FIRST_NAME이 ~vi~거나 SALARY가 5000이상 10000 이하인 경우

SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE NOT FIRST_NAME LIKE '%vi%';
-- FIRST_NAME에 ~vi~가 아닌 이름만 가져옴 


SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID > 150 AND SALARY BETWEEN 5000 AND 10000
AND DEPARTMENT_ID >30;
-- EMPLOYEE_ID가 150보타 크면서 SALARY가 5000이상 10000이하 이면서 
-- DEPARTMENT_ID가 30 이상인 경우

SELECT EMPLOYEE_ID, SALARY, DEPARTMENT_ID 
FROM EMPLOYEES
WHERE (EMPLOYEE_ID > 150
OR SALARY > 10000)
AND DEPARTMENT_ID > 50;
-- EMPLOYEE_ID 150 보다 크거나 SALARY가 10000보다 크고 DEPARTMENT_ID가 50보다 큰경우

-- 80번 부서, 직원이름, 봉급, 커미션포함한 봉급을
-- 커미션 포함 봉급 순서로 내림차순 정렬하여 조회하기
SELECT FIRST_NAME, SALARY, SALARY +SALARY *COMMISSION_PCT 
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
ORDER BY SALARY + SALARY * COMMISSION_PCT DESC;

-- 별칭 붙여주기
SELECT FIRST_NAME AS "이름"
	, SALARY "봉급"
	, SALARY +SALARY *COMMISSION_PCT AS 조정봉급 
	, PHONE_NUMBER 전화번호
	, EMAIL "이메일 주소"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80
ORDER BY 조정봉급 DESC;