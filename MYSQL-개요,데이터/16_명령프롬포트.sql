/*
초기에 SQL 문을 명령 프롬포트(CMD) 창에서 작성 후 출력 결과 수정 확인
개발자가 눈으로 직관적으로 확인할 화면 필요
MYSQL - MYSQL WORKBENCH
ORACLE - ORACLE DEVELOPER

DBEAVER - 모든 SQL 회사 통합 화면 프로그램

처럼 UI(USER INTERFACE) 화면이 구현된 프로그램이 개발되어 SQL 개발을 편하게 할 수 있도록 제공


초기 접속 명령어
Microsoft Windows [Version 10.0.19045.5247]
(c) Microsoft Corporation. All rights reserved.

C:\Users\user1> mysql -u 유저명 -p
유저명 초기에는 root 사용해서 접속

특정 데이터 베이스 접속
C:\Users\user1> mysql -u 유저명 -p 데이터베이스명

-- 데이터베이스 관련 명령어
SHOE DATABASES;           -- 데이터베이스 목록 확인
USE 데이터베이스이름;       -- 특정데이터베이스로 접속
SHOW TABLES;              -- 특정 데이터베이스 내에 존재하는 테이블들 목록 확인
SHOW COLUMNS FROM 테이블명 -- 특정 테이블 내에 컬럼 구조 확인


이외 CREATE ~ DELETE COMMIT 등 모든 명령어 사용 가능
; 세미콜론 작성하기 전까지 이어서 쿼리 작성 가능

mysql 종료하길 원한다면 exit를 작성하거나 오른쪽 위에 있는 x표시 누르면 종료 가능



아래  ↓  명령 프롬포트에서 mysql 사용 예제





mysql> use khtdb;
Database changed
mysql> select * from user;
+---------+-----------+-----------------+----------------+
| user_id | user_name | location        | contact_number |
+---------+-----------+-----------------+----------------+
|       1 | 홍길동    | 서울시 강남구   | 010-1234-5678  |
|       2 | 고말숙    | 서울시 영등포구 | 010-2345-6789  |
|       3 | 김철수    | 서울시 송파구   | 010-9876-5432  |
|       4 | 이순신    | 서울시 종로구   | 010-4567-8901  |
|       5 | 최지훈    | 서울시 서초구   | 010-5677-8911  |
|       6 | 정수민    | 서울시 강동구   | 010 6781-2345  |
|       7 | 김태호    | 경기도 수원시   | 010-2222-3333  |
|       8 | 이광수    | 인천시 남동구   | 010-4444-5555  |
|       9 | 강정식    | 서울시 중랑구   | 010-5558-6666  |
+---------+-----------+-----------------+----------------+
9 rows in set (0.00 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| khtdb              |
| performance_schema |
+--------------------+
3 rows in set (0.00 sec)

mysql> SHOW TABLES;
+-----------------+
| Tables_in_khtdb |
+-----------------+
| employee        |
| user            |
| userprofile     |
+-----------------+
3 rows in set (0.00 sec)

mysql> DESCRIBE USER;
+----------------+--------------+------+-----+---------+----------------+
| Field          | Type         | Null | Key | Default | Extra          |
+----------------+--------------+------+-----+---------+----------------+
| user_id        | int          | NO   | PRI | NULL    | auto_increment |
| user_name      | varchar(100) | NO   |     | NULL    |                |
| location       | varchar(255) | YES  |     | NULL    |                |
| contact_number | varchar(20)  | YES  |     | NULL    |                |
+----------------+--------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> SHOW COLUMNS FROM USER;
+----------------+--------------+------+-----+---------+----------------+
| Field          | Type         | Null | Key | Default | Extra          |
+----------------+--------------+------+-----+---------+----------------+
| user_id        | int          | NO   | PRI | NULL    | auto_increment |
| user_name      | varchar(100) | NO   |     | NULL    |                |
| location       | varchar(255) | YES  |     | NULL    |                |
| contact_number | varchar(20)  | YES  |     | NULL    |                |
+----------------+--------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

mysql> exit
Bye

C:\Users\user1>
*/