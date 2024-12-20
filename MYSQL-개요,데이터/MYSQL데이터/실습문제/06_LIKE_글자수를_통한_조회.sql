use khtuser;

select * from user;


select * from order_item;

-- null data 생성

use khtshopping;

select * from snack;
select * from snack_order;


-- COALESCE
-- 컬럼에 NULL 값이 존재할 경우 NULL 을 0으로 대체해서 합계 계산

SELECT  STOCK    FROM   SNACK;
/*
50
30
NULL -> 0으로 변경해서 합 계산
40
20
*/

SELECT  coalesce(STOCK, 0)    FROM   SNACK;

-- >COALESCE 이용해서 STOCK 합 을 조회 SUM
SELECT  SUM(  COALESCE(STOCK, 0)  ) FROM SNACK;


-- > NULL 값을 5로 대체해서 SNACK_ORDER QUANTITY SUM(합) 조회

SELECT SUM(  COALESCE(QUANTITY, 5)       ) FROM SNACK_ORDER;

-- SNACK 테이블에서 카테고리별 재고 합계   
-- SELECT CATEGORY    STOCK --->  NULL -> 0 
select category, sum(coalesce(stock, 0) )
from snack
group by category;



-- SNACK_ORDER 테이블에서 상태별 주문량 합계
-- SELECT SATAUS   QUANTITY  --->  NULL -> 0
SELECT STATUS, SUM(COALESCE(QUANTITY, 0))
FROM SNACK_ORDER
GROUP BY STATUS;


-- VIEW 테이블을 이용해서 view_status_null 가상 테이블명칭을 사용해서
-- view 테이블로 위에 작성한 SNACK_ORDER 테이블에서 상태별 주문량 합계를 저장

CREATE VIEW view_status_null AS
SELECT STATUS, SUM(COALESCE(QUANTITY, '0'))
FROM SNACK_ORDER
GROUP BY STATUS;


SELECT * FROM view_status_null;


CREATE VIEW view_status_null AS
SELECT STATUS, COALESCE(STATUS, '없음'), SUM(COALESCE(QUANTITY, '0'))
FROM SNACK_ORDER
GROUP BY STATUS;
-- error code 1050 Table view status null aleady exists

DROP VIEW view_status_null; 

CREATE VIEW view_status_null AS
SELECT STATUS, COALESCE(STATUS, '없음'), SUM(COALESCE(QUANTITY, '0'))
FROM SNACK_ORDER
GROUP BY STATUS;

CREATE OR REPLACE VIEW view_status_null AS
SELECT STATUS, COALESCE(STATUS, '없음'), SUM(COALESCE(QUANTITY, '0'))
FROM SNACK_ORDER
GROUP BY STATUS;

-- ORACLE COALESCE 대신 NVL NULL 값을 특정 값을 대체

SELECT * FROM PRODUCT;

-- 한으로 시작하는 상품명 찾아 조회하기
SELECT NAME
FROM PRODUCT
WHERE NAME LIKE '한%';

-- 한으로 끝나는 상품명 찾아 조회하기
SELECT NAME
FROM PRODUCT
WHERE NAME LIKE '%한';

-- 한이 중간에 존재하는 상품명 찾아 조회하기
SELECT NAME
FROM PRODUCT
WHERE NAME LIKE '%한%';

-- LIKE 글자수도 지정해서 조회   '_'
-- 끝말잇기 할 때 제한 : 두 글자 단어만 가능

-- 한으로 시작하고 한 글자 뒤에 2글자만 있는 문자열
SELECT NAME
FROM PRODUCT
WHERE NAME LIKE '한________';
--               한국산 유기농 쌀

SELECT NAME
FROM PRODUCT
WHERE NAME LIKE '한_________';
--               한정판 고급 텀블러


SELECT NAME
FROM PRODUCT;



USE KHTUSER;

SELECT * FROM USER;


-- @앞에 글자가 9글자인 USERNAME 조회
select *
from user
where email LIKE '_________@%';

select username
from user
where email like '_________@%';
















