/*
제약조건(CONSTRAINTS)

    사용자가 원하는 조건의 데이터만 유지하기 위해 특정 컬럼에 설정하는 제약
    데이터 무결성 보장을 목적으로 함

    * (無缺性 =무결성, Integrity) 없을 무, 모자랄 결 성질 성
        무결성이란 완벽한 성질 , 데이터가 손상되지 않고, 완전, 정확, 한결같아야함

    + 입력 데이터에 문제가 없는지 자동으로 검사하는 목적
    + 데이터의 수정/삭제 가능여부 검사등을 목적으로 함
        --> 제약조건을 위배하는 DML 구문은 수행할 수 없음

    제약조건 종류
    PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

    제약조건 확인하는 방법
    (MYSQL)
    테이블 제약조건 확인
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    SELECT * 
    FROM   INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE  TABLE_NAME = '테이블명'
    AND    TABLE_SCHEMA = '데이터베이스명';

    컬럼 수준 제약조건 확인
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    SELECT * 
    FROM   INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    WHERE  TABLE_NAME = '테이블명'
    AND    TABLE_SCHEMA = '데이터베이스명';




    (ORACLE)
    USER_CONSTRAINTS : 사용자가 작성한 제약조건을 확인하는 딕셔너리 뷰


*/

/*
 PRIMARY KEY(기본 키)
  - 각 행을 고유하게 식별하는 컬럼 또는 컬럼 조합
  - 테이블당 하나의 primary key만 설정
  - 기본 키로 설정된 컬럼은 자동으로 UNIQUE와 NOT NULL 제약 조건을 가짐
    예를 들어 회원가입 할 경우 가입한 시간 순으로 회원번호가 순차적으로 부여
    12월 10일에 가입한 회원의 번호가 13번이라면 12월 11일에 가입한 회원의 번호가
    14번이거나 13번 이후 번호가 되어야지 회원가입 순 번이 13이거나 빈 값이면 안된다는 의미
 
    [작성법]
    CREATE TABLE 테이블명(
    테이블_ID INT AUTO_INCREMENT PRIMARY KEY,
    유저명 VARCHAR(50)
    )
    테이블_ID 컬럼은 PRIMARY 키이며 각 키 값이 고유하고,  NULL(빈) 값을 가질 수 없음
 
 NOT NULL
  - 특정 컬럼이 NULL(빈) 값을 가질 수 없도록 제한

  - 데이터 입력 시 반드시 값을 제공해야함
  - 기본값(Default value)를 설정해서 NULL(빈) 값 방지 가능

    [작성법]
    CREATE TABLE 테이블명(
    테이블_ID INT         AUTO_INCREMENT PRIMARY KEY,
    유저명    VARCHAR(50) NOT NULL,
    가입일자  DATETIME        NOT NULL DEFAULT CURRENT_DATE
    )
 -- DATE 자료형은 current_timestamp 사용 불가
 -- DATE 자료형은 연-월-일 만 저장이되고, DATETIME 연-월-일 시:분:초 저장이 되므로 DATETIME
    유저명과 가입일자 모두 NULL(빈) 값 작성 XXX 
    -> 
    유저명  : 회원가입시 유저가 유저명 작성하지 않으면 회원가입 X
    가입일자: 회원가입시 유저가 회원가입일자를 작성하지 않아도 DB에 회원가입이 저장되는 시간으로 자동 기록
 
 
 
 
 UNIQUE
  - 컬럼의 값이 고유해야 함을 보장
  - 테이블 내에서 중복된 값을 허용하지 않음
  - UNIQUE 제약 조건은 단 1회 NULL값을 허용
  - 한 테이블에 여러 UNIQUE 컬럼 값을 가질 수 있음
 
    [작성법]
    CREATE TABLE 테이블명(
    테이블_ID  INT          AUTO_INCREMENT PRIMARY KEY,
    이메일     VARCHAR(100) UNIQUE,
    주민번호   VARCHAR(100) UNIQUE,
    휴대폰번호 VARCHAR(100) UNIQUE
    )

    이메일이 1번 회원과 1번 이외 다른 회원가 일치하는 이메일 동일한 이메일이 없어야함
    마찬가지로 주민번호, 회원번호 또한 다른 유저와 일치하는 번호값이 없어야함

    1   kim@googla.co.kr  000101-0101010
        kim@googla.co.kr  000101-0101010 중복이므로 unique 하지 못함!!!       -> DB 저장 안됨
        kim@googla.co.kr  010101-0202020 이메일이 중복이므로 unique 하지 못함  -> DB 저장 안됨
        lee@googla.co.kr  000101-0101010 주빈번호가 중복이므로 unique 하지 못함-> DB 저장 안됨
    2   lee@googla.co.kr  010101-0202020 주민번호와 이메일 모두 일치하는 회원이 없기 때문에 저장 가능

 CHECK
  - 특정 컬럼 값이 지정된 조건을 만족해야 함을 보장
  - MYSQL 8.0 이상에서 지원

  - 데이터 삽입 또는 업데이트 시 조건 검증
  - 조건 불만족할 경우 DB 저장 XXX
 
 
    [작성법]
    CREATE TABLE 테이블명(
    테이블_ID  INT           AUTO_INCREMENT PRIMARY KEY,
    가격       DECIMAL(10,2) CHECK (가격 > 0)
    )
    가격 컬럼은 0보다 큰 숫자값만 허용
 
 FOREIGN KEY
  - 한 테이블의 컬럼이 다른 테이블의 PRIMARY KEY나 UNIQUE 컬럼을 참조하도록 설정
  - 데이터베이스 내에서 테이블 간의 관계를 정의하는데 사용

  - 참조 무결성 유지
  - 부모 테이블의 데이터 변경 시 행동(삭제/업데이트) 제어할 수 있음

  ON DELETE와 ON UPDATE 동작
    CASCADE  : 참조하는 데이터가 변경되면 참조된 데이터도 함께 변경
    SET NULL : 참조된 데이터를 NULL로 설정
    RESTRICT : 변경을 제한

    [작성법]
    CREATE TABLE customers(
    customer_id  INT           AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(100)
    )
    
    CREATE TABLE orders(
    order_id  INT           AUTO_INCREMENT PRIMARY KEY,
    customer_id  INT
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
    FOREIGN KEY : 다른 테이블에 작성된 아이디를
    현재 테이블에 위치한 특정 컬럼id값에서
    REFERENCES  : 참조할 것이다.
    다른테이블이름(다른테이블에 작성된 id값)
    ON DELETE CASCADE :  만약에 다른테이블에서 참조하는 id에서 delete(삭제)가 발생하면
    현재 나의 테이블에서 삭제된 id와 일치하는 모든 컬럼을 삭제할 것
    ) 

    주문자 : 홍길동 주문내역 : 신발, 가방 구매
    홍길동씨 탈퇴 선언!!! -> 홍길동씨가 주문한 내역 또한 같이 삭제

    무조건 외래키 제약을 걸어서 삭제하는 것이 좋은 것이 아니라 상황에 따라 사용
    예를 들어 ) 커뮤니티 카페의 경우 카페 회원 탈퇴를 할 경우 회원이 작성한 게시물과 댓글 삭제 X
                     배달 앱의 경우 가게가 폐업을 할 경우 가게에서 제공한 메뉴들과 리뷰 모두 삭제



CREATE TABLE 이츠(
    이츠회원번호
    카테고리이름
        가게번호

)

CREATE TABLE 이츠가게들(
    가게번호
    가게이름
    가게주소
)
CREATE TABLE 메뉴들 (
    메뉴번호
    가게번호
    메뉴이름
    메뉴가격

)



*/