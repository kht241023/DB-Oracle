/*
DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어

만들고(CREATE) 
수정하고(ALTER)
삭제(DROP)
등 데이터 전체 구조를 정의하는 언어로 주로 DB관리자, DB설계자가 사용함

MYSQL
DATABASE, USER, TABLE, VIEW, SEQUENCE, INDEX, PACKAGE, 
TRIGGER, PROCEDURE, FUNCTION, SYNONYM 등 생성

PRIMARY KEY = 기본, 기준이 되는 키,넣어줄 수는 있지만 같은값 존재 X
AUTO_INCREMENT = 자동으로 번호 증가 설정
*/

-- ALTER (바꾸다, 변조하다)
-- 수정 가능한 것 :컬럼(추가/수정/삭제), 제약조건(추가/삭제), 이름변경(테이블, 컬럼, 제약조건)

-- [작성법]
-- 테이블을 수정하는 경우
-- ALTER TABLE 테이블명 ADD|MODIFY|DROP 수정할내용;

---------------------------------------------------------------
-- 1. 제약조건 추가 / 삭제

ALTER TABLE 테이블명칭 ADD COLUMN 컬럼명 컬럼조건;

ALTER TABLE 테이블명칭 DROP COLUMN 컬럼명;

-- 2. 제약조건 수정
ALTER TABLE 테이블명칭 MODIFY COLUMN 컬럼명 컬럼조건;