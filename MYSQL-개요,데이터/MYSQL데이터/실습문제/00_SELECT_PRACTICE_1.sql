/*
USE DATABASE; 명칭은 
한 회사에서 여러 서비스를 제공하고 각 서비스에 따른 
데이터베이스에 접속할 때 사용하는 기능

예를 들어 KEKO 회사가 MALON, DEUM, KEKEOTALK 데이터를 관리할 때
MYSQL 회사 SQL을 이용해서 관리를 하고, 각 데이터 베이스에 유저가 접근하기 위해서는
1. 유저 아이디, 비밀번호로 접속
2. DEUM 데이터베이스에 접속해서 회원정보나 게시글관리 테이블 확인하길 원한다면
   USE DEUM;
   SELECT * FROM DEUM회원정보테이블;
   
   MALON 데이터베이스에 접속해서 회원정보, 음악목록 테이블 조회하길 원한다면
   USE MALON;
   SELECT * FROM MALON테이블;
   
   KEKEOTALK 데이터베이스 접속해서 회원정보, 대화목록 테이블 조회하길 원한다면
   USE KEKEOTALK;
   SELECT * FROM KEKEOTALK_USER;
   SELECT * FROM TALKLIST테이블;


*/

-- USE KHTDB 접속
USE KHTDB; -- 로그인 후 확인하고자하는 데이터베이스 명칭 작성한 후 사용하겠다 선언
-- SELECT INSERT UPDATE 와 같은 DML DDL DCL 구문은 대소문자 구분 x
-- 이외 데이터베이스 명칭, 유저명칭, 비밀번호 모두 대소문자 구분 O
-- 유저가 보고자하는 데이터베이스가 존재하지 않을 때 발생하는 Error Code: 1046. No database selected


CREATE TABLE USER (
    user_id INT PRIMARY KEY auto_increment,        -- 유저의 가입순서
    user_name VARCHAR(100) NOT NULL,  -- 유저 이름
    location VARCHAR(255),            -- 유저 주소
    contact_number VARCHAR(20)        -- 유저 연락처
);

select * from user;


INSERT INTO USER (USER_NAME, LOCATION, CONTACT_NUMBER)
 VALUES('홍길동', '서울시 강남구', '010-1234-5678');

-- 유저 2명 동시에 생성
INSERT INTO USER (USER_NAME, LOCATION, CONTACT_NUMBER)
 VALUES('고말숙', '서울시 영등포구', '010-2345-6789'),
       ('김철수', '서울시 송파구', '010-9876-5432');



COMMIT;


SELECT * FROM USER;

-- SELECT INSERT UPDATE DELETE 와 같은 QUERY 작업을 진행할 때 
-- 마침표(.) 대신 세미콜론(;)으로 쿼리 작성종료임을 나타냄
-- INSERT 를 이용해서 값 추가

-- 서울 강남구에 위치한 유저 찾기
SELECT *
FROM USER
WHERE LOCATION = '서울시 강남구';

-- 이순신 서울시 종로구 010-4567-8901
-- 최지훈 서울시 서초구 010-5677-8911
-- 정수민 서울시 강동구 010 6781-2345
-- 김태호 경기도 수원시 010-2222-3333
-- 이광수 인천시 남동구 010-4444-5555
-- 한 번에 추가 작성

INSERT INTO USER (USER_NAME, LOCATION, CONTACT_NUMBER)
VALUES('이순신', '서울시 종로구','010-4567-8901'),
('최지훈', '서울시 서초구','010-5677-8911'),
('정수민', '서울시 강동구','010 6781-2345'),
('김태호', '경기도 수원시','010-2222-3333'),
('이광수', '인천시 남동구','010-4444-5555');

COMMIT;

SELECT * FROM USER;
/*
0614:08:04select *  FROM USER  WHERE LOCATION = '서울시 강남구' LIMIT 0, 
1000Error Code: 1046. No database selected Select the default DB to be used by double-clicking its name in the SCHEMAS list in the sidebar.0.000 sec
*/

USE KHTDB; -- CTRL ENTER   1000Error Code: 1046.

-- 서울에 거주하는 사람 조회
-- SELECT *  FROM USER where LOCATION = '서울%'; 서울% 글자와 완전히 일치하는 조건만 조회하기
SELECT *  FROM USER where LOCATION LIKE '서울%';

-- 전화번호 중간에 4라는 숫자가 들어간 유저 조회
SELECT *
FROM USER
WHERE CONTACT_NUMBER LIKE '%44%';

-- 서울에 거주하지 않는 사람 조회 NOT LIKE
SELECT *
FROM USER
WHERE LOCATION NOT LIKE '%서울%';


-- USERPROFILE 테이블 생성
/*
--  USER_ID 기본키 자동증가           
-- USERNAME 문자열 빈 값 못 들어가게 설정  (50 BYTE)
--    EMAIL 문자열 빈 값 못 들어가게 설정  (100 BYTE)
   BIRTHDATE DATE
   ACCOUNT_BALANCE  DECIMAL(10,2)  정수 10글자, 소수점 2자리까지만 설정
   GENDER   ENUM('MAIL', 'FEMALE')
   HOBBIES SET('READING', 'SPORTS', 'RUNNING')


*/

