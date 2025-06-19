-- Active: 1750257071293@@127.0.0.1@3306@stargram
/*
7. 테이블 조인하기
7.1 조인이란
*/

-- 두 테이블로 나뉜 여러 정보를 하나로 연결하여 가져오는 명령
-- 테이블 간에 일치하는 컬럼을 기준으로 두 테이블을 하나로 합쳐 보여줌

-- 조인 컬럼(기준이 되는 컬럼): 
-- 두 테이블이 동시에 가지고 있는 컬럼으로 조인 하기 위해 사용하는 컬럼
-- 보통 한 테이블의 외래키(FK)와 다른 테이블의 기본키(PK)를 사용

-- (참고) 외래키를 사용하지 않아도 공통적인 데이터가 있다면 JOIN은 할 수 있음
-- 그럼 외래키는 왜 쓰는 걸까? 데이터의 무결성을 보장하기 위한 제약 조건
-- 존재하지 않는 ID를 참조하지 못하게 막음
-- 부모 테이블 데이터 삭제 시 자식 데이터를 어떻게 처리할지 정의 가능
-- 실수로 잘못된 참조값을 넣는 것 방지

-- 조인 하기
-- 특정 사진에 달린 모든 댓글의 닉네임과 본문을 조회하는 법?
USE stargram;

-- 1번 사진 댓글 정보 조회
SELECT *
FROM comments
WHERE photo_id = 1;

-- 테이블 조인 형식
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블A
-- JOIN 테이블B ON 테이블A.조인_컬럼 = 테이블B.조인_컬럼
-- JOIN만 명시하면 기본적으로 INNER JOIN으로 해석 (주로 생략해서 사용)

-- 댓글 본문과 사용자 닉네임을 합쳐서 가져오기
SELECT *
FROM comments
JOIN users ON comments.user_id = users.id;
-- JOIN users: 사용자 테이블을 붙일건데 
-- ON: 댓글 테이블의 외래키 = 사용자 테이블의 기본키와 같은 것끼리

-- 1번 사진에 달린 모든 댓글 본문과 작성자 닉네임 가져오기
-- 쿼리문 실행순서
SELECT body, nickname -- 4) 닉네임과 본문을 조회한다.
FROM comments -- 1) 댓글 테이블에
JOIN users -- 2) 사용자 테이블 조인한다.
ON comments.user_id = users.id -- 해당 조건으로
WHERE photo_id = 1; -- 3) 1번 사진과 관련된 것만 남긴 후,

-- 조인의 특징 7가지
-- 1) 조인 컬럼이 필요
-- 두 테이블을 연결하기 위한 공통의 컬럼
-- 보통 왜래키와 기본키를 기준으로 조인
SELECT *
FROM comments
JOIN users ON comments.user_id = users.id; -- 조인 컬럼(외래키) = 조인 컬럼(기본키)

-- 2) 조인 컬럼은 서로 자료형이 일치
-- 일치해야 조인 가능
-- 예: 숫자 1과 문자열 '1'은 서로 조인 불가

-- 3) 조인 조건이 필요
-- ON 절과 함께 사용
-- 두 테이블을 어떻게 연결할지를 조인 조건으로 명시

-- 4) 연속적인 조인 가능
-- 연속 조인 연습
SELECT nickname, body, filename -- 4) 원하는 컬럼 조회
FROM comments -- 1) 댓글 테이블에
JOIN users ON comments.user_id = users.id -- 2) 사용자 테이블 조인하고
JOIN photos ON comments.photo_id = photos.id; -- 3) 다시 사진 테이블 조인 후

-- 5) 중복 컬럼은 테이블명을 붙여 구분
-- *컬럼명이 같은 경우* 어느 테이블의 것인지 명시해야함(그렇지 않은 경우 에러 발생)
-- 사용 예: 중복 컬럼 id에 테이블명 명시
SELECT comments.id, body, users.id, nickname
FROM comments
JOIN users ON comments.user_id = users.id
WHERE photo_id = 2;

