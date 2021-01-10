--=================2020/12/30 Assignment===================
--chun 대학 관련 실습문제 10문항

--사용 계정 chun
--=========================================================

/*
-------------------------------------------------------------
1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른
순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가
표시되도록 한다.)

학번                이름           입학년도
---------- -------------------- -----------
9973003            김용근         1999-03-01
A473015            배용원         2004-03-01
A517105            이신열         2005-03-01
-------------------------------------------------------------
*/

select * from tb_department;
select * from tb_student;
select * from tb_professor;
select * from tb_class;
select * from tb_class_professor;
select * from tb_grade;

-- student_no 학번, student_name 이름, entrance_date 입학년도, department_no 학과코드

select student_no 학번, student_name 이름, to_char(entrance_date, 'yyyy-mm-dd') 입학년도
from tb_student
where department_no in '002'
order by 3 asc;

/*
-------------------------------------------------------------
2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 그 교수의
이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. (* 이때 올바르게 작성한 SQL
문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)

PROFESSOR_NAME         PROFESSOR_SSN
--------------------   --------------
강혁                    601004-1100528
박강아름                 681201-2134896
-------------------------------------------------------------
*/

select * from tb_professor;

-- professor_name 교수 이름, professor_ssn 교수 주민번호

select professor_name "교수 이름", professor_ssn "교수 주민번호"
from tb_professor
where professor_name not like '___';

-- % : 0글자 이상
-- _ : 딱 1글자

/*
-------------------------------------------------------------
3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단
이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오. (단, 교수 중
2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 ‘만’으로
계산한다.)

   교수이름              나이
-------------------- ----------
    제상철                28
    주영상                28
    김명석                30
    신영호                30
    박지평                32
…
75 rows selected
-------------------------------------------------------------
*/

select * from tb_professor;

--박지평 760210 김태봉 760421 생일순 정렬 질문
--professor_name 교수 이름, professor_ssn 교수 주민번호
--decode(표현식, 값1, 결과1, 값2, 결과2, 값3, 결과3...[, 기본값])

--decode 활용
select professor_name "교수 이름", 
       extract(year from sysdate) - 
       (decode(substr(professor_ssn, 8, 1), '1', 1900) + 
       substr(professor_ssn, 1, 2)) 나이
from tb_professor
where substr(professor_ssn, 8, 1) = '1'
order by 2;

--case 활용
select professor_name "교수 이름",
       case
       when substr(professor_ssn, 8, 1) = '1'
            then (to_char(sysdate, 'yyyy')) - (19||(substr(professor_ssn, 1, 2)))
       end 나이
from tb_professor
where substr(professor_ssn, 8, 1) = '1'
order by 2;

/*
-------------------------------------------------------------
4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는
"이름" 이 찍히도록 한다. (성이 2자인 경우는 교수는 없다고 가정하시오)

이름
--------------------------------------
진영
윤필
…
…
해원
혁호
114 rows selected
-------------------------------------------------------------
*/

select * from tb_professor;

--professor_name 교수 이름

--2글자, 4글자 이름 제외
select substr(professor_name, 2) 이름
from tb_professor
where professor_name like '___';

--문제 제시대로 114 rows 출력
select substr(professor_name, 2) 이름
from tb_professor;

/*
-------------------------------------------------------------
5. 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가? 이때,
19살에 입학하면 재수를 하지 않은 것으로 간주한다.

STUDENT_NO      STUDENT_NAME
---------- --------------------
A513035         박경애
A513065         이경택
…
…
A241053         이희수
A241056         이희진
204 rows selected
-------------------------------------------------------------
*/

select * from tb_student;

-- 입학년도 - 출생년도 > 19

select student_no, student_name
from tb_student
where extract(year from entrance_date) - extract(year from to_date(substr(student_ssn, 1, 6))) > 19
order by 1 asc;

/*
-------------------------------------------------------------
6. 2020 년 크리스마스는 무슨 요일인가?
-------------------------------------------------------------
*/

select to_char(to_date(20201225), 'day') 크리스마스
from dual;

/*
-------------------------------------------------------------
7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇
월 몇 일을 의미할까? 또 TO_DATE('99/10/11','RR/MM/DD'),
TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미할까?
-------------------------------------------------------------
*/

-- yy 현재년도 기준으로 판단 20yy
-- rr 반세기에 걸쳐 현재년도 기준으로 판단
--     1. 00~49 2000 ~ 2049
--     2. 50~99 1950 ~ 1999

select to_char(TO_DATE('99/10/11'),'YYYY/MM/DD') from dual;
-- 1999

