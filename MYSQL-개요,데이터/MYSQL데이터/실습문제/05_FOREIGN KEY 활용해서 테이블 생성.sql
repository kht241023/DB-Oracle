USE KHTUSER;

SELECT * FROM USER;
SELECT * FROM ADDRESS;
SELECT * FROM user_activity;

-- TABLE USER ADDRESS USER_ACTIVITY 테이블 삭제

DROP TABLE user_activity;
DROP TABLE user;
-- USER 와 ADDRESS 는 서로 부모 자식 관계로 ID로 연결되어 있어
-- USER를 삭제하기 위해서 ADDRESS 먼저 삭제를 진행해야함
-- FOREIGN KEY 로 ON DELETE CASCADE를 걸어주지 않기 때문에
-- 현재 시점에서 USER를 사용하면 ADDRESS만 남아있으므로 USER먼저 삭제 불가
-- DROP TABLE user	Error Code: 3730. 
-- Cannot drop table 'user' referenced by a foreign key constraint 
-- 'address_ibfk_1' on table 'address'.	0.000 sec
DROP TABLE ADDRESS;
DROP TABLE USER;

-- 사용자 테이블
CREATE TABLE USER (
	user_id  INT auto_increment primary KEY, 				-- 기본키 가입시 순차적으로 숫자 증가
    username VARCHAR(50) NOT NULL,			 				-- 빈 값 허용 X 동명이인 OK
    email    VARCHAR(100) NOT NULL UNIQUE,    				-- 빈 값 허용 X 동일한이메일 X
    age		 INT          CHECK( age >= 18), 				-- 18세 이상만 가능 NOT NULL 상태
    create_at DATETIME 	  NOT NULL DEFAULT current_timestamp -- 가입일자 필히 작성 / 미작성할 경우 DB 등록 일자로 기입
);
-- DATE 자료형은 current_timestamp 사용 불가
-- DATE 자료형은 연-월-일 만 저장이되고, DATETIME 연-월-일 시:분:초 저장이 되므로 DATETIME
-- 주문 테이블

CREATE TABLE order_item (
	order_id INT auto_increment primary KEY,
    USER_ID INT NOT NULL,
    PRODUCT_NAME VARCHAR(100) NOT NULL,
    QUANTITY INT CHECK (QUANTITY > 0),
    ORDER_DATE DATETIME NOT NULL DEFAULT current_timestamp,

    foreign key(USER_ID) references USER(USER_ID)
    on update CASCADE
    ON DELETE CASCADE

);




SELECT * FROM USER;
SELECT * FROM order_item;


INSERT INTO USER (username, email, age)
VALUES
('김민수', 'minsu.kim@example.com', 28),
('이영희', 'younghee.lee@example.com', 34),
('박철수', 'chulsoo.park@example.com', 21),
('최지연', 'jiyeon.choi@example.com', 29),
('정다은', 'daeun.jung@example.com', 25),
('한승우', 'seungwoo.han@example.com', 32),
('김서연', 'seoyeon.kim@example.com', 22),
('이준호', 'junho.lee@example.com', 27),
('장민지', 'minji.jang@example.com', 30),
('윤성호', 'seongho.yoon@example.com', 24),
('강유진', 'yujin.kang@example.com', 26),
('조은비', 'eunbi.cho@example.com', 23),
('배현우', 'hyunwoo.bae@example.com', 31),
('신재은', 'jaeeun.shin@example.com', 28),
('홍길동', 'gildong.hong@example.com', 35),
('오지훈', 'jihoon.oh@example.com', 29),
('서미경', 'mikyoung.seo@example.com', 22),
('노수민', 'sumin.no@example.com', 20),
('하윤아', 'yuna.ha@example.com', 26),
('황도영', 'doyoung.hwang@example.com', 33);
COMMIT;

SELECT * FROM USER;


INSERT INTO order_item (USER_ID, PRODUCT_NAME, QUANTITY)
VALUES
(1, '노트북', 1),
(2, '무선 이어폰', 2),
(3, '휴대폰 케이스', 3),
(4, '커피 머신', 1),
(5, '스마트 워치', 1),
(6, '책상', 1),
(7, '게이밍 마우스', 1),
(8, '키보드', 2),
(9, '스탠드 조명', 1),
(10, '운동화', 1),
(11, '휴대폰', 1),
(12, '캠핑 의자', 2),
(13, '캠핑 텐트', 1),
(14, '블루투스 스피커', 1),
(15, '전자책 리더기', 1),
(16, 'HDMI 케이블', 3),
(17, '모니터', 1),
(18, '가습기', 1),
(19, '공기청정기', 1),
(20, '프라이팬 세트', 1);

SELECT * FROM ORDER_ITEM;


commit;



-- USER 테이블에서 CONCAT SUBSTRING_INDEX 함수 이용해서  이메일 모두 @kht.co.kr 변경
set sql_safe_updates = 0; -- update 가능
set sql_safe_updates = 1; -- update 불가능
UPDATE USER
SET email = CONCAT(SUBSTRING_INDEX(email, '@', 1), '@kht.co.kr');

-- commit 해서 변경사항 저장

-- INNER JOIN 이용해서 
-- user_id, username, email, age, order_id, product_name, quantity, order_date 출력
SELECT U.user_id, U.username, U.email, U.age, 
	   O.order_id, O.product_name, O.quantity, O.order_date
FROM USER U
JOIN order_item O
ON U.USER_ID = O.USER_ID;

-- 최근 주문순으로 정렬 ORDER BY 
-- SELECT USERNAME PRODUCT_NAME, ORDER_DATE
SELECT 
u.username,
o.product_name,
o.order_date
FROM 
	USER u
JOIN
	ORDER_ITEM o
ON
	u.user_id = o.user_id
order by
	o.order_date DESC;