-- 6) 테이블명에 별칭 사용 가능
-- 간결한 쿼리 작성 및 가독성 향상에 도움
-- 사용 예: comments 테이블과 users 테이블에 별칭 붙이기
SELECT body, nickname
FROM comments AS c
JOIN users AS u ON c.user_id = u.id;
-- 참고: 테이블에 별칭을 붙일 땐 AS를 거의 생략
SELECT body, nickname
FROM comments c
JOIN users u ON c.user_id = u.id;

-- 7) 다양한 조인 유형 사용 가능
-- 다양한 결과 테이블 생성에 도움
-- INNER 조인
-- LEFT 조인
-- RIGHT 조인
-- FULL 조인
-- 실무에서는 INNER와 LEFT를 주로 사용



-- Quiz
-- 1. 다음은 comments 테이블과 photos 테이블을 조인하는 쿼리이다.
-- 빈칸을 순서대로 채워 쿼리를 완성하시오. (예: aaa, bbb, ccc)

-- SELECT body, filename
-- FROM comments ① __________
-- ② __________ photos AS p ③ __________ c.photo_id = p.id;

-- 정답: AS c, JOIN, ON

-- 2. 다음 조인에 대한 설명으로 옳지 않은 것은?
-- ① 조인 칼럼은 자료형이 달라도 된다.
-- ② 조인 조건은 JOIN 절의 ON 키워드 다음에 작성한다.
-- ③ 중복 칼럼은 '테이블명.칼럼명'과 같이 테이블명을 붙여 구분한다.
-- ④ 조인 테이블에 별칭을 붙일 때는 AS 키워드를 사용한다.

-- 정답: 1


/*
7.2 조인의 유형
*/
-- 1. INNER 조인
-- 가장 기본이 되는 조인
-- 두 테이블에서 조인 조건을 만족하는(조인 컬럼이 같은) 데이터를 찾아 조인함
-- INNER 키워드 생략 가능

-- photos 테이블과 users 테이블 INNER 조인
SELECT *
FROM photos AS p
INNER JOIN users AS s ON p.user_id = s.id;

-- 축약형
SELECT *
FROM photos p
JOIN users u ON p.user_id = u.id;

-- 반대로
SELECT *
FROM users u
JOIN photos p ON u.id = p.user_id;

-- 형식:
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블A
-- INNER JOIN 테이블B ON 테이블A.조인_컬럼 = 테이블B.조인_컬럼;


-- OUTER JOIN: 두 테이블 간의 조인 결과에 누락된 행을 포함시킬 수 있는 조인 방식, 종류는 크게 3가지
-- 2. LEFT 조인
-- 왼쪽 테이블(FROM 절 테이블)의 모든 데이터에 오른쪽 테이블(JOIN 절 테이블)을 조인함
-- 왼쪽 테이블은 모든 데이터를 가져오지만, 오른쪽 테이블은 조인 조건을 만족하는 것만 가져옴
-- 조인 조건을 만족하지 않는 경우, NULL 값으로 채움

-- 형식:
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블A
-- LEFT JOIN 테이블B ON 테이블A.조인_컬럼 = 테이블B.조인_컬럼;

-- photos 테이블과 users 테이블 LEFT 조인
SELECT *
FROM photos p
LEFT JOIN users s ON p.user_id = s.id;

-- 3. RIGHT 조인
-- 오른쪽 테이블(JOIN 절 테이블)의 모든 데이터에 왼쪽 테이블(FROM 절 테이블)을 조인함
-- 오른쪽 테이블은 모든 데이터를 가져오지만, 왼쪽 테이블은 조인 조건을 만족하는 것만 가져옴
-- 조인 조건을 만족하지 않는 경우, NULL 값으로 채움
-- LEFT 조인에서 기준만 바뀌고 동일하기에 거의 사용되지 않음

-- 형식:
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블A
-- RIGHT JOIN 테이블B ON 테이블A.조인_컬럼 = 테이블B.조인_컬럼;

