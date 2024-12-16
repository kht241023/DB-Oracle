--------------------------------------------------------
---------  MYSQL 데이터베이스 생성부터 유저 생성  ---------
--------------------------------------------------------



-- 1. CMD(명령프롬포트 창) mysql -u root -p
-- 초기에 설정한 mysql 비밀번호 입력 kht1234

-- 2. 데이터베이스 생성 : KHTSHOPPING, KHTUSER, KHTCAFE
---   CREATE DATABASE 데이터베이스명칭;
    CREATE DATABASE KHTSHOPPING;
    CREATE DATABASE KHTUSER;
    CREATE DATABASE KHTCAFE;


-- 3. 데이터베이스에 접속할 수 있는 유저 생성  %로 생성
   CREATE USER 'president'@'%' IDENTIFIED BY 'kht1234';

-- 4. 권한 모두 허용
   GRANT ALL PRIVILEGES ON KHTSHOPPING.* TO 'president'@'%';
   GRANT ALL PRIVILEGES ON KHTUSER.* TO 'president'@'%';
   GRANT ALL PRIVILEGES ON KHTCAFE.* TO 'president'@'%';

-- 5. 설정 적용
    FLUSH PRIVILEGES;


-- DATABASE 접속 KHTSHOPPING 데이터 베이스 접속 후  PRODUCT 테이블 생성 하고 생성 확인하기
USE KHTSHOPPING;


--  KHTSHOPPING 데이터베이스
--  쇼핑몰 관련 데이터베이스로 제품, 주문, 재고 등을 관리
CREATE TABLE PRODUCT (
    PRODUCT_ID INT AUTO_INCREMENT PRIMARY KEY,   -- 제품 ID (기본키)
    NAME VARCHAR(100) NOT NULL,                 -- 제품 이름
    DESCRIPTION TEXT,                           -- 제품 설명
    PRICE DECIMAL(10, 2) NOT NULL,              -- 가격
    STOCK INT NOT NULL,                         -- 재고 수량
    CATEGORY VARCHAR(50),                       -- 카테고리
    CREATED_AT DATETIME DEFAULT CURRENT_TIMESTAMP -- 등록 날짜
);

-- ORDER 는 SQL 예약어 ORDER BY 이름과 충돌나기 때문에 
-- 백틱(``)으로 감싸서 이름 사용
CREATE TABLE `ORDER` (
    ORDER_ID INT AUTO_INCREMENT PRIMARY KEY,    -- 주문 ID (기본키)
    USER_ID INT NOT NULL,                       -- 사용자 ID (외래키, KHTUSER.USER.USER_ID)
    ORDER_DATE DATETIME DEFAULT CURRENT_TIMESTAMP, -- 주문 날짜
    TOTAL_AMOUNT DECIMAL(10, 2) NOT NULL,       -- 총 금액
    STATUS ENUM('PENDING', 'SHIPPED', 'DELIVERED', 'CANCELLED') DEFAULT 'PENDING', -- 주문 상태
    SHIPPING_ADDRESS TEXT                       -- 배송 주소
);

CREATE TABLE ORDER_ITEM (
    ITEM_ID INT AUTO_INCREMENT PRIMARY KEY,     -- 주문 상세 ID (기본키)
    ORDER_ID INT NOT NULL,                      -- 주문 ID (외래키, ORDER.ORDER_ID)
    PRODUCT_ID INT NOT NULL,                    -- 제품 ID (외래키, PRODUCT.PRODUCT_ID)
    QUANTITY INT NOT NULL,                      -- 주문 수량
    PRICE DECIMAL(10, 2) NOT NULL,              -- 개별 제품 가격
    FOREIGN KEY (ORDER_ID) REFERENCES `ORDER`(ORDER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);

CREATE TABLE REVIEW (
    REVIEW_ID INT AUTO_INCREMENT PRIMARY KEY,   -- 리뷰 ID (기본키)
    PRODUCT_ID INT NOT NULL,                    -- 제품 ID (외래키, PRODUCT.PRODUCT_ID)
    USER_ID INT NOT NULL,                       -- 사용자 ID (외래키, KHTUSER.USER.USER_ID)
    RATING INT CHECK (RATING BETWEEN 1 AND 5),  -- 평점 (1~5)
    COMMENT TEXT,                               -- 리뷰 내용
    REVIEW_DATE DATETIME DEFAULT CURRENT_TIMESTAMP, -- 작성 날짜
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)
);

