show user;

--=================2020/12/24 Assignment===================
--join 관련 실습문제 10문항

--사용 계정 kh
--=========================================================

select * from employee;
select * from department;
select * from job;
select * from location;
select * from nation;
select * from sal_grade;

-----------------------------------------------------------
--1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
-----------------------------------------------------------

/*
'day'로 입력하면 '수요일'로 출력,
'dy'로 입력하면 '수'로 출력
'd'로 입력하면 '4'로 출력 (일요일이 1)
*/

select to_char(to_date(20201225), 'day') 크리스마스
from dual;

-----------------------------------------------------------
--2. 주민번호가 70년대 생이면서 성별이 여자이고,
--   성이 전씨인 직원들의 사원명, 부서명, 직급명을 조회하시오
-----------------------------------------------------------

select * from employee;
select * from department;
select * from job;

-- employee | dept_code = department dept_id
-- employee | job_code = job job_code
-- department | dept_title 부서명
-- job | job_name 직급명

select E.emp_name 사원명, E.emp_no 주민번호, D.dept_title 부서명, J.job_name 직급명
from employee E join department D
     on E.dept_code = D.dept_id
     join job J
     using(job_code)
where emp_no like '7%' 
      and substr(emp_no, 8, 1) in (2, 4)
      and emp_name like '전%';

-----------------------------------------------------------
-- 3. 가장 나이가 적은 사원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.
-----------------------------------------------------------

-- employee | emp_id 사번, emp_name 사원명, dept_code 직급코드, job_code 부서코드
-- department | dept_id 부서코드, dept_title 부서명, location_id 국가코드
-- job | job_code 직급코드, job_name 직급명

select * from employee;
select * from department;
select * from job;

select emp_name
from employee;

select E.emp_id 사번, E.emp_name 사원명,
       extract(year from sysdate) - (decode(substr(E.emp_no, 8, 1),'1', 1900, '2', 1900, 2000) + substr(E.emp_no, 1, 2)) + 1 나이,
       D.dept_title 부서명, J.job_name 직급명
from employee E join department D
     on E.dept_code = D.dept_id
     join job J
     using(job_code)