SELECT *
FROM photos p
RIGHT JOIN users s ON p.user_id = s.id;

-- 4. FULL 조인
-- 두 테이블의 모든 데이터를 결합하는 조인
-- 조인 불가능한 것은 NULL 값으로 채움
-- LEFT 조인 + RIGHT 조인의 결과에 중복을 제거한 것
-- (두 테이블에 조인 컬럼 값이 같은 데이터뿐만 아니라, 한쪽 테이블에 존재하는 데이터도 모두를 반환)

-- MySQL은 FULL 조인을 제공하지 않음
-- 형식:
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블A
-- FULL JOIN 테이블B ON 테이블A.조인_컬럼 = 테이블B.조인_컬럼;

-- 5. UNION 연산자
-- 두 쿼리의 결과를 하나의 테이블로 합치는 집합 연산자
-- SELECT 결과를 단순히 위아래로 붙이는 연산
-- UNION을 사용하려면 두 쿼리의 결과 테이블 내 컬럼 개수와 각 컬럼의 자료형이 일치해야 함

-- 중복 튜플 제거하고 합치기
-- (쿼리A)
-- UNION
-- (쿼리B);
(
SELECT *
FROM photos p
LEFT JOIN users u ON p.user_id = u.id
)
UNION
(
SELECT *
FROM photos p
RIGHT JOIN users u ON p.user_id = u.id
);

-- 중복 튜플 그대로 둔 채 합치기
-- (쿼리A)
-- UNION ALL
-- (쿼리B);
(
SELECT *
FROM photos p
LEFT JOIN users u ON p.user_id = u.id
)
UNION ALL
(
SELECT *
FROM photos p
RIGHT JOIN users u ON p.user_id = u.id
);


-- Quiz
-- 3. 다음 빈칸에 들어갈 용어를 차례대로 쓰시오. (예: ㄱㄴㄷㄹㅁ)
-- ① __________: 가장 기본적인 조인 유형으로, 두 테이블에서 조인 조건을 만족하는 튜플을 찾아 조인
-- ② __________: 왼쪽 테이블의 모든 튜플에 대해 조인 조건을 만족하는 오른쪽 테이블의 튜플을 조인하고, 조인할 수 없는 경우 NULL 값으로 채움
-- ③ __________: 오른쪽 테이블의 모든 튜플에 대해 조인 조건을 만족하는 왼쪽 테이블의 튜플을 조인하고, 조인할 수 없는 경우 NULL 값으로 채움
-- ④ __________: 두 테이블 사이에서 조인이 가능한 튜플뿐만 아니라 조인 불가능한 튜플도 모두 가져오고 빈 칼럼은 NULL 값으로 채움
-- ⑤ __________: 두 쿼리의 결과 테이블을 하나로 합침

-- (ㄱ) FULL JOIN
-- (ㄴ) INNER JOIN
-- (ㄷ) UNION
-- (ㄹ) RIGHT JOIN
-- (ㅁ) LEFT JOIN

-- 정답: ㄴㅁㄹㄱㄷ


/*
7.3 조인 실습: 별그램 DB
*/
-- 가장 많이 사용되는 INNER 조인과 LEFT 조인을 연습!

-- 1. 특정 사용자가 올린 사진 목록 출력하기
-- 예: 홍팍이 업로드한 모든 사진의 파일명은?
SELECT nickname, filename
FROM users u
JOIN photos p ON u.id = p.user_id
WHERE nickname = '홍팍';

-- (참고) JOIN과 동시에 필터링가능
SELECT 
  nickname AS 게시자,
  filename AS 파일명
FROM users u
JOIN photos p
  ON u.id = p.user_id
  AND nickname = '홍팍';


