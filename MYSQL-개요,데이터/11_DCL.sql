/*계정(사용자)

관리자 계정 : 데이터베이스의 생성과 관리를 담당하는 계정
            모든 권한과 책임을 가지는 계정
            ex)sys(최고관리자), system(sys에서 권한 몇개 제외된 관리자)
사용자 계정 : 데이터베이스에 대해서 질의, 갱신, 보고서 작성 등의
            작업을 수행할 수 있는 계정으로
            업무에 필요한 최소한의 권한만 가지는 것을 원칙으로 함
            ex) newbie(신입) 계정, staff, associate, seniorStaff
                각 직급에 맞는 권한만 가지는 것
*/

/*
DCL (Data Control Language) : 

계정에 DB, DB  객체에 대한 접근 권한을 부여하고 회수하는 언어

- GRANT  : 권한 부여
- REVOKE : 권한 회수

* 권한의 종류

1) 시스템 권한 : DB접속, 객체 생성 권한


CREATE SESSION : 데이터베이스 접속 권한
CREATE TABLE : 테이블 생성 권한
CREATE VIEW : 뷰 생성 권한
CREATE SEQUENCE : 시퀀스 생성 권한
CREATE PROCEDURE : 함수(프로시져) 생성 권한
CREATE USER : 사용자(계정) 생성 권한
DROP USER : 사용자(계정) 삭제 권한
DROPT ANY TABLE: 임의 테이블 삭제 권한

2) 객체 권한 : 특정 객체를 조작할 수 있는 권한

   권한 종류       설정 객체
    SELECT        TABLE, VIEW, SEQUENCE
    INSERT        TABLE, VIEW
    UPDATE        TABLE, VIEW
    DELETE        TABLE, VIEW
    ALTER         TABLE, SEQUENCE
    REFERENCES    TABLE
    INDEX         TABLE
    EXECUTE       PROCEDURE


*/

/* 관리자 계정 접속 후 유저 아이디 비밀번호 생성*/
CREATE USER '유저아이디'@'%' IDENTIFIED BY '유저비밀번호';
-- > 외부 컴퓨터에서 회사 DB에 접근 가능


CREATE USER '유저아이디'@'localhost' IDENTIFIED BY '유저비밀번호';
-- > 내부 컴퓨터에서 회사 DB에 접근 가능


/* 데이터베이스 생성 */
CREATE DATABASE 데이터베이스명칭;


/* 데이터베이스 접속 권한 */
-- 직급에 따른 접속 권한 부여
GRANT ALL PRIVILEGES ON 데이터베이스명칭.테이블명 TO  '유저명'@'호스트';
-- 테이블명에는 *(모든 테이블), 특정 테이블 명칭
--   호스트에는          %(모든 외부 컴퓨터), 
--              localhost(database가 존재하는 컴퓨터), 
--            192.168.0.1(현재 네트워크 내에 존재하는 컴퓨터) : 우리집 거실에 있는 컴퓨터
--            211.0.0.1(특정 ip 주소에서만 접근 가능)        : 개똥이네에서 우리집 DB 접속 가능
-- 계정   OWNER / NEWBIE

-- 예를 들어 KHCAFE / KHUSER 데이터베이스 존재하고,
-- 각 직급에 따라 데이터베이스 접속 권한 부여

GRANT ALL PRIVILEGES ON KHCAFE.menu TO 'NEWBIE'@'%';
-- > 새로운 신입 계정은 KHCAFE 데이터베이스에서 menu 테이블만 접근 가능

GRANT ALL PRIVILEGES ON KHCAFE.* TO 'OWNER'@'%';
-- > 소유자 계정은 KHCAFE 데이터베이스에서 menu, order, store 등 모든 테이블 접근 가능

/*   특정 권한을 선택해서 부여할 때는 PRIVILEGES 사용하지 않는다.
GRANT SELECT PRIVILEGES ON KHUSER.user TO 'NEWBIE'@'%';
*/
GRANT SELECT ON KHUSER.user TO 'NEWBIE'@'%';
-- > 신입 계정은 KHUSER 데이터베이스에서 user 테이블에서 SELECT 만 가능

-- JUNIOR 급 계정 부여
CREATE USER '유저아이디'@'%' IDENTIFIED BY '유저비밀번호';

GRANT SELECT, INSERT, UPDATE ON KHUSER.user TO 'JUNIOR'@'%';

-- GRANT 권한 부여
-- REVOKE 권한 회수

-- JUNIOR 가 이상한 행동을 하는 것 같음. 기존에 부여한 권한 중 INSERT UPDATE를 회수
REVOKE INSERT, UPDATE ON KHUSER.user TO 'JUNIOR'@'%';

--JUNIOR 가 이상한 행동을 보이는게 맞음! 혹시모르니 모든 권한 회수
REVOKE ALL PRIVILEGES ON KHUSER.* TO 'JUNIOR'@'%';