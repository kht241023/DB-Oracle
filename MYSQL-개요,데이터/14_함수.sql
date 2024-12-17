/*
함수


CONCAT = 여러 문자열을 하나의 문자열로 결합하는 함수
[작성법]
CONCAT(string1, string2, string3, ..., stringN)
ex) SELECT CONCAT('Hello', ' ', 'World', '!');
----> 출력결과 : Hello World!

SUBSTRING_INDEX = 문자열에서 특정 구분자를 기준으로 일부만 잘라서 가져오는 함수
[작성법]
SUBSTRING_INDEX(string, 구분기준, count);
                                  count: + 양수일 때 구분기준으로   왼쪽부터 count만큼 가져오기
                                  count: - 음수일 때 구분기준으로 오른쪽부터 count만큼 가져오기
ex) SELECT SUBSTRING_INDEX('user@example.com', '@', 1);
---->           @기준으로 왼쪽 부분 첫 번째만 가져오기
----> 출력결과 : user
ex) SELECT SUBSTRING_INDEX('user@example.com', '@', -1);
---->           @기준으로 오른쪽 부분 첫 번째만 가져오기
----> 출력결과 : example.com 

<NULL 연산> : IS NULL / IS NOT NULL;

EXTRACT() : 지정된 년, 월, 일 을 택해서 추출

SYSDATE : 현재시간 (MS 불포함)
SYSTIMESTAMP : 현재시간

REPLACE() :문자열 바꾸기
LENGTH() : 문자열 길이 반환

INSTR() : 찾을 시작 위치부터 지정된 순번째 찾은 문자열의 시작 위치를 반환
SUBSTR() : 문자열을 시작 위치부터 지정된 길이만큼 잘라내서 반환

TRIM() : 주어진 문자열의   앞쪽       | 뒤쪽   | 양쪽에 존재하는 지정된 문자열 제거
                   옵션 LEADING     TRAILING    BOTH
TRUNC() : 버림(잘라내기)
FLOOR() : 내림
CEIL()  : 올림
ROUND() : 반올림

MOD() : 나머지
ABS() : 절대값 음수 -> 양수 처리
AVG() : 평균
MAX() : 최대
MIN() : 최소
SUM() : 합
      SELECT SUM(*) FROM USER; --> 회원 총 인원수
      SELECT SUM(*) FROM PRODUCT WHERE PRODUCT_NAME LIKE (%?%);
COUNT() : 총 합 -> 추후 로그인시 사용될 예정
        SELECT COUNT(*)  FROM USER  WHERE ID = ?  AND PW = ? ; 
            -> ID와 PW가 일치하는 회원이 존재하면 COUNT 1
                         일치하는 회원이 존재하지 않으면 COUNT 0

*/