-- Error Code: 1146. Table 'khtdb.userprofile' doesn't exist
-- khtdb 에 userprofile 이라는 테이블이 존재하지 않으므로 CREATE TABLE USERPROFILE 을이용해서
-- USERPROFILE 테이블을 생성하거나, 테이블 오타가 있는지 확인!
CREATE TABLE USERPROFILE(
	USER_ID INT primary KEY auto_increment,		-- 기본키, 자동으로 가입할 때 순차적으로 번호 증가 기입
    USERNAME varchar(50) NOT NULL,				-- 이름  (빈 칸 허용 불가)
    EMAIL    VARCHAR(100) NOT NULL,				-- 이메일 (빈 칸 허용 불가)
    BIRTHDATE DATE,								-- 생년월일(날짜)
    ACCOUNT_BALANCE decimal(10,2),				-- 계좌 잔액 (정수 10자리, 소수자리 2자리)
    GENDER ENUM('MALE', 'FEMALE'),				-- 성별 (남성, 여성 중 택 1)
    HOBBIES SET('READING', 'SPORTS', 'RUNNING')	-- 취미 (설정된 값 중 다중 선택)
);

INSERT INTO USERPROFILE (USERNAME, EMAIL, BIRTHDATE, ACCOUNT_BALANCE, GENDER, HOBBIES)
VALUES
    ('홍길동', 'hong1@example.com', '1990-01-01', 10000.50, 'MALE', 'READING'),
    ('김영희', 'kim1@example.com', '1995-02-15', 5000.00, 'FEMALE', 'SPORTS'),
    ('이철수', 'lee1@example.com', '1987-03-10', 2000.75, 'MALE', 'RUNNING'),
    ('박민수', 'park1@example.com', '1993-05-20', 7000.25, 'MALE', 'READING,SPORTS'),
    ('최수영', 'choi1@example.com', '1998-07-30', 8000.00, 'FEMALE', 'RUNNING'),
    ('정하나', 'jung1@example.com', '1990-09-10', 3000.40, 'FEMALE', 'READING'),
    ('한상민', 'han1@example.com', '1985-04-25', 6000.30, 'MALE', 'SPORTS,RUNNING'),
    ('안세정', 'oh1@example.com', '1992-12-12', 9000.00, 'MALE', 'READING'),
    ('윤미래', 'yoon1@example.com', '1988-08-08', 4000.00, 'FEMALE', 'SPORTS'),
    ('장동건', 'jang1@example.com', '1991-11-11', 7500.50, 'MALE', 'RUNNING'),
    ('고은아', 'ko1@example.com', '1996-06-06', 3000.00, 'FEMALE', 'READING,SPORTS'),
    ('황보영', 'hwang1@example.com', '1994-03-03', 8500.75, 'FEMALE', 'RUNNING'),
    ('임채연', 'lim1@example.com', '1997-05-15', 2000.25, 'FEMALE', 'READING'),
    ('백승호', 'baek1@example.com', '1989-10-10', 6000.00, 'MALE', 'SPORTS'),
    ('송지효', 'song1@example.com', '1993-02-02', 9500.50, 'FEMALE', 'READING,RUNNING'),
    ('조세호', 'cho1@example.com', '1995-07-07', 1500.75, 'MALE', 'SPORTS'),
    ('이광수', 'lee2@example.com', '1991-09-09', 8000.00, 'MALE', 'RUNNING'),
    ('김나영', 'kim2@example.com', '1986-12-01', 7000.25, 'FEMALE', 'READING'),
    ('박지성', 'park2@example.com', '1988-01-01', 5000.75, 'MALE', 'SPORTS,RUNNING'),
    ('유재석', 'yoo1@example.com', '1987-05-05', 10000.00, 'MALE', 'READING,SPORTS');


-- 테이블 삭제 * 주의 테이블삭제 함부로 하지말것 반드시 혼자하더라도 상의 후 삭제할 것
-- 테이블 삭제 = DROP TABLE   테이블 내 데이터 삭제 
-- DELETE FORM 테이블명 WHERE = 테이블에서 하나의 행 삭제할 조건;
-- Error Code: 1051. Unknown table 'khtdb.userprofile' 테이블이 존재하지 않기 때문에 삭제 불가
DROP TABLE USERPROFILE;
DELETE FROM USERPROFILE; -- 테이블 내 모든 데이터 삭제 하나의 데이터만 삭제하길 원한다면 WHERE
SELECT * FROM USERPROFILE;


-- 이광수 삭제 PRIMARY KEY 가 걸려있으면 프라이머리 키 까지 모두 작성
DELETE FROM USERPROFILE WHERE USERNAME = '이광수' AND USER_ID = 17;