select to_char(TO_DATE('49/10/11'),'YYYY/MM/DD') from dual;
-- 2049

select to_char(TO_DATE('99/10/11'),'RRRR/MM/DD') from dual;
-- 1999

select to_char(TO_DATE('49/10/11'),'RRRR/MM/DD') from dual;
-- 2049

/*
-------------------------------------------------------------
8. 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 2000 년도
이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.

STUDENT_NO      STUDENT_NAME
---------- --------------------
9919024         김계영
9831163         이권민
…
…
9811251         김충원
9911206         임충헌
52 rows selected
-------------------------------------------------------------
*/

select * from tb_student;

select student_no, student_name
from tb_student
where student_no not like 'A%';

/*
-------------------------------------------------------------
9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단,
이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한
자리까지만 표시한다.

평점
----------
 3.6
1 개의 행이 선택되었습니다.
-------------------------------------------------------------
*/

select * from tb_student;
select * from tb_grade;

select * from tb_grade
where student_no = 'A517178';

select round(avg(point), 1) 평점
from tb_grade
where student_no = 'A517178';

-- round(number[, position])
-- 반올림
-- avg 평균

/*
-------------------------------------------------------------
10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값이
출력되도록 하시오.

학과번호    학생수(명)
---------- ----------
001         14
002         3
…
…
061         7
062         8
62 rows selected
-------------------------------------------------------------
*/

select * from tb_student;

--department_no 학과번호

select department_no 학과번호, count(*) 학생수
from tb_student
group by department_no
order by 1;

--group by 
--세부 그룹핑을 지정, 컬럼, 가공된 값을 기준으로 그룹핑 가능

/*
-------------------------------------------------------------
11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을
작성하시오.

COUNT(*)
----------
 9
-------------------------------------------------------------
*/

select * from tb_student;

-- coach_professor_no 지도 교수 번호

select count(*)
from tb_student
where coach_professor_no is null;

/*
-------------------------------------------------------------
12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 단,
이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여
소수점 이하 한 자리까지만 표시한다.

-------------------------------------------------------------
*/

select * from tb_student;
select * from tb_grade;

select *
from tb_grade
where student_no = 'A112113';

select substr(term_no, 1, 4) 년도, round(avg(point), 1) "년도 별 평점"
from tb_grade
where student_no = 'A112113'
group by substr(term_no, 1, 4)
order by substr(term_no, 1, 4);

/*
-------------------------------------------------------------
13. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을
작성하시오.

학과코드명               휴학생 수
------------- ------------------------------
001                         2
002                         0
003                         1
061                         2
062                         2
62 rows selected
-------------------------------------------------------------
*/

select * from tb_student;

-- absence_yn 휴학 여부

select department_no 학과코드명, count(decode(absence_yn, 'Y', 1)) "휴학생 수"
from tb_student
group by department_no
order by 1;

/*
-------------------------------------------------------------
14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다. 어떤 SQL
문장을 사용하면 가능하겠는가?

동일이름                동명인 수
-------------------- ----------
김경민                     2
김명철                     2
…
…
조기현                     2
최효정                     2
20 rows selected
-------------------------------------------------------------
*/

select * from tb_student;

select student_name 동일이름, count(*) "동명인 수"
from tb_student
group by student_name
having count(*) > 1
order by student_name;

--having
-- 그룹핑한 결과에 대해서 조건절을 제시

/*
-------------------------------------------------------------
15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총
평점을 구하는 SQL 문을 작성하시오. (단, 평점은 소수점 1 자리까지만 반올림하여
표시한다.)

년도      학기      평점
-------- ---- ------------
2001        01      2.5
2001        02      3
2001                2.8
2002        01      2
2002        02      2.5
2002                2.3
2003        01      3.5
2003        02      4.5
2003        03      4
2003                4
2004        01      4
2004        02      3
2004                3.5
                    3.2
-------------------------------------------------------------
*/

select * from tb_student;
select * from tb_grade;

select *
from tb_grade
where student_no = 'A112113';

select nvl(substr(term_no, 1, 4), '종합평균') 년도,
       nvl(substr(term_no, 5, 2), ' ') 학기, round(avg(point), 1) 평점
from tb_grade
where student_no = 'A112113'
group by rollup(substr(term_no, 1, 4), substr(term_no, 5, 2))
order by 1;

-- rollup | cube
-- rollup 단방향 소계
-- cube 양방향 소계
-- grouping을 이용해서 null값 처리 가능 : 실제데이터 0을 리턴, 집계데이터면 1