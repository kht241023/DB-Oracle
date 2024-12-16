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

-- CREATE
-- 테이블이나 인덱스, 뷰 등 다양한 데이터 베이스를 생성하는 구문
-- 테이블로 생성된 객체는 DROP 구문을 통해 제거할 수 있음


-- 1. 테이블  생성하기
-- 테이블이란?
-- 행(ROW) 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
-- 데이터베이스 내에서 모든 데이터는 테이블을 통해 저장

-- [표현식]
/*
CREATE TABLE 테이블명(
컬럼명 PRIMARY KEY AUTO_INCREMENT,
컬럼명 자료형(크기),
컬럼명 자료형(크기),
컬럼명 자료형(크기) DEFAULT 기본값 설정
...
)

-- DEFAULT ( =기본값) : 컬럼의 기본 값 지정 (필수 아님)
--> INSERT UPDATE 시 해당 컬럼에 값을 넣지 않으면 지정한 기본값이 들어간다.


*/