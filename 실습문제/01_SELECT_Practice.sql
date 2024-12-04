SELECT * FROM department; --department 라는 테이블에 있는 모든 내용 조회하기

--QUIZ 1   LOCATION 테이블 모두 조회하기
select * From location;

--QUIZ 2   JOB 테이블 모두 조회하기
select * from job;

--QUIZ 3   NATIONAL 테이블 모두 조회하기
select * from national;

--QUIZ 4   SAL_GRADE 테이블 모두 조회하기
select * from sal_grade;



-- EMPLOYEE 테이블에서 사번(EMP_ID) 이름(EMP_NAME) 급여(SALARY) 조회
SELECT emp_id, emp_name, salary from employee;

-- EMPLOYEE 테이블에서 이름(emp_name) 조회
select emp_name from employee;

-- Employee 테이블에서 emp_name hire_date 조회
select emp_name, hire_date from employee;

-- DEPARTMENT 테이블에서 부서코드 부서명 조회 (DEPT_ID, DEPT_TITLE)
select dept_id, dept_title from department;

-- DEPARTMENT 테이블에서 모든 데이터 조회
select * from department;

/* 컬럼 값 산술 연산 */
-- 컬럼 값 : 행과 열이 교차되는 테이블의 한 칸에 작성된 값
-- select 문 작성 시 컬럼명에 산술 연산을 직접 작성하면 조회결과에 연산결과가 반영되어 조회된다.

-- EMPLOYEE 테이블에서 모든 사원의 이름, 급여, 급여 * 12를 해서 연봉 조회

SELECT EMP_ID, EMP_NAME, SALARY * 12 FROM employee;

SELECT EMP_ID, EMP_NAME, SALARY,  SALARY * 12 FROM employee;

-- SALAY * 12에 별칭을 붙여서 연봉이라 표기하기
-- 별명을 붙여 컬럼명이 조회되길 원한다면 AS 별명 을 작성해주면 된다.


SELECT EMP_ID, EMP_NAME, SALARY,  SALARY * 12 AS 연봉 FROM employee;

-- employee 테이블에서 EMP_ID AS 직원아이디 , EMP_NAME = 직원이름, SALARY = 월급 으로 표기해서 출력
SELECT emp_id as 직원아이디 ,  emp_name as 직원이름, salary as 월급 from employee;


-- 가짜 테이블을 이용해서 시간 기능 조회하기
SELECT SYSDATE FROM DUAL;      -- 24/12/04

SELECT SYSTIMESTAMP FROM DUAL; -- 24/12/04 14:28:47.678000000 +09:00

/*
날짜 데이터 연산하기 ( + , - 만 가능)
--> +1 == 1일 추가
--> -1 == 1일 감소
--> 일 단위로 계산
*/

-- 가짜 테이블을 이용해서 [      ] AS 어제,   [     ]  AS 현재 ,  [    ] AS 내일 ,  [    ] AS 모레 조회 
SELECT SYSDATE -1 AS 어제, SYSDATE AS 현재 ,SYSDATE +1 AS 내일  , SYSDATE +2 AS 모레 FROM DUAL;


SELECT '2024-12-04', TO_DATE('2024-12-04', 'YYYY-MM-DD') FROM DUAL;


-- EMPLOYEE 에서 모든 사원의 이름, 입사일, 근무 일수(SYSDATE - 입사일) 조회
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE FROM EMPLOYEE;



-- 퇴사여부가 Y 인 사원의 이름과 퇴사일 조회
SELECT EMP_NAME, ENT_DATE  -- 무엇을 조회할 것인가
FROM EMPLOYEE              -- 어디서 조회할 것인가
WHERE ENT_YN = 'Y';        -- 어떤 조건을 걸 것인가


-- 보너스가 있는 사원의 이름과 보너스 금액 조회   WEHRE BONUS IS NOT NULL;
SELECT EMP_NAME, BONUS 
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;


-- EMPLOYEE 테이블에서 급여가 300만원 이상인 사원의 이름과 급여를 조회
--  급여 >= 3000000
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000;


-- DEPARTMENT 테이블에서 LOCATION_ID 가 'L1' 지역에 위치한 부서의 모든 정보 조회
SELECT *
FROM DEPARTMENT
WHERE LOCATION_ID = 'L1';

-- EMPLOYEE 테이블에서 이메일 주소가 없는 사원의 이름 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMAIL IS NULL;
--> 이메일 주소가 모두 존재하기 때문에 아무것도 안나오는 것 맞음

-- EMPLOYEE 테이블에서 관리자가 없는 사원의 정보 조회
SELECT *
FROM EMPLOYEE
WHERE manager_id IS NULL;

-- EMPLOYEE 테이블에서 모든 사원의 이름, 입사일, 근무일수(현재 시간 - 입사일) 조회
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE 
FROM EMPLOYEE;

-- 포멧팅을 활용해서 보기좋게 정리 
-- FLOOR(소수점 아래 모두 버리기) 이용해서 정리
-- CEIL (올림 처리)
-- ROUND(반올림 처리)

SELECT EMP_NAME, HIRE_DATE,    FLOOR(SYSDATE - HIRE_DATE) AS 근무일수
FROM EMPLOYEE;
-- FLOOR(SYSDATE - HIRE_DATE) 입사일부터 현재까지의 차이를 계산하고 소수점 아래는 모두 버려 정수로 나타냄
-- 소수점 아래를 버림하는 이유는 반올림을할 경우 입사일이 하루 추가되므로 현재 입사해서 근무한 일자에 어긋남



-- EMPLOYEE 테이블에서 부서 코드가 D9 부서가 아닌 사원들만 컬럼을 모두 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';


--1. EMPLOYEE 테이블에서 연봉이 5000만원 이하인 사원의 사번, 이름, 연봉 조회
--  EMP_ID EMP_NAME SALARY * 12 AS 연봉
-- QUIZ WEHRE 절 요구사항에 맞게 작성
SELECT EMP_ID, EMP_NAME, SALARY * 12 AS 연봉
FROM EMPLOYEE
WHERE SALARY * 12 <= 50000000;

--2. EMPLOYEE 테이블에서 부서코드가 D6이 아닌 사원의 이름 부서코드 전화번호 조회
SELECT EMP_NAME, DEPT_CODE, PHONE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D6';




/*
WHERE 절에서  특정값의 기준을 설정할 때 특정 값의 범위나 조건을 설정

AND = 여러 조건을 동시에 만족하는 경우 로 AND로 작성한 조건이 모두 TRUE 이어야 함
OR = 하나의 조건만 TRUE이어도 해당 행이 선택

IN () = 조건에 여러값을 지정할 때 사용 값의 목록 중 하나와 일치하는 행을 선택  
        OR의 간결한 표현 방법
NOT IN () = IN과 반대로, 조건에서 지정한 목록에 포함되지 않는 값만 선택
            값의 목록과 일치하지 않는 행만 선택
*/

-- EMPLOYEE 테이블에서 부서코드가 D1,  D3 이 아닌 사원의 이름 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D3'
AND    DEPT_CODE != 'D1';

-- EMPLOYEE 테이블에서 부서코드가 D1 D3가 아닌 사원 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN('D1', 'D3');






