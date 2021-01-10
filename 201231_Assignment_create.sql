/*
## @실습문제 : CREATE
 테이블을 적절히 생성하고, 테이블, 컬럼주석을 추가하세요.
1. 첫번째 테이블 명 : EX_MEMBER
* MEMBER_CODE(NUMBER) - 기본키                       -- 회원전용코드 
* MEMBER_ID (varchar2(20) ) - 중복금지                  -- 회원 아이디
* MEMBER_PWD (char(20)) - NULL 값 허용금지                 -- 회원 비밀번호
* MEMBER_NAME(varchar2(30))                             -- 회원 이름
* MEMBER_ADDR (varchar2(100)) - NULL값 허용금지                    -- 회원 거주지
* GENDER (char(3)) - '남' 혹은 '여'로만 입력 가능             -- 성별
* PHONE(char(11)) - NULL 값 허용금지                   -- 회원 연락처
*/

create table EX_MEMBER (
    MEMBER_CODE number,
    MEMBER_ID varchar2(20),
    MEMBER_PWD char(20) not null,
    MEMBER_NAME varchar2(30),
    MEMBER_ADDR varchar2(100) not null,
    GENDER char(3),
    PHONE char(11) not null,
    constraint PK_MEMBER_CODE primary key(MEMBER_CODE),
    constraint UQ_MEMBER_ID unique (MEMBER_ID),
    constraint CK_MEMBER_CHECK check(GENDER in ('남', '여'))
);


--컬럼 주석 달기
comment on column EX_MEMBER.MEMBER_CODE is '회원전용코드';
comment on column EX_MEMBER.MEMBER_ID is '회원 아이디';
comment on column EX_MEMBER.MEMBER_PWD is '회원 비밀번호';
comment on column EX_MEMBER.MEMBER_NAME is '회원 이름';
comment on column EX_MEMBER.MEMBER_ADDR is '회원 거주지';
comment on column EX_MEMBER.GENDER is '성별';
comment on column EX_MEMBER.PHONE is '회원 연락처';


--컬럼 주석 확인
select *
from user_col_comments
where table_name = 'EX_MEMBER';

--제약조건 확인
select UC.table_name, 
       UCC.column_name, 
       UC.constraint_name,
       UC.constraint_type,
       UC.search_condition
from user_constraints UC join user_cons_columns UCC
     on UC.constraint_name = UCC.constraint_name
where UC.table_name = 'EX_MEMBER';

--테이블 내용 확인
select * from EX_MEMBER;

/*
2. EX_MEMBER_NICKNAME 테이블을 생성하자. (제약조건 이름 지정할것)
(참조키를 다시 기본키로 사용할 것.)
* MEMBER_CODE(NUMBER) - 외래키(EX_MEMBER의 기본키를 참조), 중복금지       -- 회원전용코드
* MEMBER_NICKNAME(varchar2(100)) - 필수                       -- 회원 이름
*/

--drop table EX_MEMBER_NICKNAME;
create table EX_MEMBER_NICKNAME (
    MEMBER_CODE number,
    MEMBER_NICKNAME varchar2(100) not null,
    constraint PK_MEMBER_NICKNAME_CODE primary key(MEMBER_CODE),
    constraint FK_MEMBER_NICKNAME_CODE foreign key(MEMBER_CODE)
                                      references EX_MEMBER(MEMBER_CODE)
);

--컬럼 주석 달기
comment on column EX_MEMBER_NICKNAME.MEMBER_CODE is '회원전용코드';
comment on column EX_MEMBER_NICKNAME.MEMBER_NICKNAME is '회원 이름';

--컬럼 주석 확인
select *
from user_col_comments
where table_name = 'EX_MEMBER_NICKNAME';

--제약조건 확인
select UC.table_name, 
       UCC.column_name, 
       UC.constraint_name,
       UC.constraint_type,
       UC.search_condition
from user_constraints UC join user_cons_columns UCC
     on UC.constraint_name = UCC.constraint_name
where UC.table_name = 'EX_MEMBER_NICKNAME';

--테이블 내용 확인
select * from EX_MEMBER_NICKNAME;