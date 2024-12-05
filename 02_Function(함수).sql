/*

검색 대상과 조회대상 검색어를 모두 대문자나 소문자로 변환 후 비교

UPPER(컬럼명) : 컬럼명의 문자열을 모두 대문자로 변환
LOWER(컬럼명) : 컬럼명의 문자열을 모두 소문자로 변환

***** UPPER 대문자로 변환 *****
대소문자 구분 없이 특정 컬럼에서 데이터 조회하기
SELECT *
FROM 테이블명
WHERE UPPER(컬럼명) = UPPER('조회할데이터');

대소문자 구분 없이 특정 컬럼에서 조회할 데이터 이용해 찾기
SELECT *
FROM 테이블명
WHERE UPPER(컬럼명) LIKE UPPER('%조회할데이터%');

조회 결과를 대문자로 변환
SELECT UPPER(컬럼명) AS 대문자컬럼명
FROM 테이블명;


***** LOWER 소문자로 변환 *****
소문자 구분 없이 특정 컬럼에서 데이터 조회하기
SELECT *
FROM 테이블명
WHERE LOWER(컬럼명) = LOWER('조회할데이터');

소문자 구분 없이 특정 컬럼에서 조회할 데이터 이용해 찾기
SELECT *
FROM 테이블명
WHERE LOWER(컬럼명) LIKE LOWER('%조회할데이터%');

조회 결과를 소문자 변환
SELECT LOWER(컬럼명) AS 소문자컬럼명
FROM 테이블명;


COUNT(컬럼명) : 특정컬럼에서 조회된 행의 개수 반환
COUNT(*) 조회된 모든 행의 개수 반환

COUNT(DIS TI NCT 컬럼명) : 특정컬럼에서 중복 값을 제외한 행의 개수 반환

AVG(숫자만 기록된 컬럼명) : 그룹의 평균
*/