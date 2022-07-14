DROP TABLE EMP


create table EMP ( empno int,
ename varchar(255),
job varchar(255),
mgr int,
hiredate varchar(255),
sal int,
comm int,
deptno int,
);

insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7369', 'SMITH', 'CLERK', '7902', '17-DEC-2005', '800', '', '20')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7499', 'ALLEN', 'SALESMAN', '7698', '20-FEB-2006', '1600', '300', '30')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7521', 'WARD', 'SALESMAN', '7698', '22-FEB-2006', '1250', '500', '30')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7566', 'JONES', 'MANAGER', '7839', '02-APR-2006', '2975', '', '20')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7654', 'MARTIN', 'SALESMAN', '7698', '28-SEP-2006', '1250', '1400', '30')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7698', 'BLAKE', 'MANAGER', '7839', '01-MAY-2006', '2850', '', '30')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7782', 'CLARK', 'MANAGER', '7839', '09-JUN-2006', '2450', '', '10')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7788', 'SCOTT', 'ANALYST', '7566', '09-DEC-2007', '3000', '', '20')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7839', 'KING', 'PRESIDENT', '', '08-SEP-2006', '5000', '', '10')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7844', 'TURNER', 'SALESMAN', '7698', '08-SEP-2006', '1500', '0', '30')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7876', 'ADAMS', 'CLERK', '7788', '12-JAN-2008', '1100', '', '20')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7900', 'JAMES', 'CLERK', '7698', '03-DEC-2006', '950', '', '30')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7902', 'FORD', 'ANALYST', '7566', '03-DEC-2006', '3000', '', '20')
insert into EMP ( empno, ename, job, mgr, hiredate, sal, comm, deptno)
values ('7934', 'MILLER', 'CLERK', '7782', '23-JAN-2007', '1300', '', '10')


CREATE TABLE DEPT ( deptno int,
dname varchar(255),
loc varchar(255))

insert into DEPT (deptno, dname, loc)
values ('10', 'ACCOUNTING', 'NEW YORK')
insert into DEPT (deptno, dname, loc)
values ('20', 'RESEARCH', 'DALLAS')
insert into DEPT (deptno, dname, loc)
values ('30', 'SALES', 'CHICAGO')
insert into DEPT (deptno, dname, loc)
values ('40', 'OPERATIONS', 'BOSTON')


SELECT *
FROM EMP

SELECT *
FROM DEPT

-- FINDING ROWS THAT SATISFY MULTIPLE CONDITIONS

SELECT * 
FROM EMP
WHERE ( deptno = 10 or comm is not null or sal <=2000)
and deptno = 20

-- RETRIEVING A SUBSET OF COLUMN FROM A TABLE

SELECT ename as employee_name, deptno as department_name, sal as salary
from EMP
order by ename asc

-- REFRENCING AN ALIASED COLUMN IN THE WHERE CLAUSE

select sal as salary, comm as commission
from EMP
where sal < 5000

select *
from ( select sal as salary, comm as commission
from EMP ) a
where salary < 5000

-- CONCATENATING COLUMN VALUES

select concat(ename, ' WORKS AS A ', job) as msg
from emp
where deptno = 10

-- the || is a shortcut for the CONCAT function in DB2,ORACLE, and PostgresSQL, while 
-- + is the shortcut for SQL server

-- USE CONDITIONAL LOGIC IN A SELECT STATEMENT

-- IF AN EMPLOYEE HAS PAYED 2000 OR LESS THEN UNDERPAID IS RETURNED
-- IF AN EMPLOYEE HAS PAID 4000 OR MORE THEN OVERPAID IS RETURNED
-- IF AN EMPLYEE HAS PAID IN BETWEEN THE TWO, THEN OK IS RETURNED

select ename, sal, case 
when sal <= 2000 then 'UNDERPAID'
when sal >= 4000 then 'OVERPAID'
else 'OK'
end as status
from EMP


-- RETURNING N RANDOM RECORDS FROM A TABLE

-- MODIFY THE STATEMENT SUCH THAT SUCCESSIVE EXECUTIONS WILL PRODUCE DIFFERENT SET OF ROWS

select ename, job
from EMP
order by rand()


