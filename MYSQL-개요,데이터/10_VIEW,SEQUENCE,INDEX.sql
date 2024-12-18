/*
VIEW
논리적 가상 테이블
테이블 모양을 하고 있지만, 실제로 값을 저장하고 있진 않음

- SELECT 문의 실행 결과(RESULT SET)를 저장하는 객체

VIEW 사용 목적

1) 복잡한 SELECT 문을 쉽게 재사용하기 위해
2) 테이블의 진짜 모습을 감출 수 있어 보안상 유리

VIEW 사용 시 주의 사항
1) 가상의 테이블(실체 X)이기 때문에 ALTER 구문 사용불가
2) VIEW를 이용한 DML(INSERT, UPDATE, DELETE)이 가능한 경우도 있지만
제약이 많이 따르기 때문에 DQL(SELECT) 용도로 대부분 사용


VIEW 작성법
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름 [컬럼별칭]
AS 서브쿼리(SELECT문)
[WITH CHECK OPTION]
[WITH READ ONLY];


1) OR REPLACE 옵션 : --ORACLE에서만 사용 가능 MYSQL(5.7 버전 이상만 가능 = 우리는 가능)
            기존에 동일한 이름의 VIEW 가 존재하면 덮어쓰기 처럼 현재 작성한 VIEW로 변경
            없으면 새로 생성
2) FORCE | NOFORCE 옵션 :  --ORACLE에서만 사용 가능
    FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
    NOFORCE(기본값) : 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성

3) 컬럼 별칭 옵션 : 조회되는 VIEW 컬럼명을 지정

4) WITH CHECK OPTION 옵션 : 
            옵션을 지정한 컬럼의 값을 수정 불가능하게 함

5) WITH READ ONLY 옵션 :  --ORACLE 에서만 가능
            뷰에 대해 SELECT 만 가능하도록 지정


-- VIEW 테이블은 JOIN해서 만든 가상의 테이블일 경우 INSERT UPDATE DELETE 가 안됨
-- 단일 테이블로 VIEW 를 설정하면 INSERT DELETE 가 임시적으로는 가능하지만
-- 주로 SELECT 의 결과를 임시로 저장해놓고 사용하는 용도
*/

/*

SEQUENCE(순서, 연속)
 - 순차적으로 일정한 간격의 숫자(번호)를 발생시키는 객체
 (번호 자동 생성기)

 ORACLE은 SEQUENCE 를 무조건 사용 
        이외 대부분의 SQL 회사는 SEQUENCE 대신 자동 숫자 증감 기능 존재
        MYSQL : AUTO_INCREMENT 사용해서 숫자를 순차적으로 증감

사용 이유

PRIMARY KEY(기본키) : 테이블 내 각 행을 구별하는 식별자 역할
                        NOT NULL + UNIQUE 의 의미를 가짐
                        -> 빈값이면 안되고, 고유한 숫자의 의미 = UNIQUE

PK(=PRIMARY KEY)가 지정된 컬럼에 삽입될 값을 생성할 때 SEQUENCE(=AUTO_INCREMENT) 사용하면 좋음

시퀀스를 사용하면 자동으로 순번매김이 되는 것이 아니라 id값에 자동으로 순번 넘김을 작성

시퀀스명.NEXTVAL : 다음 시퀀스 번호를 얻어옴
                    (INCREMENT BY 만큼 증가된 수)
                    단, 생성 후 처음 호출된 시퀀스인 경우
                    START WITH에 작성된 값이 반환됨
시퀀스명.CURRVAL  : 현재 시퀀스 번호를 얻어옴
                    단, 시퀀스가 생성 되자마자 호출할 경우 오류 발생
                    마지막으로 호출한 NEXTVAL 값을 반환

MYSQL - SEQUENCE 지원 xxxx AUTO_INCREMENT 를 사용






*/