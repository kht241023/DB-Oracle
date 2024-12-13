--- *** DML(Data Manipulation Language) : 데이터 조작 언어

--- 테이블에 값을 삽입하거나(INSERT) 수정하거나(UPDATE)  삭제(DELETE) 하는 구문

--- 데이터를 저장하고 수정하고 삭제한 후 반드시 COMMIT 을 작성해야지 저장
--- 저장을 취소하는 방법 ROLLBACK 작성

----- 주의 : 혼자서 COMMIT, ROLLBACK 하지 말 것!

-------------------------------------------------------------------------------

-- * INSERT 작성용 테이블 복제해서 생성
--  CAFE 테이블을 복제해서 EATS 테이블 생성
CREATE TABLE EATS AS SELECT * FROM CAFE; -- CAFE 테이블형식을 그대로 복제해서 EATS 생성
/*
CREATE TABLE EATS AS SELECT * FROM CAFE; 
카페 테이블 형식을 그대로 복제해서 EATS 테이블 생성한다는 의미
CREATE TABLE Cafe (
    cafe_id NUMBER PRIMARY KEY,        -- 카페의 고유 ID
    cafe_name VARCHAR2(100) NOT NULL,  -- 카페 이름
    location VARCHAR2(255),            -- 카페 위치
    contact_number VARCHAR2(20)        -- 카페 연락처
);
↓ 아래처럼 테이블명만 교체해서 그대로 복제

CREATE TABLE EATS (
    cafe_id NUMBER PRIMARY KEY,        -- 이츠의 고유 ID
    cafe_name VARCHAR2(100) NOT NULL,  -- 이츠 내의 카페 이름
    location VARCHAR2(255),            -- 이츠 내의 카페 위치
    contact_number VARCHAR2(20)        -- 이츠 내의 연락처
);



*/
--- 1. INSERT
---- 테이블에 새로운 행을 추가하는 구문

---- 1) INSERT INTO 테이블명 VALUES(데이터, 데이터, ...)
----- 테이블에 모든 컬럼에 대한 값을 INSERT(추가)할 때 사용

---- 2) INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명, ...)
----                  VALUES(데이터, 데이터, 데이터, ...);
----- 테이블에 내가 선택한 컬럼에 대한 값만 INSERT 할 때 사용 
----- 선택안된 컬럼은 값이 NULL이 들어감

--- 2. UPDATE
---- 테이블에 기록된 컬럼의 값을 수정하는 구문
---- [작성법]
---- UPDATE 테이블명 SET 컬럼명 = 바꿀값 [WHERE 컬럼명 비교연산자 비교값];







--- 3. DELETE
---- 테이블에 행을 삭제하는 구문
---- [작성법]
---- DELETE FROM 테이블명 WHERE 조건설정
---- 만약에 WHERE 조건을 설정하지 않으면 모두 삭제
----- DELETE 의 경우 진행하기 전 주위에 한 번 더 점검한 후 진행
DELETE 
FROM 테이블명 ; -- 테이블 내에 있는 모든 값 삭제 

DELETE 
FROM 테이블명 
WHERE 컬럼명 = '삭제할데이터' ;

DELETE 
FROM 테이블명 
WHERE 컬럼명1 = '컬럼명1에 해당하는 삭제할 데이터' 
AND   컬럼명2 = '컬럼명2에 해당하는 삭제할 데이터';
