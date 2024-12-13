-- 카페 테이블 조회
SELECT * FROM CAFE;

-- 메뉴 테이블 조회
SELECT * FROM MENU;

SELECT *
FROM MENU
ORDER BY PRICE DESC;


SELECT DESCRIPTION, MENU_NAME, PRICE
FROM MENU M
WHERE PRICE >= 5000
ORDER BY PRICE;

SELECT menu_name
FROM MENU 
WHERE menu_name LIKE '%라떼%';



-- 1. menu 테이블에서 메뉴 이름에 '아이스'가 포함된 메뉴의 이름과 가격 출력
SELECT MENU_NAME, PRICE
FROM MENU
WHERE MENU_NAME LIKE '%아이스%';

-- 2. MENU 테이블에서 4000원 이상 6000원 이하인 메뉴를 출력
SELECT MENU_NAME, PRICE
FROM MENU
WHERE PRICE BETWEEN 4000 AND 6000;
/*
WHERE PRICE >= 4000
AND PRICE <= 6000;
*/
-- 3. 빼달의민족에서 카페라떼 메뉴가 존재하는 카페 이름을 조회
------	 카페라떼 메뉴가 들어간 카페이름 조회 CAFE 테이블 MENU 테이블
SELECT C.CAFE_NAME
FROM CAFE C, MENU M
WHERE M.MENU_NAME LIKE '%카페라떼%';
--- WHERE M.MENU_NAME = '카페라떼';
--- ORACLE의 경우 LIKE를 사용하지 않아도 원하는 검색을 통해 조회 가능

-- 4. MENU 테이블에서 메뉴 설명에 달콤이 포함된 메뉴의 이름과 설명 조회
SELECT MENU_NAME
FROM MENU
WHERE DESCRIPTION LIKE '%달콤%';

--5. MENU테이블 메뉴 설명이 없는 메뉴 
SELECT MENU_NAME, DESCRIPTION
FROM MENU
WHERE DESCRIPTION IS  NULL; -- 다행히 메뉴설명이 모두 존재함 확인!

--6. CAFE테이블 카페 이름이 '로스터리 카페' 인 카페의 위치 출력
SELECT LOCATION
FROM CAFE
WHERE CAFE_NAME LIKE'%로스터%'
AND CAFE_NAME LIKE '%카페%';

--7. CAFE MENU 서울 강남구에 위치한 카페에서 판매하는 메뉴 이름 출력
SELECT MENU_NAME
FROM CAFE C, MENU M
WHERE LOCATION='서울 강남구';

-- GROUP BY &&&& HAVING 절
-- CAFE MENU 테이블 --
--- 1. 각 카페에서 판매하는 메뉴의 평균 가격 출력 

------ WHERE 절 존재 O = 카페테이블과 메뉴 테이블에서 cafe_id가 일치하는
------- 행만 고려해서 평균 가격 계산
SELECT c.CAFE_NAME, FLOOR(AVG(m.PRICE))
FROM CAFE C, MENU M
WHERE c.CAFE_ID = m.CAFE_ID
GROUP BY c.CAFE_NAME;


------ WHERE 절 존재 X = 모두 더하고 모든 결과 조회
------- 모든조합에 대한 결과 모두 더하고 모두 평균
------- 카페테이블에 존재하는 카페 아이디와 메뉴테이블에 존재하는 카페아이디 
------- 일치여부 상관 없이
SELECT c.CAFE_NAME, FLOOR(AVG(m.PRICE))
FROM CAFE C, MENU M
--WHERE c.CAFE_ID = m.CAFE_ID
GROUP BY CAFE_NAME;





--- 2. 메뉴 가격의 합계가 15000원 이상인 카페 이름 출력
SELECT CAFE_NAME, SUM(PRICE)
FROM CAFE C, MENU M
WHERE C.CAFE_ID = m.CAFE_ID
GROUP BY CAFE_NAME
HAVING SUM(PRICE) >= 15000;

--- 3. 카페 별 메뉴의 최고 가격 출력 CAFE_NAME  MAX PRICE
SELECT c.CAFE_NAME, MAX(m.PRICE)
FROM CAFE c,MENU m
WHERE C.CAFE_ID = m.CAFE_ID
GROUP BY CAFE_NAME;-- SUB QUERY 를 작성하면 더  상세한 조회가 가능

