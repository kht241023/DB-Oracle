-- EMPLOYEE 테이블에서 부서코드, 부서(그룹) 별 급여 합계 조회
--	   /*어떤 그룹을 묶어서 조회할 것인지를 추가로 작성해줌*/
SELECT DEPT_CODE                                  , SUM(SALARY) , AVG(SALARY) --그룹 별로 월급합계 / 평균월급 조회
FROM EMPLOYEE     -- EMPLOYEE 테이블에서
GROUP BY DEPT_CODE; -- DEPT_CODE 컬럼 값이 같은 행들끼리 묶어서

-- EMPLOYEE 테이블에서 
-- 부서코드, 부서 별 급여의 합계, 부서 별 급여의 평균(정수처리), 인원수 조회하고
-- 부서코드 오름차순으로 정렬  
---- SUM FLOOR AVG COUNT
---- SELECT FROM GROUP BY ORDER BY

SELECT dept_code, SUM(salary), FLOOR(AVG(salary)), COUNT(*) AS 사원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


--– 1. EMPLOYEE 테이블에서 부서코드가 'D5', 'D6'인 부서의 평균 급여 조회
------ UPPER 함수는 문자열 하나를 변환하기 위해 사용, 다중 값 사용 불가
SELECT dept_code, FLOOR(AVG(salary)) AS 평균_급여
FROM EMPLOYEE
WHERE UPPER(DEPT_CODE) IN ('D5', 'D6')
GROUP BY dept_code;
--– 2. EMPLOYEE 테이블에서 직급 별 2000년도 이후 입사자들의 급여 합을 조회
------ WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000 -- 특정 날짜 열에서 년도만 가져오기
GROUP BY JOB_CODE;

--– 3. EMPLOYEE 테이블에서 부서 별로 같은 직급인 사원의 급여 합계를 조회하고
---- 부서 코드 오름차순으로 정렬  GROUP BY DEPT_CODE, JOB_CODE
----- sum이나 avg 같이 특정 함수로 계산한 결과를 나타낼 때 조회하고자 하는 컬럼명을 작성해줄경우
----- GROUP BY 절에 sum,avg 같이 계산 함수가 적용되지 않은 컬럼명을 모두 작성해줘야 함 
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE;


--– 4. EMPLOYEE 테이블에서 부서 별로 급여 등급이 같은 직원의 수를 조회하고
---- 부서코드, 급여 등급 오름차순으로 정렬 
------ GROUP BY DEPT_CODE, SAL_LEVEL
SELECT dept_code, sal_level, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, SAL_LEVEL
--  첫 번째로 부서코드 ABCD 순으로 정렬 , 부서 안에 존재하는 급여레벨 ABCD순으로 정렬
ORDER BY DEPT_CODE, SAL_LEVEL;




--– 5. EMPLOYEE 테이블에서 부서코드와 부서별 보너스를 받는 사원의 수를 조회하고
------ 부서코드 오름차순 정렬
SELECT dept_code, COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--– 6. EMPLOYEE 테이블에서 부서코드와 부서별 보너스를 받는 사원의 수를 조회하고
------ 부서코드 오름차순 정렬 null 인 행 빼고 카운트 카운트 함수 내부에 BONUS 작성하면
------- BONUS 컬럼명에서 null 값은 제외하고 수 측정을 진행함   null = 아무것도 들어있지 않은 빈 값
SELECT dept_code, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;



-- EMPLOYEE 테이블과 DEPARTMENT 테이블에서 부서코드 조회하기

SELECT * FROM EMPLOYEE; --emp_id emp_name dept_code 

SELECT * FROM DEPARTMENT; --dept_id dept_title, location_id

SELECT EMPLOYEE.emp_id, EMPLOYEE.emp_name, EMPLOYEE.dept_code, DEPARTMENT.DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT  --테이블 조회를 2개이상 가능
WHERE EMPLOYEE.dept_code = DEPARTMENT.DEPT_ID; 

SELECT E.EMP_ID, E.emp_name, E.JOB_CODE, n.JOB_NAME
FROM EMPLOYEE E, JOB n;

SELECT d.DEPT_ID, d.DEPT_TITLE, d.LOCATION_ID, l.LOCAL_NAME
FROM DEPARTMENT d, LOCATION l;