-- 2. 특정 사용자가 올린 사진의 좋아요 개수
-- 예: 홍팍이 올린 모든 사진의 좋아요 개수는?
-- SELECT COUNT(*)
-- SELECT *
-- FROM users u -- 1) 사용자 정보를 가지고
-- JOIN photos p -- 2) 사진 정보를 합쳐서
--   ON u.id = p.user_id
-- JOIN likes l -- 3) 좋아요 정보도 합쳐서
--   ON p.id = l.photo_id
-- WHERE nickname = '홍팍'; -- 홍팍이 올린
SELECT *
FROM users
JOIN photos ON users.id = photos.user_id
JOIN likes ON photos.id = likes.photo_id;

-- 3. 특정 사용자가 쓴 댓글 개수
-- 예: 해삼이가 작성한 모든 댓글의 개수는?
SELECT COUNT(*)
FROM comments c
JOIN users u ON c.user_id = u.id AND nickname = '해삼';

-- 4. 모든 댓글 본문과 해당 댓글의 달린 사진의 파일명
-- 예: 모든 댓글 본문과 함께 그 댓글이 달린 사진의 파일명을 함께 조회하려면?
SELECT body, filename
FROM comments c
LEFT JOIN photos p ON c.photo_id = p.id;


-- Quiz
-- 4. 다음 설명이 맞으면 O, 틀리면 X를 순서대로 표시하시오. (예: O, X, O, X)
-- ① INNER 조인은 INNER 키워드를 생략할 수 있다. (  )
-- ② INNER 조인은 조인이 불가능한 튜플도 가져와 연결한다. (  )
-- ③ LEFT 조인은 왼쪽 테이블의 모든 데이터에 대해 오른쪽 테이블에 조인 조건을 만족하는 데이터를 가져와 연결하고 
--   오른쪽 테이블에 해당하는 데이터가 없으면 NULL 값으로 채운다. (  )
-- ④ 조인 조건에 AND 연산자를 사용하면 조인과 동시에 데이터 필터링을 할 수 있다. (  )

-- 정답: O X O O


/*
	10.3 데이터 모델링 실습: 쇼핑몰 DB
*/
-- 다음 요구사항을 참고해 데이터 모델링(개념적 -> 논리적 -> 물리적)을 거쳐 최종 데이터베이스를 구현해 보자!

-- 요구사항
-- 쇼핑몰에서 사용할 데이터베이스를 만들려고 합니다. 
-- 사용자는 한 번에 여러 상품을 주문할 수 있고, 여러 번에 걸쳐 주문할 수도 있습니다.
-- 주문이 들어오면 주문 시간과 상품을 기록으로 남기고, 주문이 결제되면 결제 정보도 기록으로 남깁니다.

-- 1. 개념적 데이터 모델링
-- 데이터베이스 전문가 뿐만 아니라 비즈니스 담당자, 최종 사용자 등 누가 보더라도 쉽게 이해할 수 있게 작성

-- draw.io(https://app.diagrams.net/)에 실습

-- 1) 요구사항 분석을 통한 엔티티 선정
-- 사용자, 주문, 상품, 결제

-- 2) 엔티티 간 관계를 화살표와 텍스트로 표시
-- [사용자] -- 주문하다 --> [주문] -- 결제하다 --> [결제]
-- [주문] <-- 장바구니에 담다 --> [상품]

-- 2. 논리적 데이터 모델링
-- 개념적 데이터 모델에 세부 내용을 추가
-- 기술 팀의 판단과 모든 이해 관계자와의 소통과 피드백을 통한 점진적 개선

-- 1) 관계의 카디널리티 구체화
-- 사용자 -> 주문은 선택적 일대다 관계, 주문 -> 사용자는 필수적 일대일 관계
-- 주문 -> 결제는 선택적 일대일 관계, 결제 -> 주문은 필수적 일대일 관계
-- 주문 -> 상품은 필수적 일대다 관계, 상품 -> 주문은 선택적 일대다 관계 

-- 이때 주문과 상품은 다대다 관계

-- 2) 다대다 관계를 위한 중간 엔티티 추가 및 관계 정의
-- 주문과 상품 사이에 주문 상세 엔티티를 추가하고
-- 주문 -> 주문 상세를 필수적 일대다 관계
-- 상품 -> 주문 상세를 선택적 일대다 관계로 연결

