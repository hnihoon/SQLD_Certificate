SELECT first_name FROM EMPLOYEES;
--		컬럼명			테이블명

-- (--)는 주석 이라고 해서 --를 표시해두면 컴퓨터가 해석하지 않고 넘어갑니다
--(주로 설명이나 코멘트, 코드 재사용을 할 경우를 위해 코드를 남겨두는 경우 등에 활용합니다.)

SELECT last_name FROM EMPLOYEES;

SELECT first_name, last_name FROM EMPLOYEES;

-- 내용이 길어질 경우 작성 방법1)
SELECT employee_id, first_name, last_name,email, phone_number ,hire_date 
FROM EMPLOYEES;

-- 내용이 길어질 경우 작성 방법2)
SELECT employee_id
	, first_name
	, last_name,email
	, phone_number 
	, hire_date 
FROM EMPLOYEES;

-- 전체 컬럼 속에 내용 조회하기
SELECT * FROM EMPLOYEES;

--사원 이름, 성, 봉급, 부서ID를 조회하되 봉급 오름차순으로 정렬하기
SELECT first_name, last_name, salary, department_id
FROM EMPLOYEES
ORDER BY SALARY; 

--사원 이름, 성, 봉급, 부서ID를 조회하되 봉급 내림차순으로 정렬하기
SELECT first_name, last_name, salary, department_id
FROM EMPLOYEES
ORDER BY SALARY DESC;

--ORDER BY는 기본적으로 ORDER BY 컬럼명 ASC; 오름차순인데 ASC 생략가능
--ORDER BY SALARY 컬럼명 ASC로 작성해도 됩니다.

--ORDER BY를 다중으로 활용 가능 
--방법1)
SELECT first_name, last_name, salary, department_id
FROM EMPLOYEES
ORDER BY SALARY DESC, DEPARTMENT_ID DESC;

--방법2)
SELECT first_name, last_name, salary, department_id
FROM EMPLOYEES
ORDER BY SALARY ASC, DEPARTMENT_ID DESC;

--부서id 조회
SELECT department_id FROM EMPLOYEES;


--중복된 내용을 하나만 조회
SELECT DISTINCT department_id FROM EMPLOYEES;

--여러개의 컬럼을 복합적으로 생각하여 중복 제거 후 가져온다.
SELECT DISTINCT salary, department_id FROM EMPLOYEES;

--연결연산자를 활용해서 출력하기
SELECT first_name, department_id, first_name || department_id
FROM EMPLOYEES;

--원하는 문자를 연결해서 출력해보기
SELECT email || @gmail.com
FROM EMPLOYEES;

SELECT email || '@gmail.com'
FROM EMPLOYEES;

--사원의 이름과 원래 받아야 하는 봉급, 10%인상된 보너스 봉급 조회하기
SELECT first_name, salary, salary * 1.1
FROM EMPLOYEES;

--날짜도 +와 -를 사용이 가능하다
SELECT first_name, hire_date, hire_date + 10, hire_date - 10
FROM EMPLOYEES;

--시간이나 분, 초 모두 일로 환산하여 계산		 (          30분         )	
SELECT hire_date, hire_date + 12/24, hire_date + 30 / 24 / 60
FROM EMPLOYEES;

--현재 날짜를 가져오기(sysdate)
SELECT SYSDATE , HIRE_DATE, SYSDATE - HIRE_DATE  
FROM EMPLOYEES;