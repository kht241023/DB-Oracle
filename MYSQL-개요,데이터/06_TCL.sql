/*
TCL(Transaction Control Language) : 트랜잭션 제어 언어

Transaction : 업무 ,처리

-- 데이터 변경 사항을 묶어 하나의 트랜잭션에 담아 처리함
   (데이터 변경 사항을 묶어 하나의 업무로 담아 처리함)

-- 트랜잭션(업무,처리)의 대상이 되는 데이터 변경 사항 : DML (INSERT, UPDATE, DELETE)


EX)
   INSERT 작업 완료! -------------------------------------> DB 저장 (X)
   INSERT 작업 완료! ---->트랜잭션에 추가 ----> COMMIT ----> DB 저장 (O)
   INSERT 10개 완료! ----> 1개 업무처리공간에 10개의 INSERT가 담겨있음 ----> ROLLBACK --> 모든 작업 없던 일로 처리

 1) COMMIT :    최종저장 완료! 
                메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 DB에 반영

 2) ROLLBACK  : 최종저장 취소
                메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경사항을 삭제하고
                마지막 커밋 상태로 돌아감( == 작업내용 삭제)

 3) SAVEPOINT : 임시저장
                메모리 버퍼(트랜잭션)에 저장 지점을 설정해서 ROLLBACK 수행 시 전체 작업을 삭제하는 것이 아니라
                저장지점까지만 일부 ROLLBACK

            [SAVEPOINT 사용법]
            SAVEPOINT 임시저장이름1; 

            SAVEPOINT 임시저장이름2;

            ROLLBACK TO 임시저장이름1; --> 임시저장이름1 번 까지 수정 삭제 삽입한 데이터 삭제하고 복구

            임시저장이름을 작성할 때 큰 따옴표로 감싸줌
            SAVEPOINT "SP3";
            ROLLBACK TO "SP3";



*/