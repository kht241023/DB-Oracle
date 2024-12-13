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
ORDER BY JOB_CODE, MAX(SALARY) DESC;

-- 3. 부서별로 입사한 직원들의 평균 급여 GROUP BY
---GROUP BY
--- DEPT_CODE AVG(SALARY)

-- 4. 부서이름이 인사관리부 인 직원의 이름 출력
--- WHERE AND 
---- TABLE : EMPLOYEE DEPARTMENT





