-- FINDING NULL VALUES (0's)

select *
from emp
where comm like '0%'


-- TRANSFORMING NULLS INTO REAL VALUES
--RETURN NON-NULL VALUES IN PLASE OF NULLS

-- THE COALESCE FUNCTION TAKES ONE OR MORE VALUES AS ARGUMENTS. THE FUNCTION RETURNS
-- THE FIRST NON-NULL VALUE IN THE LIST.

select coalesce(comm,0)
from emp

select case
when comm is not null then comm
else 0
end
from emp


--SEARCHING FOR THE PATTERNS

-- RETURN ROWS THAT MATCH A PARTICULAR SUBSTRING OR PATTERN

select ename, job
from emp
where deptno in (10,20)
and (ename like '%I%' or job like '%ER')


-- SORTING QUERY RESULTS

-- RETURNING QUERY RESULTS IN SPECIFIED ORDER

select ename, job, sal
from emp
where deptno = 10
order by sal asc


--SORTING BY MULTIPLE FIELDS

select empno, deptno, sal, ename, job
from emp
order by deptno asc, sal desc


-- SORTING BY SUBSTRINGS
-- RETURN EMPLOYEE NAMES AND JOB AND SORT BY LAST TWO CHARACTERS IN THE JOB

select ename, job
from emp
order by substring(job, len(job)-1,2)

-- SORTING MIXED ALPHANUMERIC DATA
-- SORT EITHER BY NUMERIC OR CHARACTER PORTION OF THE DATA

create view V
as 
select concat(ename, ' ', deptno) as data
from emp

select data
from V
order by replace(data,
replace(
translate(data,'0123456789','##########'),'#',' '),' ')

-- DELAING WITH NULLS WHEN SORTING

select ename, sal, comm
from (select ename, sal, comm,
case when comm is not null then 0
else 1
end as is_null
from emp) a
order by is_null desc, comm


--SORTING ON DATA DEPENDENT KEY
-- IF JOB IS SALESMAN THEN SORT BY COMM, OTHERWISE SORT BY SAL

select ename, sal, job, comm
from emp
order by case
when job = 'SALESMAN' then comm
else sal
end


select ename, sal, job, comm, case
when job = 'SALESMAN' then comm
else sal
end as ORDERED
from emp
order by 5


--WORKING WITH MULTIPLE TABLES
-- STACKING ONE ROWSET ATOP ANOTHER

select ename as ename_and_dname, deptno
from emp
where deptno = 10
union all
select dname, deptno
from dept

select *
from ( 
select deptno
from emp
union all
select deptno
from  dept
)


-- COMBINING RELATED ROWS


select e.ename, d.loc
from emp e, dept d
where e.deptno = d.deptno
and e.deptno = 10


-- RETRIEVING VALUES FROM ONE TABLE THAT DO NOT EXIST IN ANOTHER


select deptno from dept
where deptno not in (select deptno from emp)


-- RETRIEVING ROWS FROM ONE TABLE THAT DO NOT CORRESPOND TO ROWS IN ANOHTER
-- FIND ROWS THAT ARE IN ONE TABLE THAT DO NOT HAVE MATCH IN ANOTHER TABLE, FOR TWO
-- TABLES THAT HAVE COMMON KEYS.

select *
from dept d
left outer join emp e
on (d.deptno = e.deptno)
where e.deptno is null
 

select e.empno, e.ename, d.dname, e.job, d.loc
from emp e
join dept d
on e.deptno = d.deptno

select e.name, d.loc, eb.received
from emp e
join dept d
on e.deptno = d.deptno
left join emp_bonus eb
on e.deptno = d.deptno
order by 2


CREATE TABLE EMP_BONUS
( empno int,
received varchar(255),
type int)

insert into EMP_BONUS (empno, received, type)
values ('7934', '17-MAR-2005', '1')
insert into EMP_BONUS (empno, received, type)
values ('7934', '15-FEB-2005', '2')
insert into EMP_BONUS (empno, received, type)
values ('7839', '15-FEB-2005', '3')
insert into EMP_BONUS (empno, received, type)
values ('7782', '15-FEB-2005', '1')

select *
from EMP_BONUS
select *
from EMP

select e.empno, e.ename, e.sal, e.deptno, e.sal*case when eb.type = 1 then .1
when eb.type = 2 then .2
else .3
end as bonus
from emp e , EMP_BONUS eb
where e.empno = eb.empno
and e.deptno = 10


select deptno, sum(sal) as total_salary, sum(bonus) as total_bonus
from ( select e.empno, e.ename, e.sal, e.deptno, e.sal*case when eb.type = 1 then .1
when eb.type = 2 then .2
else .3
end as bonus
from emp e, emp_bonus eb
where e.empno = eb.empno
and e.deptno = 10
) a
group by deptno

select sum(sal)
from emp
where deptno = 10

--// salary sum is different because of the duplicate rows in the SAL column created by join.


select e.ename, 
e.sal
from emp e, emp_bonus eb
where e.empno = eb.empno
and e.deptno = 10


-- PERFORM THE SUM OF ONLY THE DISTINCT SALARIES

select deptno,
sum(distinct sal) as total_salary,
sum(bonus) as total_bonus
from (
select e.empno, e.ename, e.sal, e.deptno,
e.sal*case when eb.type = 1 then .1
when eb.type = 2 then .2
else .3
end as bonus
from emp e, emp_bonus eb
where e.empno = eb.empno
and e.deptno = 10 ) a
group by deptno


-- PERFORMING OUTER JOINS WHEN USING AGGREGATES


select deptno, sum(sal) as total_salary,
sum(bonus) as total_bonus
from ( select e.empno, e.ename, e.sal, e.deptno, e.sal* case
when eb.type = 1 then .1
when eb.type = 2 then .2
else .3 
end as bonus
from emp e, emp_bonus eb
where e.empno = eb.empno
and e.deptno = 10) a
group by deptno



-- USING NULLS IN OPERATIONS AND COMPARISONS

SELECT ename, comm, coalesce(comm,0)
from emp
where coalesce(comm,0) < ( select comm
from emp
where ename = 'WARD')