-- 3) 엔티티의 속성 구체화 및 PK, FK 선정
-- 각 엔티티를 식별하기 위한 기본키는 PK로 표기
-- 엔티티 간 관계를 연결하기 위한 외래키는 FK로 표기
-- 일반 속성도 요구사항 분석 과정을 통해 추가

-- 3. 물리적 데이터 모델링
-- 논리적 데이터 모델을 특정 DBMS에 맞게 테이블 형태로 구체화
-- 기술 팀이 전문가 관점에서 데이터베이스의 성능과 효율성을 고려해 테이블을 설계

-- 1) 엔티티는 테이블로, 속성은 컬럼으로 변경
-- 각 테이블의 기본키는 id로, 외래키는 XXX_id로 명명해 일관성을 높임

-- 2) 컬럼의 자료형 정의(DBMS에 맞게)
-- 예: MySQL에서 지원하는 자료형 중 해당 컬럼을 가장 잘 저장할 수 있는 것으로 표시

-- (참고) VARCHAR와 ENUM 자료형 선택하기 
-- orders 테이블의 status
-- payments 테이블의 payment_type
-- products 테이블의 product_type
-- 위 컬럼은 모두 VARCHAR로 정의돼 있으나 상황에 따라 ENUM이 더 적절할 수 있음
-- 예를 들어 product_type(상품 유형)이 '냉동', '냉장', '상온'의 3가지 값만 가진다면 ENUM이 좋음 
-- ENUM은 미리 정의한 값 집합에서만 입력을 허용 하기 때문에 데이터의 무결성을 보장하고 빠른 검색 성능을 제공함 
-- 그러나 product_type이 얼마든지 추가되거나 바뀔 수 있는 경우라면 확장성 측면에서 VARCHAR가 유리함
-- 어느 쪽이 유리한지는 DB 설계자가 판단해 적용한다.
-- (그 외 고정 길이 글자이면 CHAR: 우편번호, 국가코드 등)

-- 3) 고유키 및 인덱스 지정
-- users 테이블의 email과 products 테이블의 name을 고유키로 지정
-- 고유키는 UK로 표시
-- products 테이블의 name을 인덱스 처리
-- 상품명으로 검색 및 정렬할 때 성능을 높임

-- 고유키(Unique Key, UK)란 테이블 내에서 값이 고유해야 하는 특정 칼럼 또는 칼럼의 조합을 말함
-- 고유 키로 설정한 칼럼에 중복 값이 입력될 경우 에러가 발생하므로 중복 입력을 예방하려면 고유키로 지정

-- 인덱스(index)는 데이터베이스에서 검색 및 정렬 성능을 최적화하는 데이터 구조로, 
-- 테이블 전체를 스캔하지 않고도 데이터를 효율적으로 찾을 수 있도록 해 줌
-- 인덱스는 두꺼운 책에 끼워 둔 책갈피처럼 데이터를 빠르게 검색할 수 있는 경로를 제공해 
-- 데이터베이스의 검색 성능을 크게 향상시킴
-- MySQL은 기본키(PK), 외래키(FK), 고유키(UK)에 자동으로 인덱스를 생성
-- 인덱스는 검색 및 정렬 성능을 향상시키는 장점도 있지만, 저장 공간을 많이 차지하는 단점도 있음
-- 따라서 인덱스를 생성할 때는 성능과 저장 공간에 따른 비용의 두 요소를 고려해야 함
-- 주로 WHERE 절에 자주 사용되는 컬럼이나 자주 조회하거나 자주 정렬하는 컬럼에만 인덱스를 생성

-- 4. DB 구현하기
-- 물리적 데이터 모델(ER Diagram)을 보고 실제 데이터베이스로 구현
-- 테이블 생성 쿼리를 작성해보자

-- 데이터 모델링(data_modeling) 연습 DB 생성 및 진입
CREATE DATABASE data_modeling;
USE data_modeling;