--  KHTUSER 데이터베이스
--  사용자 관련 데이터베이스로 회원 정보를 관리

USE KHTUSER;
CREATE TABLE USER (
    USER_ID INT AUTO_INCREMENT PRIMARY KEY,     -- 사용자 ID (기본키)
    USERNAME VARCHAR(50) NOT NULL,              -- 사용자 이름
    EMAIL VARCHAR(100) NOT NULL UNIQUE,         -- 이메일 (고유값)
    PASSWORD_HASH VARCHAR(255) NOT NULL,        -- 암호화된 비밀번호
    PHONE VARCHAR(15),                          -- 전화번호
    REGISTERED_AT DATETIME DEFAULT CURRENT_TIMESTAMP, -- 가입 날짜
    STATUS ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE' -- 계정 상태
);

CREATE TABLE ADDRESS (
    ADDRESS_ID INT AUTO_INCREMENT PRIMARY KEY,  -- 주소 ID (기본키)
    USER_ID INT NOT NULL,                       -- 사용자 ID (외래키, USER.USER_ID)
    ADDRESS_LINE TEXT NOT NULL,                 -- 주소
    CITY VARCHAR(50) NOT NULL,                  -- 도시
    POSTAL_CODE VARCHAR(10) NOT NULL,           -- 우편번호
    IS_DEFAULT BOOLEAN DEFAULT FALSE,           -- 기본 주소 여부
    FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID)
);

CREATE TABLE USER_ACTIVITY (
    ACTIVITY_ID INT AUTO_INCREMENT PRIMARY KEY, -- 활동 로그 ID (기본키)
    USER_ID INT NOT NULL,                       -- 사용자 ID (외래키, USER.USER_ID)
    ACTIVITY_TYPE ENUM('LOGIN', 'PURCHASE', 'REVIEW', 'UPDATE_PROFILE'), -- 활동 유형
    ACTIVITY_DATE DATETIME DEFAULT CURRENT_TIMESTAMP, -- 활동 날짜
    DETAILS TEXT                                -- 상세 내용
);

--  KHTCAFE 데이터베이스
-- 카페 관련 데이터베이스로 메뉴, 주문, 테이블 등을 관리

USE KHTCAFE;

CREATE TABLE MENU (
    MENU_ID INT AUTO_INCREMENT PRIMARY KEY,     -- 메뉴 ID (기본키)
    NAME VARCHAR(100) NOT NULL,                 -- 메뉴 이름
    DESCRIPTION TEXT,                           -- 메뉴 설명
    PRICE DECIMAL(10, 2) NOT NULL,              -- 가격
    CATEGORY ENUM('COFFEE', 'TEA', 'FOOD', 'DESSERT') -- 카테고리
);

CREATE TABLE TABLES (
    TABLE_ID INT AUTO_INCREMENT PRIMARY KEY,    -- 테이블 ID (기본키)
    TABLE_NUMBER INT NOT NULL UNIQUE,           -- 테이블 번호
    CAPACITY INT NOT NULL,                      -- 수용 인원
    STATUS ENUM('AVAILABLE', 'OCCUPIED') DEFAULT 'AVAILABLE' -- 테이블 상태
);