-- DEPARTMENT 테이블과 LOCATION 테이블 NATIONAL 테이블을 이용해서
-- DEPT_ID DEPT_TITLE LOCATION_ID NATIONAL_CODE NATIONAL_NAME 출력
-- WHERE 절 사용 -> 서로 같다는 표기를 2개 이상의 테이블에서 진행해야할 때는 WHERE절을 필수로 사용!
--- DEPARTMENT 테이블에서    LOCATION_ID 와 LOCATION 테이블에서 LOCAL_CODE 일치하고
---  LOCATION  테이블에서  NATIONAL_CODE 와 NATIONAL 테이블에서 NATIONAL_CODE 일치
SELECT D.DEPT_ID, D.DEPT_TITLE, D.LOCATION_ID, L.NATIONAL_CODE, N.NATIONAL_NAME
FROM DEPARTMENT D, LOCATION L, NATIONAL N
WHERE D.LOCATION_ID = L.LOCAL_CODE  
AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- 1. EMPLOYEE 테이블에서 각 부서에 속한 사원들에 평균 급여
--  평균급여 컬럼명은 [평균 급여] 표기
--- DEPT_CODE AVG(SALARY)
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) AS "평균 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2. EMPLOYEE 테이블에서 각 직급마다 급여가 가장 높은 사원의 이름과 급여 MAX(SALARY)
--- GROUP BY ORDER BY
-- JOB_CODE, EMP_NAME, 가장높은 사원의 급여
SELECT JOB_CODE, EMP_NAME, MAX(SALARY) AS "가장 높은 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE, EMP_NAME
ORDER BY JOB_CODE, MAX(SALARY) ASC;

-- 3. 부서별로 입사한 직원들의 평균 급여 GROUP BY
---GROUP BY
--- DEPT_CODE AVG(SALARY)
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) AS 평균급여
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 4. 부서이름이 인사관리부 인 직원의 이름 출력
--- WHERE AND 
---- TABLE : EMPLOYEE DEPARTMENT
SELECT EMP_NAME
FROM EMPLOYEE E,DEPARTMENT D
WHERE D.DEPT_ID = E.DEPT_CODE
AND D.DEPT_TITLE = '인사관리부';



-- 1. 이메일 주소가 등록된 직원의 이름과 부서명을 출력하시오.
---- WHERE e.DEPT_CODE = d.DEPT_ID 생략 가능
SELECT e.emp_name, d.DEPT_TITLE
FROM EMPLOYEE e, DEPARTMENT d
WHERE e.DEPT_CODE = d.DEPT_ID
AND e.EMAIL IS NOT NULL;

-- 2. 각 부서의 최고 급여를 출력하시오. (최고 급여 순)
SELECT emp_name, dept_code, max(salary)
FROM EMPLOYEE
GROUP BY DEPT_CODE, EMP_NAME
ORDER BY DEPT_CODE, MAX(SALARY) DESC;


-- 2-1. 각 부서의 최고 급여를 출력하시오. (부서별 최고 급여만 받는 사람 출력)
---- 서브쿼리가 추가
SELECT emp_name, dept_code, salary
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (
	SELECT dept_code, MAX(salary)
	FROM EMPLOYEE
	GROUP BY dept_code)
ORDER BY DEPT_CODE ;



	
	
-- 3. 각 급여 등급별 직원 수를 출력하시오.
SELECT  COUNT(*) AS "직원 수" FROM EMPLOYEE; -- 회사 내 총 직원 수

SELECT SALARY, COUNT(*) AS "직원 수" 
FROM EMPLOYEE
GROUP BY SALARY; -- 급여별로 동일한 금액을 받는 직원 수

-- 4. 부서 이름과 평균 급여를 급여가 높은 순으로 정렬 출력하시오.
SELECT DEPT_TITLE, AVG(SALARY) AS 평균급여
FROM EMPLOYEE, DEPARTMENT
/*WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID*/
GROUP BY DEPT_TITLE
ORDER BY AVG(SALARY) DESC;






-- 5. 지역별 부서 수를 출력하시오.
----COUNT(DISTINCT 컬럼명) : 특정 컬럼에서 중복 값을 제외한 행의 개수 반환
SELECT LOCATION_ID, COUNT(DISTINCT DEPT_ID) AS 부서수
FROM DEPARTMENT
GROUP BY LOCATION_ID;


-- 6. 각 부서(DEPT_CODE)별 보너스 비율(BONUS)의 평균을 구하되, 평균 보너스 비율이 높은 순으로 정렬
---- 부서의 평균 급여와 평균 보너스 비율을 계산한 뒤 
----- 보너스 평균 값 기준으로 오름차순으로 정렬하는 작업
------  부서코드       각 부서의 급여 평균 계산           부서의 보너스 비율 평균 계산
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) AS 평균급여, AVG(BONUS) AS 평균보너스비율
FROM EMPLOYEE, DEPARTMENT
GROUP BY DEPT_CODE
ORDER BY AVG(BONUS);



-- 7.각 부서(DEPT_CODE)별 평균 급여(SALARY)와 평균 보너스 비율(BONUS)을 조회하되, 부서명(DEPT_TITLE)을 기준으로 오름차순 정렬
SELECT DEPT_TITLE, FLOOR(AVG(SALARY)) AS 평균급여, AVG(BONUS) AS 평균보너스비율
FROM EMPLOYEE, DEPARTMENT
/*WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID*/
GROUP BY DEPT_TITLE
ORDER BY DEPT_TITLE/*ASC*/;

-- 8. 각 부서별 퇴사자 수를 조회하고, 퇴사자 수가 많은 순으로 정렬
SELECT DEPT_CODE, COUNT(*) AS 퇴사자
FROM EMPLOYEE
WHERE ENT_YN = UPPER('y')
GROUP BY DEPT_CODE
ORDER BY 퇴사자 DESC;






