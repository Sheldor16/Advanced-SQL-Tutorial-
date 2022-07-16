  --CHAPTER 4 (INSERTING, UPDATING, AND DELETING)


select *
from dept

insert into dept
values( '50','PROGRAMMING', 'BALTIMORE')


-- COPYING ROWS FROM ONE TABLE INTO ANOTHER

CREATE TABLE dept_east (deptno int,
dname varchar(255),
loc varchar(255))

insert into dept_east
select deptno, dname, loc
from dept
where loc in ('NEW YORK', 'BOSTON')

select *
from dept_east


-- COOPYING A TABLE DEFINITION
-- CREATE A COPY OF THE TABLE - DON'T COPY THE ROWS, ONLY THE COLUMN STRUCTURE


select *
into dept_2
from dept
where 1 = 0

select *
from dept_2

--BLOCKING INSERTS TO CERTAIN COLUMNS

create view new_emps as
select empno, ename, job
from emp

select *
from new_emps

--	MODIFYING RECORD IN TABLE
-- UPDATE SAL BY 10%

SELECT DEPTNO, ENAME, SAL FROM EMP
WHERE DEPTNO = 20
ORDER BY 1,3

UPDATE EMP
SET SAL = SAL*1.10
WHERE DEPTNO = 20

SELECT DEPTNO, ENAME, SAL AS ORIGINAL_SAL, SAL*10 AS AMT_TO_ADD, SAL*1.10 AS NEW_AMT
FROM EMP
WHERE DEPTNO = 20
ORDER BY 1,5

--MERGING RECORDS

SELECT * FROM EMP_COMMISSION EC
USING (SELECT *
FROM EMP) EMP
ON (EC.EMPNO=EMP.EMPNO)
WHEN MATCHED THEN
UPDATE SET EC.COMM = 1000
DELETE WHERE (SAL < 20000)
WHEN NOT MATHCED THEN 
INSERT (EC.EMPNO, EC.NAME,EC.DEPTNO,EC.COMM)
VALUES(EMP.EMPNO, EMP.ENAME, EMP.DEPTNO, EMP.COMM)


--DELETING DUPLICATE RECORDS

CREATE TABLE DUPES (ID INT, NAME VARCHAR(10))

INSERT INTO DUPES VALUES (1, 'NAPOLEAN')
INSERT INTO DUPES VALUES (2, 'DYNAMITE')
INSERT INTO DUPES VALUES (3, 'DYNAMITE')
INSERT INTO DUPES VALUES (4, 'SEA SHELLS')
INSERT INTO DUPES VALUES (5, 'SEA SHELLS')
INSERT INTO DUPES VALUES (6, 'SEA SHELLS')
INSERT INTO DUPES VALUES (7, 'SEA SHELLS')

SELECT  * FROM DUPES ORDER BY 1

DELETE FROM DUPES
WHERE ID NOT IN(SELECT MIN(ID) FROM DUPES GROUP BY NAME)