CREATE TABLE CAFE_ORDER (
    ORDER_ID INT AUTO_INCREMENT PRIMARY KEY,    -- 주문 ID (기본키)
    TABLE_ID INT NOT NULL,                      -- 테이블 ID (외래키, TABLES.TABLE_ID)
    ORDER_DATE DATETIME DEFAULT CURRENT_TIMESTAMP, -- 주문 날짜
    TOTAL_AMOUNT DECIMAL(10, 2) NOT NULL,       -- 총 금액
    STATUS ENUM('PENDING', 'PREPARING', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING', -- 주문 상태
    FOREIGN KEY (TABLE_ID) REFERENCES TABLES(TABLE_ID)
);


CREATE TABLE CAFE_ORDER_ITEM (
    ITEM_ID INT AUTO_INCREMENT PRIMARY KEY,     -- 주문 상세 ID (기본키)
    ORDER_ID INT NOT NULL,                      -- 주문 ID (외래키, CAFE_ORDER.ORDER_ID)
    MENU_ID INT NOT NULL,                       -- 메뉴 ID (외래키, MENU.MENU_ID)
    QUANTITY INT NOT NULL,                      -- 주문 수량
    PRICE DECIMAL(10, 2) NOT NULL,              -- 메뉴 가격
    FOREIGN KEY (ORDER_ID) REFERENCES CAFE_ORDER(ORDER_ID),
    FOREIGN KEY (MENU_ID) REFERENCES MENU(MENU_ID)
);






-- KHTSHOPPING 데이터베이스
USE KHTSHOPPING;
INSERT INTO PRODUCT (NAME, DESCRIPTION, PRICE, STOCK, CATEGORY) VALUES
('한국산 유기농 쌀', '100% 유기농 인증 받은 고품질 쌀', 20000, 50, '식품'),
('한정판 고급 텀블러', '스타일리시한 디자인과 실용성 겸비', 15000, 100, '주방용품'),
('울트라 게이밍 키보드', 'RGB 백라이트와 뛰어난 키감', 89000, 30, '전자제품'),
('천연 허브차 세트', '피로 회복에 좋은 허브차 5종', 25000, 200, '음료'),
('편안한 쿠션 의자', '장시간 사용해도 편안한 인체공학적 디자인', 120000, 15, '가구');

INSERT INTO `ORDER` (USER_ID, TOTAL_AMOUNT, STATUS, SHIPPING_ADDRESS) VALUES
(1, 50000, 'PENDING', '서울특별시 강남구 테헤란로 123'),
(2, 120000, 'SHIPPED', '경기도 성남시 분당구 불정로 45'),
(3, 89000, 'DELIVERED', '부산광역시 해운대구 센텀중앙로 78'),
(4, 25000, 'CANCELLED', '대구광역시 동구 팔공산로 56'),
(5, 20000, 'PENDING', '인천광역시 남동구 논현로 89');


INSERT INTO ORDER_ITEM (ORDER_ID, PRODUCT_ID, QUANTITY, PRICE) VALUES
(1, 1, 2, 20000),
(2, 5, 1, 120000),
(3, 3, 1, 89000),
(4, 4, 1, 25000),
(5, 1, 1, 20000);

INSERT INTO REVIEW (PRODUCT_ID, USER_ID, RATING, COMMENT) VALUES
(1, 1, 5, '쌀이 정말 맛있어요. 밥맛이 달라졌습니다!'),
(3, 2, 4, '키보드 키감이 훌륭하지만 소음이 약간 있습니다.'),
(4, 3, 5, '허브차가 향도 좋고 피로도 풀려서 만족합니다.'),
(2, 4, 3, '텀블러는 예쁘지만 약간 작아서 아쉽네요.'),
(5, 5, 4, '의자가 정말 편하고 허리가 안 아파요!');

COMMIT;

-- KHTUSER 데이터베이스
USE KHTUSER;
INSERT INTO USER (USERNAME, EMAIL, PASSWORD_HASH, PHONE, STATUS) VALUES
('홍길동', 'hong@example.com', 'hashed_password_1', '010-1234-5678', 'ACTIVE'),
('김영희', 'kim@example.com', 'hashed_password_2', '010-2345-6789', 'ACTIVE'),
('이철수', 'lee@example.com', 'hashed_password_3', '010-3456-7890', 'INACTIVE'),
('박민수', 'park@example.com', 'hashed_password_4', '010-4567-8901', 'ACTIVE'),
('최수지', 'choi@example.com', 'hashed_password_5', '010-5678-9012', 'ACTIVE');

INSERT INTO ADDRESS (USER_ID, ADDRESS_LINE, CITY, POSTAL_CODE, IS_DEFAULT) VALUES
(1, '서울특별시 종로구 세종대로 123', '서울', '03189', TRUE),
(2, '경기도 용인시 수지구 동천로 45', '경기', '16900', FALSE),
(3, '부산광역시 중구 남포대로 78', '부산', '48920', TRUE),
(4, '대구광역시 북구 산격로 56', '대구', '41422', TRUE),
(5, '광주광역시 동구 충장로 89', '광주', '61421', TRUE);

INSERT INTO USER_ACTIVITY (USER_ID, ACTIVITY_TYPE, DETAILS) VALUES
(1, 'LOGIN', '홍길동이 2024-12-16에 로그인했습니다.'),
(2, 'PURCHASE', '김영희가 주문 번호 2번을 완료했습니다.'),
(3, 'REVIEW', '이철수가 리뷰를 작성했습니다.'),
(4, 'UPDATE_PROFILE', '박민수가 프로필 정보를 수정했습니다.'),
(5, 'LOGIN', '최수지가 로그인에 성공했습니다.');


COMMIT;

-- KHTCAFE 데이터베이스

USE KHTCAFE;

INSERT INTO MENU (NAME, DESCRIPTION, PRICE, CATEGORY) VALUES
('아메리카노', '진한 에스프레소와 깔끔한 물의 조화', 4000, 'COFFEE'),
('카페라떼', '부드러운 우유와 에스프레소', 4500, 'COFFEE'),
('유자차', '달콤하면서도 상큼한 전통차', 5000, 'TEA'),
('초코 브라우니', '진한 초콜릿의 풍미를 느낄 수 있는 디저트', 3500, 'DESSERT'),
('치즈 케이크', '입안에서 살살 녹는 크림치즈 케이크', 5000, 'DESSERT');


INSERT INTO TABLES (TABLE_NUMBER, CAPACITY, STATUS) VALUES
(1, 4, 'AVAILABLE'),
(2, 2, 'OCCUPIED'),
(3, 6, 'AVAILABLE'),
(4, 4, 'OCCUPIED'),
(5, 2, 'AVAILABLE');

INSERT INTO CAFE_ORDER (TABLE_ID, TOTAL_AMOUNT, STATUS) VALUES
(2, 8500, 'PREPARING'),
(4, 13500, 'COMPLETED'),
(1, 5000, 'PENDING'),
(3, 15000, 'COMPLETED'),
(5, 4000, 'CANCELLED');



INSERT INTO CAFE_ORDER_ITEM (ORDER_ID, MENU_ID, QUANTITY, PRICE) VALUES
(1, 1, 2, 4000),
(2, 2, 1, 4500),
(3, 3, 1, 5000),
(4, 4, 3, 3500),
(5, 5, 1, 5000);

COMMIT ;

USE KHTCAFE;
SELECT * FROM MENU;

USE KHTSHOPPING;
SELECT * FROM PRODUCT;

USE KHTUSER;
SELECT * FROM USER;





/****************************************
************* SELECT 문  사용 *************
****************************************/

-- KHTUSER 데이터 베이스 -- 
-- USER TABLE 홍길동의 이메일주소와 전화번호 조회
USE KHTUSER;
SELECT EMAIL, PHONE
FROM USER
WHERE USERNAME = '홍길동';

-- KHTSHOPPING 데이터 베이스 -- 
-- `ORDER` 테이블 주문상태가 PENDING 인 주문 수를 조회 오직 주문수alter
USE KHTSHOPPING;
SELECT COUNT(*) 
FROM `ORDER`
WHERE STATUS = 'PENDING';



-- KHTCAFE 데이터 베이스 -- 
-- TABLES 테이블 AVAILABLE 상태인 테이블 번호와 수용 인원(CAPACITY) 조회
USE KHTCAFE;
SELECT TABLE_NUMBER, CAPACITY
FROM TABLES
WHERE STATUS = 'AVAILABLE';
-- MENU 테이블에서 가장 비싼 메뉴의 이름과 가격 조회
SELECT NAME, PRICE
FROM MENU
ORDER BY PRICE DESC
LIMIT 1;

-- CAFE_ORDER 테이블에서 SATUS 가 PREPARING 인 주문의 테이블 번호와 주문 금액 조회
SELECT TABLE_ID, TOTAL_AMOUNT
FROM CAFE_ORDER
WHERE STATUS = 'PREPARING';

-- KHTUSER 데이터 베이스에서 LOGIN 활동을 한 사용자들의 이름과 세부활동 정보 확인
-- JOIN ON
USE KHTUSER;
SELECT U.USERNAME, A.DETAILS
FROM USER_ACTIVITY A
JOIN USER U ON A.USER_ID = U.USER_ID
WHERE A.ACTIVITY_TYPE = 'LOGIN';


SELECT * FROM USER;

-- 홍길동 hong123 으로 변경 회원정보에서 비밀번호 변경하겠다 작성
-- UPDATE 테이블명 SET 컬럼명 = 수정할 내용  WHERE 조건과 일치하는 행의;
-- UPDATE 문을 SQL 에서 직접적으로 실행할 때 문제가 되는 것을 방지하기 위해 SAFE 모드 생성
-- 테이블을 삭제할 때도 마찬가지로 SAFE 모드이므로 SAFE MODE 해지 후 실행 가능
SET SQL_SAFE_UPDATES = 0;

-- SAFE MODE 재설정 
SET SQL_SAFE_UPDATES = 1;

UPDATE USER 
SET PASSWORD_HASH = 'hong123' 
WHERE USERNAME = '홍길동';

SELECT * FROM USER;

/*
김영희 kim7890
이철수 chulsoo5678
박민수 park245
최수지 choi9876
*/
UPDATE USER SET PASSWORD_HASH = 'kim7890' WHERE USERNAME = '김영희';
UPDATE USER SET PASSWORD_HASH = 'chulsoo5678' WHERE USERNAME = '이철수';
UPDATE USER SET PASSWORD_HASH = 'park245' WHERE USERNAME = '박민수';
UPDATE USER SET PASSWORD_HASH = 'choi9876' WHERE USERNAME = '최수지';
COMMIT;

USE KHTCAFE;
SELECT * FROM TABLES;

UPDATE TABLES
SET STATUS = '사용 가능'
WHERE TABLE_NUMBER = 1;

-- 테이블 자체 수정 tables
-- STATUS 안에는  AVAILABLE   OCCUPIED 삽입 가능 OK
-- enum('AVAILABLE','OCCUPIED')
-- CREATE TABLE SET  - CHECKBOX
-- CREATE TABLE ENUM - RADIO

-- 테이블자체 컬럼에 존재하는 규칙 수정
-- ALTER TABLE 수정할 테이블명칭 MODIFY COLUMN 컬럼명 컬럼명의 규칙
ALTER TABLE TABLES
MODIFY COLUMN STATUS ENUM('AVAILABLE', 'OCCUPIED', '사용 가능', '사용중');

UPDATE  TABLES
SET STATUS='사용중'
WHERE TABLE_NUMBER = 4;

SELECT * FROM TABLES;

COMMIT;

ALTER TABLE TABLES
MODIFY COLUMN STATUS ENUM('사용 가능', '사용중');

-- CAFE_ORDER 준비 중 완료 대기 중 취소
ALTER TABLE CAFE_ORDER
MODIFY COLUMN  STATUS ENUM('PENDING', 'PREPARING', 'COMPLETED', 'CANCELLED','준비 중','완료','대기 중','취소');


UPDATE CAFE_ORDER
SET STATUS = '준비 중', TOTAL_AMOUNT = 8500
WHERE TABLE_ID = 2;

UPDATE CAFE_ORDER
SET STATUS = '완료', TOTAL_AMOUNT = 13500
WHERE TABLE_ID = 4;  

UPDATE CAFE_ORDER
SET STATUS = '대기 중', TOTAL_AMOUNT = 5000
WHERE TABLE_ID = 1;

UPDATE CAFE_ORDER
SET STATUS = '완료', TOTAL_AMOUNT = 15000
WHERE TABLE_ID = 3;

UPDATE CAFE_ORDER
SET STATUS = '취소', TOTAL_AMOUNT = 4000
WHERE TABLE_ID = 5;




-- 테이블 삭제하고 다시 만들기
-- 종료 = 0  시작 = 1
-- 외래키 체크 종료
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS 테이블명칭;


-- 만약에 MENU 테이블이 잘못되어 삭제하길 원한다면
-- DROP TABLE IF EXISTS MENU;

-- 테이블 삭제 후 외래키 체크 시작 설정
SET FOREIGN_KEY_CHECKS = 0;


