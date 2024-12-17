use khtshopping;


select * from product;
select * from review;

select * from `order`;
/*
PENDING -> 대기
SHIPPED -> 배송 중
DELIVERED -> 배송 완료
CANCELLED -> 취소
변경 
1) safe_update = 0;
2) alter status 변경
3) update작성
*/


SET SQL_SAFE_UPDATES = 0;
ALTER TABLE `ORDER` 
MODIFY COLUMN 
STATUS ENUM ('PENDING','SHIPPED','DELIVERED','CANCELLED','대기','배송 중','배송 완료','취소');

UPDATE `ORDER` SET STATUS = '취소' WHERE USER_ID =4;

COMMIT;
ALTER TABLE `ORDER` 
MODIFY COLUMN 
STATUS ENUM ('대기','배송 중','배송 완료','취소') default '대기';

SET SQL_SAFE_UPDATES = 1;

select * from `ORDER`;

USE KHTUSER;
SELECT * FROM USER;

-- 이메일주소 도메인이 example.com -> kht.co.kr 변경
-- CONCAT SUBSTRING SUBSTRING_INDEX 이용해서 변경
-- LIKE로 일치하는지 확인 후 변경


SELECT CONCAT('Hello', ' ', 'World','!'); -- CONCAT 이어붙여 출력되는지 확인

SELECT substring_index('user@example.com', '@', 1); -- user


SELECT substring_index('user@example.com', '@', -1); -- example.com

SELECT CONCAT(     substring_index('user@example.com', '@', 1)         , '@kht.com'                 );


/*
ERROR CODE : 1241 잘못된 문법으로 문자열 처리를 시도했기 때문에 발생한 에러코드
ERROR CODE : 1175 SAFE UPDATE MODE 비활성화
    -> 1번 EDIT -> Preferences -> SQL Editor -> 맨 밑에 Safe Updates(reject Update and Delete ~~~) 비활성화
    또는
    -> 2번 SET SQL_SAFE_UPDATES = 0;
*/
SET SQL_SAFE_UPDATES = 0;
UPDATE USER
SET EMAIL =  CONCAT( substring_index(EMAIL, '@', 1)         , '@kht.com'         );

-- USER 테이블에서 전화번호 앞에 +82) 를 붙여주기
-- 최종 PHONE +82)010-XXXX-XXXX
/*
ERROR CODE : 1406 : 컬럼이 VARCHAR(20)또는 그보다 작은 길이로 정의된 경우 새로운 값이 길이 제한을 넘어서기 때문에 발생하는 에러
컬럼에 존재하는 길이 늘리기

*/

CREATE TABLE USER (
    USER_ID INT AUTO_INCREMENT PRIMARY KEY,     -- 사용자 ID (기본키)
    USERNAME VARCHAR(50) NOT NULL,              -- 사용자 이름
    EMAIL VARCHAR(100) NOT NULL UNIQUE,         -- 이메일 (고유값)
    PASSWORD_HASH VARCHAR(255) NOT NULL,        -- 암호화된 비밀번호
    PHONE VARCHAR(15),                          -- 전화번호 010-XXXX-XXXX 총 13자리 +82)   총 17자리가 되므로 17를 넘어섬
    REGISTERED_AT DATETIME DEFAULT CURRENT_TIMESTAMP, -- 가입 날짜
    STATUS ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE' -- 계정 상태
);

ALTER TABLE USER modify COLUMN PHONE VARCHAR(20);




SELECT * FROM USER;

ROLLBACK;

COMMIT;



START transaction; -- 트랜잭션 개념 ACID 개념이해가 더 중요함
UPDATE USER 
SET PHONE = CONCAT('+082)', PHONE);

--  +082) 지우기  
UPDATE USER SET PHONE = substring_index(PHONE, ')',-1);
SAVEPOINT SP1;
UPDATE USER
SET PHONE = CONCAT('KOR)', PHONE);
SELECT * FROM USER;
-- CONCAT 이용하고 ) 기준으로해서 지우기 KOR)010-xxxx-xxxx 이런식으로 맨 앞에 KOR) 붙이기
UPDATE USER 
SET PHONE = CONCAT('KOR)', SUBSTRING_INDEX(PHONE, ')', -1));

-- SAVEPOINT "SP1";
-- ROLLBACK 이용해서 "SP1"되돌리기

ROLLBACK TO SP1;

SELECT * FROM USER;



-- 과제 ROLLBACK SAVEPOINT -> JAVA 프로그램을 더 많이 활용하지 않는다는 얘기.