--- 4. 메뉴가 3개 이상인 카페의 이름 HAVING  MENU_ID
SELECT c.CAFE_NAME
FROM CAFE c, MENU m
WHERE C.CAFE_ID = m.CAFE_ID
GROUP BY c.CAFE_NAME
HAVING COUNT(m.MENU_ID) >= 3;


-- ORDER BY 문  길이 = LENGTH(컬럼명)
--- MENU 테이블
---- 1. 메뉴 가격이 높은 순으로 메뉴이름과 가격 출력
SELECT menu_name, price
FROM MENU
ORDER BY price DESC;

---- 2. 메뉴 가격이 낮은 순으로 메뉴이름과 가격 출력
SELECT menu_name, price
FROM MENU
ORDER BY PRICE ASC;

---- 3. 메뉴 이름의 길이를 기준으로 오름차순 정렬
SELECT menu_name
FROM menu
ORDER BY LENGTH(menu_name);

--- CAFE 테이블
---- 4. 카페 이름을 가나다 순으로 정렬해서 출력
SELECT cafe_name
FROM CAFE
ORDER BY CAFE_NAME;

---- 5. 카페 이름의 길이를 기준으로 내림차순 정렬
--- CAFE MENU
SELECT cafe_name
FROM CAFE
ORDER BY LENGTH(cafe_name) DESC;
---- 6. 메뉴 가격이 같은 메뉴는 카페이름순으로 정렬해서 출력
----- ORDER BY PRICE CAFE_NAME

SELECT m.menu_name, m.price, c.cafe_name
FROM MENU M, CAFE C
WHERE m.CAFE_ID = c.CAFE_ID
ORDER BY m.price ASC, c.CAFE_NAME ASC;

-- 카페이름과 각 카페의 총 메뉴 수 조회 
SELECT c.CAFE_NAME, COUNT(m.MENU_ID)
FROM MENU M, CAFE C
-- where 없으면 카르테시안 곱으로 인해 모든 행과 열을 합산한 값이 모두 적용
WHERE m.CAFE_ID = c.CAFE_ID
GROUP BY c.CAFE_NAME;


-- 가격이 6000원 이상인 메뉴의 이름과 카페이름을 출력
SELECT m.menu_name, c.cafe_name, m.PRICE
FROM MENU M, CAFE C
WHERE m.CAFE_ID = c.CAFE_ID
AND m.price >= 6000;


/************************************************
 *************** SUBQUERY 서브 쿼리 ***************
 ************************************************/

-- 서브쿼리 예시 1.
--- 부서코드가 노옹철사원과 같은 소속의 직원들의 이름과 부서코드 조회하기

---- 1) 사원명이 노옹철인 사람의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME= '노옹철'; --'D9'

---- 2) 부서코드가 D9인 직원을 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; -- D9 = 선동일 송종기 노옹철 

---- 3) 부서코드가 노옹철사원가 같은 소속의 직원 명단 조회
------ 쿼리결과  D9 = 선동일 송종기 노옹철 
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--                노옹철 이름으로 D9 부서가 나오게 조회
WHERE DEPT_CODE = (SELECT DEPT_CODE
					FROM EMPLOYEE
					WHERE EMP_NAME= '노옹철')	 ;

-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원이 사번, 이름, 직급코드, 급여 조회하기
				
--- 1) 전 직원의 평균 급여 조회
SELECT AVG(SALARY) FROM EMPLOYEE; --3047662
--- 2) 직원들 중에서 급여가 평균급여(3047662원) 이상인 사원들의
----- 사번, 이름, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=3047662;
--- 3) 전 직원의 평균 급여(3047662원)보다 많은 급여를 받고 있는 직원 조회
---- WHERE절에서 1번 조회결과로 나온 평균급여 보다 높은 사람 조회하기
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);
				
-- 부서별 평균 급여 조회 부서코드, 평균 급여 조회
--1) 부서별로 직원의 급여 평균을 계산하기 위해 필요한 데이터 조회
SELECT DEPT_CODE
FROM EMPLOYEE EM
GROUP BY DEPT_CODE;

--2) 부서별 평균 급여 계산 각 부서 코드에 알맞는 부서별 평균급여 계산
SELECT AVG(SALARY)
FROM EMPLOYEE ES
WHERE DEPT_CODE='D9';

--3) 최상
SELECT DEPT_CODE,(
					SELECT AVG(SALARY)
					FROM EMPLOYEE ES
					WHERE EM.DEPT_CODE=ES.DEPT_CODE) AS "평균급여"
FROM EMPLOYEE EM
GROUP BY DEPT_CODE;









