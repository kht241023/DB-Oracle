-- 1. 시퀀스 생성 = 자동으로 증가하는 고유하는 값을 제공할 수 있도록 함
-- 테이블에서 데이터를 사용할 때 기본키에 회원가입한 순서를 작성
-- 사용법 CREATE SEQUENCE 시퀀스이름          START WITH     1 INCREMENT BY 1;
--       생성하다  시퀀스를 시퀀스이름설정   몇 번부터 시작할 것인가    증가 숫자
-- 예를 들어 CREATE SEQUENCE 먹고간다  START WITH 100 INCREMENT BY 1; 
--			먹고가는 사람 수를 100 번부터  100, 101, 102, ... 순차적으로 먹고간 인원 체크
--         CREATE SEQUENCE 가져간다  START WITH 700 INCREMENT BY 1;
--			가져가는 사람 수를 700 번 부터 700, 701, 702, ... 순차적으로 가져간 인원 체크


CREATE SEQUENCE seq_user; -- START WITH 1 INCREMENT BY 1 이 기본값으로 설정

-- 테이블 생성 USER 예약어 이기 때문에 TABLE 명으로 작성할  경우 `` 이나 "" 로 만들기
-- ORACLE = ""  MYSQL = `` 으로 테이블명 설정
CREATE TABLE student(
	studentid NUMBER PRIMARY KEY,
	studentname    VARCHAR2(100),
	studentage     NUMBER
);


-- 2. 트리거 생성 = 데이터 삽입 시 시퀀스를 자동으로 활용할 수 있도록 설정
-- 트리거를 이용해서 테이블에 새로운 숫자값이 삽입될 때 시퀀스에 저장된 번호를 호출해서 ID값을 자동 설정
-- 무엇을 만들거나 수정하거나 삭제할떼 OR REPLACE 사용하면 새로 만들거나 존재하면 덮어쓰기
CREATE OR REPLACE TRIGGER trg_user
BEFORE INSERT ON student
FOR EACH ROW
BEGIN
	-- 시퀀스를 사용해서 student 테이블 내에 studentid 번호를 자동으로 생성
	:NEW.studentid = seq_user.NEXTVAL;
END;
/

-- student 테이블에 학생 정보를 저장하려한다.
-- studentid를 명시하지 않고, 자동으로 증가하는 값으로 학생을 저장하기
-- INSERT INTO 테이블명칭 (studentname, studentage) VALUES ('홍길동', 11);
-- 강철수 12, 박길자 13 오말숙 14 안정미 15 1,2,3,4 번호 순으로 저장
INSERT INTO STUDENT (studentname, studentage) VALUES ('강철수', 12);
INSERT INTO STUDENT (studentname, studentage) VALUES ('박길자', 13);
INSERT INTO STUDENT (studentname, studentage) VALUES ('오말숙', 14);
INSERT INTO STUDENT (studentname, studentage) VALUES ('안정미', 15);
-- SELECT 문 활용해서 저장이 잘 되었는지 확인


SELECT TRIGGER_NAME, STATUS
FROM USER_TRIGGERS
WHERE TRIGGER_NAME = 'TRG_USER';



SELECT SEQUENCE_name
FROM user_sequences
WHERE SEQUENCE_name = 'SEQ_USER';

DROP TRIGGER TRG_USER;



INSERT INTO STUDENT (studentid, studentname, studentage) 
			VALUES (seq_user.NEXTVAL, '안정미', 15);


CREATE SEQUENCE seq_std INCREMENT BY 1 START WITH 1;


CREATE OR REPLACE TRIGGER trg_std
BEFORE INSERT ON student
FOR EACH ROW
BEGIN
	-- 시퀀스를 사용해서 student 테이블 내에 studentid 번호를 자동으로 생성
	:NEW.studentid = seq_user.NEXTVAL;
END;

