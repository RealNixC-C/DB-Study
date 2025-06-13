

call by value와 call by reference

	다음중 오버라이드의 설명으로 잘못 된 것은 무엇입니까?
1번보기	오버라이드는 부모의 모든 메서드를 다룰 수 있다.
2번보기	오버라이드는 부모의 메서드를 재정의 하여 사용 하는 것이다.
3번보기	오버라이드는 기본적으로 부모-자식 관계에서 사용 된다.
4번보기	오버라이드는 부모의 메서드를 통째로 바꿔 쓸 수도 있으나, 부모의 기능을 사용 할 수도 있다.
모범답안	1	제출답안	4

	다음중 다형성에 대한 설명으로 옳지 않은 것은 무엇입니까?
1번보기	필드에 다형성을 적용 한 것을 필드의 다형성 이라고 한다.
2번보기	다형성은 부모 자식 클래스 간에만 사용 할 수 있다.
3번보기	매개변수의 다형성을 활용 하면 여러 타입의 객체가 매개변수로 왔을 때 하나의 메서드로 대응이 가능 하다.
4번보기	필드 다형성과 매개변수 다형성은 사용되는 변수의 위치 차이가 있을 뿐이다.
5번보기	
모범답안	2	제출답안	4


MySQL extension 설치

100g당 가격을 다음과 같이 조회

집계 함수(Aggregate Function)

DISTINCT (중복제거함수)


-------------------  [42일차 06.11] ------------------- 
ch05.sql

1. 다양한 자료형 활용하기

UNSIGNED(언사인드) 제약 조건 부여 가능: 음수 값을 허용하지 않는 정수
정수형의 종류: TINYINT, SMALLINT, MEDIUMINT, INTEGER(또는 INT), BIGINT
실수형 종류: 
1) 부동 소수점(floating-point) = FLOAT, DOUBLE
2) 고정 소수점(fixed-point) = DECIMAL


2. 문자형
1) CHAR
2) VARCHAR 

AUTO_INCREMENT의 값은 1씩 증가하고 중간에 데이터를 삭제하면 그 데이터만 제외시키고
숫자는 계속 증가한다

-------------------  [42일차 06.12] ------------------- 
ch06.sql

1. 관계

기본키(PK, Primary Key)
테이블의 각 행을 고유하게 식별할 수 있는 컬럼
레코드를 구분하는 컬럼 또는 컬럼의 조합을 말함

외래키(FK, Foreign Key)
다른 테이블의 기본키를 가리키는 컬럼
두 테이블을 연결하는 역할

1) 일대일 관계(1:1, one-to-one) - 외래키로 설정하는 값에 제약조건 UNIQUE를 설정하는것이 포인트, 외래키가 양쪽중 어느 테이블에 있어도 상관없음
2) 일대다 관계(1:N, one-to-many) - 외래키가 "다"에 해당하는 쪽에 있어야만함
3) 다대다 관계(N:M, many-to-many) - 중간 테이블을 거침, 중간 테이블에 양쪽에 해당하는 외래키를 지정하여 관계를 맺음

2. 제약조건

1) AUTO_INCREMENT
2) NOT NULL
3) CHECK
4) DEFAULT
5) UNSIGNED
6) UNIQUE


ch06_07_selfcheck.png 참고

-- 2. 특정 사용자가 올린 사진의 좋아요 개수
-- 예: 홍팍이 올린 모든 사진의 좋아요 개수는?
SELECT COUNT(*)
FROM users u -- 1) 사용자 정보를 가지고
JOIN photos p -- 2) 사진 정보를 합쳐서
  ON u.id = p.user_id
JOIN likes l -- 3) 좋아요 정보도 합쳐서
  ON p.id = l.photo_id
WHERE nickname = '홍팍'; -- 홍팍이 올린

-- 4. 모든 댓글 본문과 해당 댓글의 달린 사진의 파일명
-- 예: 모든 댓글 본문과 함께 그 댓글이 달린 사진의 파일명을 함께 조회하려면?
SELECT body, filename
FROM comments c
LEFT JOIN photos p ON c.photo_id = p.id;