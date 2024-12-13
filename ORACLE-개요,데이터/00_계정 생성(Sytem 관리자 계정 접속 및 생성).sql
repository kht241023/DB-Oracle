/* 범위 주석 ctrl + shift + / */
-- 한 줄 주석 ctrl + /
/* 

asterisk (*) : 모든, 포함하다 를 나타내는 기호 (ALL)

SQL 1개 실행 : CTRL + ENTER 
SQL 2개 이상 실행 : (블럭 드래그 후) ALT + X
CTRL + SPACE 나머지(컬럼명, 테이블명 등) 자동완성

SELECT FROM과 같은 SQL 구문은 대문자로 작성하는 것이 개발자들간의 구분 규칙
컬럼명이나 테이블명 과 같이 개발자가 조회를 원하는 단어나 기능은 소문자로 작성해주는 것이 좋음!!
*/

--sqlplus sys as sysdba; //관리자로 접속

--sqlplus = 오라클에서 만든 sql 로 접속할 수 있도록 연결하는 통로

--sys = System   as  sysdba = SystemDataBaseAdmin

ALTER SESSION SET "_ORACLE_SCRIPT"=true;
--└──────── 관리자로 접속해서 user 생성하고, 권한부여 ok?
--        기본으로 false로 되어있기 때문에 true
--        권한부여 및 유저 생성을 진행한다 => true 변경


CREATE      USER 사용자아이디 IDENTIFIED BY 비밀번호;
--생성하다 사용자를                   비밀번호설정

  GRANT       connect, resource, dba TO kht;
--권한부여     연결 ok   사용ok  dba(=관리자로서 모든 권한 부여)  TO 사용자아이디; 