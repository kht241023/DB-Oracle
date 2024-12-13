/*
숫자자료형
TININT        : 아주 작은 정수
SALLINT       : 작은 정수
MEDIUMINT     : 중간 크기의 정수
INT = INTEGER : 표준 크기의 정수
BIGINT        : 매우 큰 정수

실수자료형
FLOAT  : 실수형 자료형  (DOUBLE보다 범위가 작음)
DOUBLE : 실수형 자료형
DECIMAL OR NUMBERIC : 고정소수점을 표현한 숫자

문자자료형

고정 길이
CHAR(n)     : 길이를 고정적으로 설정
         무조건 길이가 짧든 적든 초기에 작성한 길이만큼 공간 설정

가변 길이
VARCHAR     : 변수 공간의 길이를 변경가능한 문자열
            실제 데이터의 길이만큼 저장             최대 255자(숫자,영어 기준) 저장 가능
TEXT        : 긴글자를 저장할 때 사용               최대 65,535 자 까지 저장 가능
MEDIUMTEXT  : TEXT보다 큰 텍스트 를 저장            최대 16MB
LONGTEXT    : TEXT, MEDIUMTEXT보다 큰 텍스트를 저장 최대 4GB

기타 자료형
BLOB : 이미지, 동영상 등과 같은 이진 데이터 저장
ENUM : 미리 정의된 값을 선택하는데 사용 (택 1가지 선택)
       HTML에서 SELECT - OPTION   
       RADIO 처럼 지정된 범위에서만 선택 가능
       EX) ENUM('small','medium', 'large') = 작음 중간 큼 중 하나를 선택해서 db에 저장
SET  : 여러 값을 가질 수 있는 집합을 정의하는 자료형 (다수 선택 가능)
       CHECKBOX 처럼 다수 선택해서 DB에 저장
       EX) SET('독서', '낚시', '쇼핑')  = 독서 낚시 쇼핑을 한 번에 저장 가능

CREATE TABLE 테이블명칭 (
    USER_ID INT PRIMARY KEY AUTO_INCREMENT,
    GENDER  ENUM('female', 'male')
    HOBBIES SET('reading', 'sports', 'traveling')
);

날짜자료형
DATE : 날짜만 저장 (YYYY-MM-DD)
DATETIME : 날짜와 시간을 함께 저장 (YYYY-MM-DD HH:mm:ss)
TIMESTAMP : 날짜와 시간을 함께 저장되는데, 값이 변경될 때 자동으로 현재시간으로 갱신
            TIMESTAMP DEFAULT CURRENT_TIMESTAMP 기본으로 현재시간 저장
TIME : 시간만 저장(HH:mm:ss)
YEAR : 연도만 저장(YYYY)


*/