where extract(year from sysdate) - (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1
      = (select min (extract(year from sysdate) - (decode(substr(emp_no, 8, 1), '1', 1900, '2', 1900, 2000) + substr(emp_no, 1, 2)) + 1)
         from employee);
         
-- extract(year from sysdate) - (decode(substr(E.emp_no, 8, 1),'1', 1900, '2', 1900, 2000) + substr(E.emp_no, 1, 2)) + 1 나이

-- 나이 구하는 식 해설
-- 나이 = 현재년도 - 출생년도 + 1

/*
    extract | 단위별 절삭, year from sysdate는 현재년도만 리턴한다.
    
    decode | (표현식, 값1, 결과1, 값2, 결과2 ...[, 기본값])
    * 위 식에서 주민번호 뒷자리가 1 or 2 일 때에는 1900을 리턴하고, 기본값을 2000으로 리턴하였다.
    * 여기에 주민번호의 1번째 인덱스에서 2번째 자리까지 더해주어 출생년도를 완성
    
    min | 최소값
*/

-----------------------------------------------------------
-- 4. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
-----------------------------------------------------------

select * from employee;
select * from department;

-- employee | emp_id 사번, emp_name 사원명, dept_code 직급코드
-- department | dept_id 부서코드, dept_title 부서명

select E.emp_id 사번, E.emp_name 사원명, D.dept_title 부서명
from employee E join department D
     on E.dept_code = D.dept_id
where E.emp_name like '%형%';

-----------------------------------------------------------
-- 5. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
-----------------------------------------------------------

select * from employee;
select * from department;
select * from job;

-- employee | emp_id 사번, emp_name 사원명, dept_code 부서코드
-- department | dept_id 부서코드, dept_title 부서명
-- job | job_code 직급코드, job_name 직급명

select E.emp_name 직급코드, J.job_name 직급명, E.dept_code 부서코드, D.dept_title 부서명
from employee E join department D
     on E.dept_code = D.dept_id
     join job J
     using(job_code)
where D.dept_title like '해외%';

select dept_title, dept_id
from department;
-- D7 / 해외영업 3부에 해당되는 직원은 없다.

-----------------------------------------------------------
-- 6. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역을 조회하시오.
-----------------------------------------------------------

select * from employee;
select * from department;
select * from location;

-- employee | emp_name 사원명, bonus 보너스포인트 dept_code 부서코드
-- department | dept_id 부서코드, dept_title 부서명, location_id 지역코드
-- location | local_code 지역코드, national_code 국가코드, local_name 지역명

select E.emp_name 사원명, E.bonus 보너스포인트, D.dept_title 부서명, L.local_name 지역명
from employee E join department D
     on E.dept_code = D.dept_id
     join location L
     on D.location_id = L.local_code
where E.bonus is not null
order by 2;

-----------------------------------------------------------
-- 7. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
-----------------------------------------------------------

select * from employee;
select * from department;
select * from location;
select * from job;

-- employee | emp_name 사원명, dept_code 부서코드
-- department | dept_id 부서코드, dept_title 부서명, location_id 지역코드
-- job | job_code 직급코드, job_name 직급명
-- location | local_code 지역코드, national_code 국가코드, local_name 지역명

select E.emp_name 사원명, J.job_name 직급명, D.dept_title 부서명, L.local_name 지역명
from employee E join department D
     on E.dept_code = D.dept_id
     join job J
     using(job_code)
     join location L
     on D.location_id = L.local_code
where E.dept_code in 'D2';

-----------------------------------------------------------
-- 8. 급여등급테이블의 등급별 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
--    (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 동등 조인할 것)
-----------------------------------------------------------

select * from employee;
select * from department;
select * from job;
select * from sal_grade;

-- employee | emp_name 사원명, dept_code 부서코드, salary 급여, bonus 보너스포인트
-- job | job_code 직급코드, job_name 직급명

select E.emp_name 사원명, J.job_name 직급명, E.salary 급여, (nvl(E.bonus, 0) * E.salary + E.salary) * 12 연봉
from employee E join Job J
     using(job_code)
     join sal_grade SG
     using(sal_level)
where E.salary > SG.max_sal;

-----------------------------------------------------------
-- 9. 한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.
-----------------------------------------------------------

select * from employee;
select * from department;
select * from location;
select * from nation;

-- employee | emp_name 사원명, dept_code 부서코드
-- department | dept_id 부서코드, dept_title 부서명, location_id 지역코드
-- location | local_code 지역코드, national_code 국가코드, local_name 지역명
-- nation | national_code  국가코드, national_name 국가명

select E.emp_name 사원명, D.dept_title 부서명, L.local_name 지역명, N.national_name 국가명
from employee E join department D
     on E.dept_code = D.dept_id
     join location L
     on D.location_id = L.local_code
     join nation N
     using(national_code)
where national_code in ('KO', 'JP')
order by 3;

-----------------------------------------------------------
-- 10. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
-- self join 사용
-----------------------------------------------------------

select E1.emp_name 사원명, E1.dept_code 부서코드, E2.emp_name 동료이름
from employee E1 inner join employee E2
     on E1.dept_code = E2.dept_code
where e1.emp_name ^= e2.emp_name
order by 1, 3;

-----------------------------------------------------------
-- 11. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오.
-----------------------------------------------------------

select * from employee;
select * from department;
select * from job;

-- employee | emp_name 사원명, dept_code 부서코드, salary 급여, bonus 보너스포인트
-- department | dept_id 부서코드, dept_title 부서명, location_id 지역코드
-- job | job_code 직급코드, job_name 직급명

select E.emp_name 사원명, J.job_name 직급명, E.salary 급여
from employee E join department D
     on E.dept_code = D.dept_id
     join job J
     using(job_code)
where E.bonus is null and job_name in ('차장', '사원');

-----------------------------------------------------------
-- 12. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
-----------------------------------------------------------

select * from employee;

select count(decode(quit_yn, 'Y', 1)) 퇴사, count(decode(quit_yn, 'N', 1)) 재직
from employee;