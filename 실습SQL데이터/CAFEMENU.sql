CREATE TABLE Cafe (
    cafe_id NUMBER PRIMARY KEY,        -- 카페의 고유 ID
    cafe_name VARCHAR2(100) NOT NULL,  -- 카페 이름
    location VARCHAR2(255),            -- 카페 위치
    contact_number VARCHAR2(20)        -- 카페 연락처
);

CREATE TABLE Menu (
    menu_id NUMBER PRIMARY KEY,        -- 메뉴의 고유 ID
    cafe_id NUMBER,                    -- 카페 ID (외래키)
    menu_name VARCHAR2(100) NOT NULL,  -- 메뉴 이름
    description VARCHAR2(255),         -- 메뉴 설명
    price NUMBER(10, 2),               -- 메뉴 가격
    FOREIGN KEY (cafe_id) REFERENCES Cafe(cafe_id) -- 카페 테이블과의 관계
);

INSERT INTO Cafe (cafe_id, cafe_name, location, contact_number) 
          VALUES (1, '블루라벨 카페', '서울 강남구', '010-1234-5678');
INSERT INTO Cafe (cafe_id, cafe_name, location, contact_number) VALUES (2, '그린빈 카페', '서울 종로구', '010-2345-6789');
INSERT INTO Cafe (cafe_id, cafe_name, location, contact_number) VALUES (3, '빈티지 카페', '서울 마포구', '010-3456-7890');
INSERT INTO Cafe (cafe_id, cafe_name, location, contact_number) VALUES (4, '카페 드 로즈', '서울 송파구', '010-4567-8901');
INSERT INTO Cafe (cafe_id, cafe_name, location, contact_number) VALUES (5, '로스터리 카페', '서울 강동구', '010-5678-9012');
INSERT INTO Cafe (cafe_id, cafe_name, location, contact_number) VALUES (6, '모카하우스', '서울 강서구', '010-6789-0123');
INSERT INTO Cafe (cafe_id, cafe_name, location, contact_number) VALUES (7, '커피탐방', '서울 용산구', '010-7890-1234');
INSERT INTO Cafe (cafe_id, cafe_name, location, contact_number) VALUES (8, '에스프레소 바', '서울 동대문구', '010-8901-2345');
INSERT INTO Cafe (cafe_id, cafe_name, location, contact_number) VALUES (9, '카페 뮤제', '서울 서초구', '010-9012-3456');
INSERT INTO Cafe (cafe_id, cafe_name, location, contact_number) VALUES (10, '피크닉 카페', '서울 관악구', '010-1234-6789');


INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (1, 1, '아메리카노', '고소한 맛의 에스프레소와 물의 조화', 4500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (2, 1, '카페라떼', '부드러운 우유와 에스프레소의 조화', 5000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (3, 1, '카푸치노', '우유 거품이 풍성한 에스프레소 음료', 5500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (4, 2, '카페모카', '초콜릿과 우유의 달콤한 조화', 5500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (5, 2, '핸드드립 커피', '신선한 원두로 내린 커피', 6000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (6, 2, '바닐라 라떼', '바닐라 시럽과 우유가 어우러진 맛', 5800);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (7, 3, '에스프레소', '진한 맛의 커피', 4000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (8, 3, '콜드브루', '차가운 물로 우려낸 커피', 6500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (9, 3, '플랫화이트', '부드러운 우유와 진한 에스프레소', 6000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (10, 4, '카라멜 마키아토', '카라멜 시럽과 에스프레소의 조화', 5800);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (11, 4, '녹차 라떼', '상큼한 녹차와 부드러운 우유', 5500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (12, 4, '루이보스티', '디저트와 잘 어울리는 티', 4500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (13, 5, '더치커피', '차가운 물로 내린 커피', 7000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (14, 5, '핸드드립', '싱글오리진 원두로 내린 커피', 6500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (15, 5, '모카프라페', '초콜릿과 커피의 조화', 6500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (16, 6, '아이스 아메리카노', '시원한 아메리카노', 4500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (17, 6, '프라푸치노', '얼음과 커피가 혼합된 음료', 6000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (18, 6, '피치 아이스티', '상큼한 복숭아 아이스티', 5000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (19, 7, '자몽차', '상큼한 자몽을 담은 차', 5000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (20, 7, '시나몬 라떼', '계피 향이 나는 달콤한 음료', 5500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (21, 7, '딸기 밀크쉐이크', '딸기와 우유의 달콤한 쉐이크', 6500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (22, 8, '핸드메이드 레몬차', '레몬을 직접 손질하여 만든 차', 6000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (23, 8, '허브티', '상쾌한 허브 향의 차', 5000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (24, 8, '카페블랙', '진한 커피의 맛을 그대로', 4000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (25, 9, '초코라떼', '달콤한 초콜릿과 부드러운 우유', 5500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (26, 9, '망고 스무디', '상큼한 망고와 우유가 어우러진 스무디', 6500);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (27, 9, '모과차', '모과의 향이 가득한 차', 5000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (28, 10, '카라멜 프라페', '카라멜 시럽과 얼음이 어우러진 프라페', 6000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (29, 10, '블루베리 아이스티', '블루베리와 아이스티의 조화', 5000);
INSERT INTO Menu (menu_id, cafe_id, menu_name, description, price) VALUES (30, 10, '밀크쉐이크', '부드러운 우유와 함께한 밀크쉐이크', 6500);

COMMIT; --insert로 입력한 내용 저장하기