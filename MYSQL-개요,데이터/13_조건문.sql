/*
CASE 문은 조건에 따라 다른 결과를 반환하는데 사용
IF-ELSE 문과 비슷한 역할을 수행, 다양한 상황에 맞게 조건을 검사할 수 있음

특정 결과 값을 검사 후 도출하거나, 삽입 및 수정을 한 번에 처리할 때 사용하기도 함

1. CASE ...WHEN ... THEN 문법 (다중 조건 처리)
여러 조건을 순서대로 검사하고, 조건에 맞는 첫 번째 결과를 반환
조건이 일치하지 않으면 ELSE 절에 지정된 값이 반환

[작성법]
CASE 
    WHEN 조건1 THEN 결과1
    WHEN 조건2 THEN 결과2
    ...
    ELSE 결과N

END


2. CASE 컬럼 비교 문법 (단일 값 비교)
단일 컬럼 값이 여러 조건 중 하나와 일치하는지를 검사하고, 일반적으로 값이 같은지 비교하는 데 사용
[작성법]
CASE 컬럼명
    WHEN 값1 THEN 결과1
    WHEN 값2 THEN 결과2
    ...
    ELSE 결과N
END

*/

-- ORDER 테이블에 작성된 컬럼내 값을 한 번에 변경할 때 사용하는 예제

UPDATE `ORDER`
SET STATUS = CASE
    WHEN STATUS = 'PENDING' THEN '대기'
    WHEN STATUS = 'SHIPPED' THEN '배송 중'
    WHEN STATUS = 'DELIVERED' THEN '배송 완료'
    WHEN STATUS = 'CANCELLED' THEN '취소'
END;