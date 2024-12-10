CREATE TABLE EATS AS SELECT * FROM CAFE; --CTRL + ENTER
SELECT * FROM EATS;

CREATE TABLE EATS_MENU AS SELECT * FROM MENU; --CTRL + ENTER
SELECT * FROM EATS_MENU;

-- 11번째 빠나쁘레쏘 '경기도 고양시' 031-123-4567

INSERT INTO EATS 
	   VALUES (11, '빠나쁘레쏘',  '경기도 고양시', '031-123-4567'   );

COMMIT; --INSERT UPDATE DELETE 추가 수정 삭제 한 기록 저장하기

-- 12번째 로맨틱블루 부산 해운대구 051-987-6543; 추가한다음 저장하기(COMMIT)
INSERT INTO EATS VALUES(12, '로맨틱블루', '부산 해운대구', '051-987-6543');

--13'티하우스' 카페  인천 남동구에 위치, 연락처 032-345-6789

INSERT INTO EATS VALUES(13,'티하우스','인천 남동구', '032-345-6789');

--14'라떼아트' 카페  경기도 성남시에 위치, 연락처 031-654-3210
INSERT INTO EATS VALUES(14,'라떼아트','경기도 성남시', '031-654-3210');
--15'커피클럽' 카페 대구 중구에 위치, 연락처 053-222-1111
INSERT INTO EATS VALUES(15,'커피클럽', '대구 중구', '053-222-1111');

ROLLBACK; --DBEAVER는 알아서 자동 COMMIT 

SELECT * FROM EATS;

DELETE FROM EATS WHERE CAFE_ID = 13;

COMMIT;

-- 2번 방법을 이용해서 선택적으로 데이터 추가  
---- 주의할점 : NOT NULL은 선택적으로 작성 불가 필수로 작성해야하는 컬럼
--- PRIMARY KEY -> 고유의 숫자값을 가지는 키 가입한 명단 순서 NULL
--- 트리거 시퀀스 -> ORACLE PRIMARY KEY는 자동으로 번호를 측정해주는 동작을 설정해줘여함
INSERT INTO EATS (CAFE_ID, CAFE_NAME) VALUES (15,'빈포레스트');

SELECT * FROM EATS;

--빈 포레스트라는 CAFE_NAME을 찾아서 삭제
DELETE FROM EATS WHERE CAFE_NAME = '빈포레스트';

--INSERT INTO EATS(CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
--       VALUE (16번부터 18번까지 추가)
--16'브루윙랩'카페 대전 서구에 위치, 연락처 042-333-4444
INSERT INTO EATS(CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (16,'브루윙랩', '대전 서구', '042-333-4444');
--17'스윗빈즈' 카페 광주 북구에 위치, 연락처 062-567-8901
INSERT INTO EATS(CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (17,'스윗빈즈', '광주 북구', '062-567-8901');
--18'카페 블랙' 울산 남구에 위치, 연락처 052-444-5555
INSERT INTO EATS(CAFE_ID, CAFE_NAME, LOCATION, CONTACT_NUMBER)
VALUES (18,'카페 블랙', '울산 남구', '052-444-5555');


SELECT * FROM EATS;


DELETE 
FROM EATS 
WHERE CAFE_ID = 16 AND CAFE_NAME='스윗빈즈';


