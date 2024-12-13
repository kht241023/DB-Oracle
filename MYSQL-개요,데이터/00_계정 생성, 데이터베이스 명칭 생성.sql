/*
cmd(명령 프롬포트 창) 에서 mysql 데이터베이스명칭, 유저생성, 권한설정 접속
mysql -u root -p
초기에 mysql 설치할 때 비밀번호 작성

-- 회사 내에서 TABLE 과 QUERY 저장을 위한 데이터베이스 명칭 설정
CREATE DATABASE 데이터베이스명칭;

-- 데이터베이스에 접속할 수 있는 유저 생성
CREATE USER '유저아이디'@'%' IDENTIFIED BY '비밀번호';
'%'        = 자바에서 public 같은 개념으로 어떤 컴퓨터에서든 접근 가능
'localhost'= 자바에서 private 같은 개념으로 현재 사용하는 컴퓨터에서만 접근 가능

권한허용   모든  특권            데이터베이스.* = 내에 있는 모든 테이블 접근 ok    어떤 계정에 권한을 부여하는가
GRANT     ALL PRIVILEGES ON 데이터베이스명칭.*                                   TO '계정명칭'@'%';

특권 적용
FLUSH PRIVILEGES;
*/
-- 주의할점 : 데이터베이스명칭, 유저명, 유저비밀번호는 대소문자 띄어쓰기 모두 구분
CREATE DATABASE 데이터베이스명칭;
CREATE USER '유저명'@'%' IDENTIFIED BY '유저비밀번호';
GRANT ALL PRIVILEGES ON 데이터베이스명칭.* TO '유저명'@'%';
FLUSH PRIVILEGES;