Database Client 8.35설치

JAVA 프로그래밍 능력단위평가 문제오답

주관식
call by value와 call by reference

method 호출시 매개값으로 원시자료형과 참조자료형의 차이
int a = 20;
int[] b = {10, 20, 30};

public void method1(int a, int[] b) {
  a = a + 10;
  b = b[2] + 10;
}
호출된 메소드의 반환타입은 없음 고로 지역변수로 a 실행된 
a = a + 10은 실행된 후 값이 돌아오지 않음 정답 20
b = b[1] + 10 는 call by reference. 매개변수로 int[] b의 참조값이 들어옴
참조된 b배열의 2번 인덱스는 main method의 b배열과 동일한 배열을 참조하므로
10만큼 증가된 값이 적용됨. 정답 b[1] == 30


	다음중 오버라이드의 설명으로 잘못 된 것은 무엇입니까?

1번보기	오버라이드는 부모의 모든 메서드를 다룰 수 있다. 
-- 부모의 메소드의 접근제한자가 무엇이냐에 따라 다름 
2번보기	오버라이드는 부모의 메서드를 재정의 하여 사용 하는 것이다.
3번보기	오버라이드는 기본적으로 부모-자식 관계에서 사용 된다.
4번보기	오버라이드는 부모의 메서드를 통째로 바꿔 쓸 수도 있으나, 부모의 기능을 사용 할 수도 있다. 
-- 재정의하여 사용할 수 도 있고 super()을 통해서 부모의 메소드도 사용 가능하다.

모범답안	1	제출답안	4

	다음중 다형성에 대한 설명으로 옳지 않은 것은 무엇입니까?

1번보기	필드에 다형성을 적용 한 것을 필드의 다형성 이라고 한다.
2번보기	다형성은 부모 자식 클래스 간에만 사용 할 수 있다.
-- 다형성은 부모 자식뿐만 아니라 조상도 사용 가능하다.

3번보기	매개변수의 다형성을 활용 하면 여러 타입의 객체가 매개변수로 왔을 때 하나의 메서드로 대응이 가능 하다.
4번보기	필드 다형성과 매개변수 다형성은 사용되는 변수의 위치 차이가 있을 뿐이다.
-- TIRE tire = new KumhoTire() 다형성 챕터에서 필드값으로 타이어를 교체했던걸 리마인드할것
-- 부모타입에 자식타입이 대입 될 경우 자동변환발생, 매개변수도 마찬가지 Vehicle vehicle 리마인드할것

모범답안	2	제출답안	4


MySQL extension 설치

100g당 가격을 다음과 같이 조회하는 방법
price / gram * 100

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
ch06.sql Relation

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

-------------------  [43일차 06.13] ------------------- 
ch07.sql JOIN

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

-------------------  [44일차 06.16] ------------------- 

ch07_quiz.sql

3번 문제
SELECT name, title
FROM borrow_records br
JOIN members m ON br.member_id = m.id
JOIN books b ON br.book_id = b.id;

그룹화
GROUP BY 컬럼1, 컬럼2
HAVING 
-- 1. 그룹화 필터링(HAVING)
-- 그룹화한 결과에서 특정 조건을 만족하는 그룹의 데이터만 가져오는 것
-- GROUP BY 절에 HAVING 절을 추가하여 수행
-- 주로 집계 함수 결과에 조건을 걸 때 사용

ORDER BY 컬럼1 ASC | DESC
LIMIT N;

대부분의 경우 SELECT가 가장 마지막에 실행되지만
ORDER BY와 LIMIT는 그 후에 실행된다
ORDER BY - SELECT로 조회한 데이터를 바탕으로 오름차순 or 내림차순으로 정렬
LIMIT N; - 조회한 데이터 혹은 정렬한 데이터를 바탕으로 몇개를 출력할지 정함
LIMIT N OFFSET M; = 시작점을 정할 수 있음 M = 건너뛸 레코드의 개수, 
OFFSE은 생략 가능하지만 생략하게되면 순서가바뀜 LIMIT M, N

ch08.sql Line472
SELECT 
  nickname AS '주문자명',
  SUM(amount) AS '주문 금액'
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN payments p ON o.id = p.order_id
GROUP BY nickname
HAVING SUM(amount) >= 30000;

-------------------  [44일차 06.17] ------------------- 

서브쿼리
SELECT - 1x1 단일값만 반환하는 서브쿼리만 사용가능
여러 행을 반환하게 되면 SQL이 어떤 값을 사용해야 할지 모름

FROM/JOIN - NxM 반환하는 행과 컬럼의 개수에 제한이 없음, 단! AS 키워드를 통한 별칭은 지정해야함 안하게되면 alias 에러 발생
- FROM/JOIN의 값으로는 TABLE이 사용되기때문에 다양한 값이 들어올 수 있음

WHERE/HAVING - 1x1, Nx1 반환하는 서브쿼리만 사용 가능(필터링의 조건으로 값 또는 값의 목록을 사용하기 때문)
예 - WHERE id = (서브쿼리의 결과값, 1), WHERE id = (서브쿼리의 결과목록, 1, 2, 3)

IN, ANY, ALL, EXISTS


-------------------  [45일차 06.18] ------------------- 

DATETIME 타입: DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
DATE 타입: reg_date DATETIME NOT NULL DEFAULT CURRENT_DATE
ON UPDATE CURRENT_TIMESTAMP: UPDATE시 자동으로 수정 시간도 갱신

Eclipe chap11 > 01 > DateExample 
날짜 객체 훑어보기


1. Date클래스를 사용할땐 SimpleDateFormat사용
  Date now = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh시 mm분 ss초");
  String strNow2 = sdf.format(now); // 원하는 날짜 포맷으로 문자열 반환
  System.out.println(strNow2); = 2025년 06월 18일 오후 02시 59분 26초

2. LocalDateTime클래스를 사용할땐 DateTimeFormatter사용
  LocalDateTime dateTime = LocalDateTime.now();
  DateTimeFormatter fommatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초");
  System.out.println(dateTime.format(fommatter)); = 2025년 06월 18일 14시 59분 26초

Eclipse -> jdbc-board프로젝트 구조 분석하기


-- 게시글에 달린 댓글까지 지워지는 쿼리문
-- 댓글 테이블
CREATE TABLE comment (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  board_no INTEGER NOT NULL,
  commenter VARCHAR(50),
  comment TEXT,
  reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (board_no) REFERENCES board(no) ON DELETE CASCADE
  -- ON DELETE CASCADE: 외래키(FK)에 설정하는 옵션으로
  -- 부모 테이블의 행이 삭제될 때, 해당 행을 참조하는 자식 테이블의 행들도 자동으로 삭제
  -- 예: board의 특정 게시글이 삭제되면 그 게시글에 달린 comment들도 자동으로 삭제
);

-------------------  [46일차 06.19] ------------------- 

다이어그램 사이트
https://app.diagrams.net/

-- NOT NULL UNIQUE 제약조건이 걸려있는 속성은 후보키, 대체키라고 불림

-- entity = 테이블
-- attribute = 속성 = 컬럼
-- instance = 객체 = 열(row)

완전 함수 종속: 일반 속성이 기본키의 전체에 의해 결정 됨
부분 함수 종속: 일반 속성이 기본키의 일부에 의해 결정 됨

09_JavaScript -> 9_ajax.html
