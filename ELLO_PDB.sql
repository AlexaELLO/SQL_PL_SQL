CREATE TABLESPACE tbs_01
    DATAFILE 'tbs_01.dat'
    SIZE 50M
    ONLINE;
    
CREATE TEMPORARY TABLESPACE tbs_tem_01
    TEMPFILE 'tbs_tem_01.dbf'
    SIZE 10M
    AUTOEXTEND ON;

CREATE PUBLIC SYNONYM tab_department FOR scientific_center.department;

SELECT department, phone_of_department FROM tab_department;

CREATE SYNONYM tab_employees FOR scientific_center.employees;

SELECT employee_id, employee, profession FROM tab_employees;

GRANT SELECT ON tab_employees TO managers;


BEGIN
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT. put_line('Hi!');
END;
/

DECLARE

A NUMBER;
B NUMBER;

BEGIN

    A := 3;
    B := 5;
    
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.put_line(A+B);
    
END;
/

DECLARE
A INTEGER := 8;
B INTEGER := 7;

BEGIN
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.put_line(A+B);
END;
/

COMMIT;

DECLARE

i NUMBER := 0;

BEGIN
    LOOP
    i := i + 1;
    IF (i >= 100) THEN
        i := 0;
        EXIT;
    END IF;
    END LOOP;
    
    LOOP
    i := i + 1;
    EXIT WHEN (i >= 100);
    END LOOP;
END;
/

COMMIT;

ALTER TABLESPACE tbs_01
    ADD DATAFILE 'tbs_02.dat'
    SIZE 50M
    AUTOEXTEND ON;
    
COMMIT;

DROP USER SCIENTIFIC_CENTER CASCADE;

COMMIT;

CREATE USER ZIREAEL
    IDENTIFIED BY last123
    DEFAULT TABLESPACE tbs_01
    TEMPORARY TABLESPACE tbs_tem_01
    QUOTA 50M ON tbs_01;
    
COMMIT;

GRANT CREATE SESSION TO ZIREAEL;

CREATE TABLE ZIREAEL.DEPARTMENTS (
    dept_id NUMBER NOT NULL,
    department VARCHAR2(20) NOT NULL,
    CONSTRAINT dept_pk PRIMARY KEY(dept_id) 
);

COMMIT;

CREATE TABLE ZIREAEL.PURCHASE (
    purchase_id NUMBER NOT NULL,
    data_order TIMESTAMP(0),
    invoice NUMBER NOT NULL,
    author VARCHAR2(40) NOT NULL,
    name_book VARCHAR2(30) NOT NULL,
    price NUMBER(5,2) NOT NULL,
    number_good NUMBER NOT NULL,
    CONSTRAINT purch_fk
        FOREIGN KEY(purchase_id)
        REFERENCES zireael.departments(dept_id)
);

ALTER TABLE ZIREAEL.PURCHASE
    MODIFY name_book VARCHAR2(60);

CREATE SEQUENCE ZIREAEL.PUR_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 10
MINVALUE 1
ORDER
CACHE 10;

SELECT ZIREAEL.PUR_SEQ.NEXTVAL FROM dual;

/*name_of_schema.proff_seq.NEXTVAL/CURRVAL*/

INSERT ALL
    INTO ZIREAEL.PURCHASE (purchase_id, data_order, invoice, author, name_book, price, number_good)
    VALUES (zireael.pur_seq.CURRVAL, TO_TIMESTAMP('07-06-2021 9:15:12','MM-DD-YYYY HH24-MI-SS'), 1, 'John Hart', 'Down River', 332.50, 10)
    INTO ZIREAEL.PURCHASE (purchase_id, data_order, invoice, author, name_book, price, number_good)
    VALUES (zireael.pur_seq.CURRVAL, TO_TIMESTAMP('07-06-2021 9:15:12','MM-DD-YYYY HH24-MI-SS'), 1, 'Jo Nesbo', 'Kingdom', 342.90, 5)
    INTO ZIREAEL.PURCHASE (purchase_id, data_order, invoice, author, name_book, price, number_good)
    VALUES (zireael.pur_seq.CURRVAL, TO_TIMESTAMP('07-06-2021 9:15:12','MM-DD-YYYY HH24-MI-SS'), 1, 'Dan Brown', 'Origin', 400.99, 25)
    INTO ZIREAEL.PURCHASE (purchase_id, data_order, invoice, author, name_book, price, number_good)
    VALUES (zireael.pur_seq.CURRVAL, TO_TIMESTAMP('07-08-2021 10:35:54','MM-DD-YYYY HH24-MI-SS'), 2, 'Joel Dicher', 'The Enigma of Room 622', 350.50, 20)
    INTO ZIREAEL.PURCHASE (purchase_id, data_order, invoice, author, name_book, price, number_good)
    VALUES (zireael.pur_seq.CURRVAL, TO_TIMESTAMP('07-08-2021 10:35:54','MM-DD-YYYY HH24-MI-SS'), 2, 'Stuart Turton', 'The Seven Deaths of Evelyn Hardcastle', 480.99, 10)
    INTO ZIREAEL.PURCHASE (purchase_id, data_order, invoice, author, name_book, price, number_good)
    VALUES (zireael.pur_seq.CURRVAL, TO_TIMESTAMP('07-08-2021 10:35:54','MM-DD-YYYY HH24-MI-SS'), 2, 'Stephen King', 'Danse Macabre', 520.00, 30)
    INTO ZIREAEL.PURCHASE (purchase_id, data_order, invoice, author, name_book, price, number_good)
    VALUES (zireael.pur_seq.CURRVAL, TO_TIMESTAMP('07-08-2021 10:35:54','MM-DD-YYYY HH24-MI-SS'), 2, 'Umberto Eco', 'The Name of the Rose', 689.99, 40)
    INTO ZIREAEL.PURCHASE (purchase_id, data_order, invoice, author, name_book, price, number_good)
    VALUES (zireael.pur_seq.CURRVAL, TO_TIMESTAMP('07-08-2021 10:35:54','MM-DD-YYYY HH24-MI-SS'), 2, 'Arthur Conan Doyle', 'Sherlock Holmes', 752.50, 20)
    INTO ZIREAEL.PURCHASE (purchase_id, data_order, invoice, author, name_book, price, number_good)
    VALUES (zireael.pur_seq.CURRVAL, TO_TIMESTAMP('07-08-2021 14:25:01','MM-DD-YYYY HH24-MI-SS'), 3, 'Joel Dicher', 'The Truth About the Harry Quebert Affair', 365.55, 10)
    INTO ZIREAEL.PURCHASE (purchase_id, data_order, invoice, author, name_book, price, number_good)
    VALUES (zireael.pur_seq.CURRVAL, TO_TIMESTAMP('07-08-2021 14:25:01','MM-DD-YYYY HH24-MI-SS'), 3, 'Emily Bront?', 'Wuthering Heights', 700.00, 30)
SELECT* FROM dual;

CREATE TABLE ZIREAEL.LIBRARY (
    library_id NUMBER NOT NULL,
    number_store NUMBER NOT NULL,
    genre VARCHAR2(20) NOT NULL,
    author VARCHAR2(40) NOT NULL,
    name_book VARCHAR2(60) NOT NULL,
    number_book NUMBER(4),
    CONSTRAINT lib_fk
        FOREIGN KEY(library_id)
        REFERENCES zireael.departments(dept_id)
);

COMMIT;

SAVEPOINT tables_2;

SELECT zireael.pur_seq.NEXTVAL FROM dual;
SELECT zireael.pur_seq.NEXTVAL FROM dual;


INSERT ALL
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 8, 'spine-chiller', 'Dan Brown', 'Angels & Demons', 20)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 8, 'spine-chiller', 'Dan Brown', 'The Da Vinci Code', 16)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 8, 'spine-chiller', 'Dan Brown', 'The Lost Symbol', 25)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 8, 'spine-chiller', 'Dan Brown', 'Digital Fortress', 45)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 8, 'spine-chiller', 'Dan Brown', 'Deception Point', 15)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 8, 'spine-chiller', 'Dan Brown', 'Inferno', 26)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 8, 'spine-chiller', 'Dan Brown', 'Origin', 10)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 26, 'detective', 'Jo Nesbo', 'The Bat', 14)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 26, 'detective', 'Jo Nesbo', 'Nemesis', 4)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 26, 'detective', 'John Hart', 'Down River', 2)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 26, 'detective', 'John Hart', 'Iron House', 7)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 26, 'detective', 'John Hart', 'The Unwilling', 6)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 10, 'romance', 'Jane Austen', 'Pride and Prejudice', 12)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 10, 'romance', 'Jane Austen', 'Sense and Sensibility', 30)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 10, 'romance', 'Jane Austen', 'Emma', 18)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 10, 'romance', 'Jane Austen', 'Persuasion', 32)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 10, 'romance', 'Jane Austen', 'Northanger Abbey', 8)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 10, 'romance', 'Jane Austen', 'Lady Susan', 18)
    INTO ZIREAEL.LIBRARY (library_id, number_store, genre, author, name_book, number_book)
    VALUES (3, 26, 'detective', 'Stuart Turton', 'The Devil and the Dark Water', 9)
SELECT* FROM dual;

DELETE FROM ZIREAEL.LIBRARY;



SELECT author, number_book, department
    FROM ZIREAEL.DEPARTMENTS, ZIREAEL.LIBRARY
    WHERE dept_id = library_id
    /
    
SELECT data_order, invoice, name_book, price, department
    FROM ZIREAEL.DEPARTMENTS, ZIREAEL.PURCHASE
    WHERE dept_id = purchase_id AND invoice = 3
    /
    
SELECT data_order, invoice, name_book, price, department
    FROM ZIREAEL.DEPARTMENTS, ZIREAEL.PURCHASE
    WHERE dept_id = purchase_id AND price > 400.00
    /
    
SELECT AVG(price)
    FROM ZIREAEL.PURCHASE
    /
    
SELECT SUM(price)
    FROM ZIREAEL.PURCHASE
    /
    
SELECT COUNT(*)
    FROM ZIREAEL.PURCHASE
    /
    
SELECT AVG(100 * price) PROCENT
    FROM ZIREAEL.PURCHASE
    /
    
SELECT SUM(price)
    FROM ZIREAEL.PURCHASE
    WHERE author = 'Dan Brown'
    /
    
SELECT LAST_DAY(SYSDATE) FROM DUAL;

SELECT COUNT(DISTINCT AUTHOR)
    FROM ZIREAEL.LIBRARY
    /
    
SELECT invoice, name_book
    FROM ZIREAEL.PURCHASE
    WHERE price > 400.00
    GROUP BY INVOICE, NAME_BOOK
    /
    
SELECT MEDIAN(price)
    FROM ZIREAEL.PURCHASE
    /
    
SELECT LISTAGG(author, '; ')
    FROM ZIREAEL.PURCHASE
    /
SELECT genre, MAX(number_book)
    FROM ZIREAEL.LIBRARY
    GROUP BY genre
    /
    
SELECT dept_id, department, library_id, author
    FROM ZIREAEL.DEPARTMENTS, ZIREAEL.LIBRARY
    CONNECT BY dept_id = library_id
    START WITH library_id IS null;
    
COMMIT;

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7839, 'KING', 'PRESIDENT', null, to_date('17-11-1981', 'dd-mm-yyyy'), 5000, null, 10);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7566, 'JONES', 'MANAGER', 7839, to_date('02-04-1981', 'dd-mm-yyyy'), 2975, null, 20);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7698, 'BLAKE', 'MANAGER', 7839, to_date('01-05-1981', 'dd-mm-yyyy'), 2850, null, 30);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7782, 'CLARK', 'MANAGER', 7839, to_date('09-06-1981', 'dd-mm-yyyy'), 2450, null, 10);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7788, 'SCOTT', 'ANALYST', 7566, to_date('19-04-1987', 'dd-mm-yyyy'), 3000, null, 20);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7844, 'TURNER', 'SALESMAN', 7698, to_date('08-09-1981', 'dd-mm-yyyy'), 1500, 0, 30);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7876, 'ADAMS', 'CLERK', 7788, to_date('23-05-1987', 'dd-mm-yyyy'), 1100, null, 20);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7900, 'JAMES', 'CLERK', 7698, to_date('03-12-1981', 'dd-mm-yyyy'), 950, null, 30);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7902, 'FORD', 'ANALYST', 7566, to_date('03-12-1981', 'dd-mm-yyyy'), 3000, null, 20);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7934, 'MILLER', 'CLERK', 7782, to_date('23-01-1982', 'dd-mm-yyyy'), 1300, null, 10);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7369, 'SMITH', 'CLERK', 7902, to_date('17-12-1980', 'dd-mm-yyyy'), 800, null, 20);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7499, 'ALLEN', 'SALESMAN', 7698, to_date('20-02-1981', 'dd-mm-yyyy'), 1600, 300, 30);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7521, 'WARD', 'SALESMAN', 7698, to_date('22-02-1981', 'dd-mm-yyyy'), 1250, 500, 30);

insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
values (7654, 'MARTIN', 'SALESMAN', 7698, to_date('28-09-1981', 'dd-mm-yyyy'), 1250, 1400, 30);

SELECT ename, hiredate, sal, 
    SUM(sal) OVER(ORDER BY hiredate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) row_sal,
    SUM(sal) OVER(ORDER BY hiredate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) range_sal
    FROM EMP
    /
    
SELECT ename, deptno, job, sal,
    MIN(sal) OVER() min_sal,
    MAX(sal) OVER() max_sal,
    SUM(sal) OVER() sum_sal
FROM EMP;

SELECT ename, job, sal,
    SUM(sal) OVER() sum_sal
FROM EMP;

SELECT ename, deptno, job, hiredate, sal,
    SUM(sal) OVER(PARTITION BY deptno, job ORDER BY hiredate) sum_sal
    FROM EMP
    /
    
SELECT ename, hiredate, sal,
    SUM(sal) OVER(ORDER BY hiredate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) rows_sal,
    SUM(sal) OVER(ORDER BY hiredate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) range_sal
FROM EMP;

SELECT ename, hiredate, sal,
    FIRST_VALUE(sal)
    OVER(ORDER BY hiredate
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) first_value,
    LAST_VALUE(sal)
    OVER(ORDER BY hiredate
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) last_value,
    FIRST_VALUE(sal)
    OVER(ORDER BY hiredate
    RANGE BETWEEN 2 PRECEDING AND CURRENT ROW) first_value,
    LAST_VALUE(sal)
    OVER(ORDER BY hiredate
    RANGE BETWEEN 2 PRECEDING AND CURRENT ROW) last_value
FROM EMP;

SELECT ename, hiredate, sal,
    AVG(sal) OVER(ORDER BY hiredate RANGE BETWEEN INTERVAL '6' MONTH PRECEDING AND CURRENT ROW) avg_sal
FROM EMP;

SELECT * FROM
(
    SELECT ENAME, JOB, DEPTNO
    FROM EMP
)
PIVOT
(
    COUNT(DEPTNO)
    FOR DEPTNO IN (10, 20, 30)
)
ORDER BY ENAME;

SELECT job, deptno, SUM(sal) AS ssal
FROM EMP
GROUP BY job, deptno;

WITH ssum AS(
SELECT job, deptno, SUM(sal) AS ssal
FROM EMP
GROUP BY job, deptno
)
SELECT job,
    SUM(CASE WHEN deptno = 10 THEN ssal ELSE 0 END) AS d_10,
    SUM(CASE WHEN deptno = 20 THEN ssal ELSE 0 END) AS d_20,
    SUM(CASE WHEN deptno = 30 THEN ssal ELSE 0 END) AS d_30
FROM ssum GROUP BY job;

SELECT * FROM
(SELECT job, deptno, SUM(sal) AS ssal FROM EMP GROUP BY job, deptno)
PIVOT (SUM(ssal) FOR deptno IN (10,20,30));

COMMIT;

EXPLAIN PLAN FOR
    SELECT ename, job, sal, deptno
    FROM EMP
    WHERE sal < 3000
    ORDER BY sal DESC;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'ALL'));

SELECT /*TEST QUERY*/ *
FROM EMP
WHERE (ename = 'ADAMS' OR job = 'MANAGER');

SELECT * FROM v$sql vs WHERE vs.SQL_FULLTEXT like 'SELECT /*TEST QUERY*/%';

SELECT TABLE_NAME, TABLESPACE_NAME, NUM_ROWS 
FROM USER_TABLES
WHERE TABLE_NAME = 'EMP';

SELECT * FROM v$sql;/*содержит статистику по курсорам запросов.*/

SELECT * FROM v$sql_shared_cursor;

SELECT * FROM v$sql_plan;

SELECT * FROM v$sql_plan_statistics_all;

SELECT /*+ALL_ROWS*/ *
FROM EMP e;
/

SELECT /*+ INDEX (EMP empno) */ *
FROM EMP e;
/

SELECT /*+ALL_ROWS*/ *
FROM EMP e;

SELECT * FROM v$sql;

SELECT * FROM v$sql_plan;

SET SERVEROUTPUT ON /*заставляет сервер выводит сообщение на экран*/
BEGIN
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.put_line('Hello World!');
    END;
    /
    
/*это мой первый курсор))))*/

DECLARE

A INTEGER;
B INTEGER;

BEGIN

    A := 3;
    B := 5;
    
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.put_line(A+B);
    
END;
/

DECLARE

A INTEGER;
B INTEGER;

BEGIN

    A := 3;
    B := 5;
    
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.put_line(TO_CHAR(A+B));
    
END;
/

DECLARE

A INTEGER := 3;
B INTEGER;
K VARCHAR2(2) := '12';

BEGIN
    B := 5;
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.put_line(TO_CHAR(TO_NUMBER(K)*A+B));
END;
/
    
SELECT TYPE_NAME FROM ALL_TYPES WHERE PREDEFINED = 'YES';

COMMIT;

DECLARE

A INTEGER := 7;
B INTEGER := 4;
OPER VARCHAR2(2) := '+';

BEGIN
    DBMS_OUTPUT.enable;
    IF (OPER = '+') THEN
    DBMS_OUTPUT.put_line('Operation is '||OPER||' '||'sum = '||TO_CHAR(A+B));
    ELSIF (OPER = '-') THEN
    DBMS_OUTPUT.put_line('Operation is '||OPER||' '||'res = '||TO_CHAR(A-B));
    ELSIF (OPER = '*') THEN
    DBMS_OUTPUT.put_line('Operation is '||OPER||' '||'mul = '||TO_CHAR(A*B));
    ELSIF (OPER = '/') THEN
    DBMS_OUTPUT.put_line('Operation is '||OPER||' '||'div = '||TO_CHAR(A/B));
    END IF;
    
END;
/
DECLARE

    i NUMBER := 0;
    
BEGIN
    LOOP
    i := i + 1;
    IF (i >= 100) THEN
        i := 0;
        EXIT;
    END IF;
    END LOOP;
    
    LOOP
        i := i + 1;
        EXIT WHEN (i >= 100);
        END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE greeting
AS
BEGIN
    DBMS_OUTPUT.put_line('Hello World!');
END;

DECLARE

k NUMBER := 0;

BEGIN
    
    WHILE (k < 10) LOOP
        k := k + 1;
    END LOOP;
    
END;

BEGIN

    DBMS_OUTPUT.enable;
    FOR i IN REVERSE 1..10 LOOP
    DBMS_OUTPUT.put_line(TO_CHAR(i)||'-');
    END LOOP;
    DBMS_OUTPUT.put_line('Blastoff!');
    
END;

BEGIN
<<outer>>
    FOR outer_index IN 1 .. 5
    LOOP
        DBMS_OUTPUT.PUT_LINE ('Внешний счетчик = ' || TO_CHAR (outer_index));
        <<inner>>
        FOR inner_index IN 1 .. 5
        LOOP
            DBMS_OUTPUT.PUT_LINE (' Внутренний счетчик = ' || TO_CHAR (inner_index));
            CONTINUE outer;
        END LOOP inner;
    END LOOP outer;
END;

COMMIT;

SET SERVEROUTPUT ON;

DECLARE

    CURSOR get_emp IS
        SELECT * FROM EMP;
        
    v_em get_emp%ROWTYPE;
    
BEGIN

    OPEN get_emp;
    
    LOOP
    
        EXIT WHEN get_emp%NOTFOUND;
        
        DBMS_OUTPUT.enable;
        FETCH get_emp INTO v_em;
        DBMS_OUTPUT.put_line('Get Data: '||TO_CHAR(v_em.EMPNO)||' '||v_em.JOB||' '||TO_CHAR(v_em.SAL)||' '||v_em.ENAME);
        
    END LOOP;
    
    CLOSE get_emp;
    
END;

DECLARE

TYPE is_EmpRec IS RECORD
    (
    e_Fld1 VARCHAR2(10),
    e_Fld2 VARCHAR2(30) := 'Buber',
    e_Fld DATE,
    e_Fld3 NUMBER := 1000,
    e_Fld4 VARCHAR2(100) NOT NULL := 'System'
    );
    
MY_EMP is_EmpRec;

BEGIN

    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.put_line(MY_EMP.e_Fld2||' '||MY_EMP.e_Fld4);
    
END;


CREATE OR REPLACE PROCEDURE TESTPRG
AS

BEGIN
    NULL;
END TESTPRG;

EXEC TESTPRG;

CREATE OR REPLACE PROCEDURE TESTPRGW
AS
BEGIN
    DBMS_OUTPUT.put_line('Hello World!');
END;
/

EXEC TESTPRGW;

CREATE OR REPLACE PROCEDURE TESTPRGW
AS
BEGIN
    DBMS_OUTPUT.enable;
    DBMS_OUTPUT.put_line('Hello World!');
END;
/

EXEC TESTPRGW;

DECLARE

BEGIN
    TESTPRGW
END;
/


DECLARE
    bonus NUMBER(8,2);
    
BEGIN
    SELECT sal * 0.10 --INTO bonus
    FROM EMP
    WHERE EMPNO = 7839;
    
    DBMS_OUTPUT.put_line(bonus);
END;


CREATE OR REPLACE PROCEDURE SQUARE_N(
n IN OUT NUMBER)
IS
BEGIN
    n := n**2;
END SQUARE_N;

DECLARE --не работает, почему, хз((
    a NUMBER;
BEGIN
    a := 6
    SQUARE_N(n => a);
    DBMS_OUTPUT.put_line(a);
END;
/

CREATE OR REPLACE FUNCTION count_rec_emp
RETURN NUMBER IS
    total_count NUMBER := 0;
    
BEGIN
    SELECT COUNT(*) INTO total_count FROM EMP;
    RETURN total_count;
END count_rec_emp;
/

BEGIN
    DBMS_OUTPUT.put_line(count_rec_emp());
END;
/ 

CREATE OR REPLACE FUNCTION sum_emp
RETURN NUMBER IS
    sum_sal NUMBER := 0;
    
BEGIN
    SELECT SUM(SAL) INTO sum_sal FROM EMP WHERE DEPTNO = 10;
    RETURN sum_sal;
END sum_emp;
/

BEGIN
    DBMS_OUTPUT.put_line(sum_emp());
END;
/

CREATE OR REPLACE FUNCTION betwnstr (
    string_in IN VARCHAR2,
    start_in PLS_INTEGER,
    end_in IN PLS_INTEGER) RETURN VARCHAR2
IS
BEGIN
    RETURN(substr(string_in, start_in, end_in - start_in + 1));
END betwnstr;
/

SELECT betwnstr(am.ename,3,5) FROM EMP am;
/ 

WITH --not creating, because only for Oracle 12c! 
    FUNCTION btwstr (
    string_in IN VARCHAR2,
    start_in IN PLS_INTEGER,
    end_in IN PLS_INTEGER) RETURN VARCHAR2
IS
BEGIN
    RETURN(substr(string_in, start_in, end_in - start_in + 1));
END btwstr;
/

CREATE VIEW clerk AS
    SELECT empno, ename, job, deptno
    FROM EMP
    WHERE empno = 7902;
/    

SELECT * FROM clerk;
/ 

COMMIT;
/

CREATE OR REPLACE VIEW zireael.sel_st AS
SELECT sel.invoice, sel.name_book, sel.number_good, st.number_store, st.number_book
FROM PURCHASE SEL, LIBRARY ST;
/

SELECT * FROM zireael.sel_st;

UPDATE ZIREAEL.SEL_ST SET name_book = 'Down River, best-seller' WHERE number_store = 8; 
/*я так понимаю не могу поменять, потому-что есть ограничение NOT NULL. нафига я там указала NOT NULL, я хз(((*/

SET SERVEROUTPUT ON;
/

DECLARE
    TYPE nested_typ IS TABLE OF NUMBER;
    nt1 nested_typ := nested_typ(1,2,3);
    nt2 nested_typ := nested_typ(3,2,1);
    nt3 nested_typ := nested_typ(2,3,1,3);
    nt4 nested_typ := nested_typ(1,2,4);
    answer nested_typ;
    PROCEDURE print_nt (x_answer nested_typ)
        AS
        rec VARCHAR2(4000);
    BEGIN
        IF x_answer.count = 0 THEN
            rec := 'Empty';
        ELSE
            FOR i IN x_answer.first..x_answer.last LOOP
            rec := rec || ' ' || TO_CHAR(x_answer(i));
            END LOOP;
        END IF;
    DBMS_OUTPUT.PUT_LINE('answer: '||rec);
    END;
BEGIN
    answer := nt1 MULTISET UNION nt4;
    print_nt(answer);
    answer := nt1 MULTISET UNION nt3;
    print_nt(answer);
    answer := nt1 MULTISET UNION DISTINCT nt3;
    print_nt(answer);
    answer := nt2 MULTISET INTERSECT nt3;
    print_nt(answer);
    answer := nt2 MULTISET INTERSECT DISTINCT nt3;
    print_nt(answer);
    answer := SET(nt3);
    print_nt(answer);
    answer := nt3 MULTISET EXCEPT nt2;
    print_nt(answer);
    answer := nt3 MULTISET EXCEPT DISTINCT nt2;
    print_nt(answer);
END;
/


DECLARE 
    TYPE nt_type IS TABLE OF NUMBER;
    nt nt_type := nt_type(11, 22, 33, 44, 55, 66);
    PROCEDURE print_nt (x_answer nt_type)
        AS
        res VARCHAR2(4000);
        i NUMBER;
    BEGIN
        IF x_answer.COUNT = 0 THEN
            res := 'Empty';
        ELSE
            i := x_answer.FIRST;
            WHILE i IS NOT NULL LOOP
            res := res || ' ' || TO_CHAR(x_answer(i));
            i := x_answer.NEXT(i);
            END LOOP;
        END IF;
        DBMS_OUTPUT.PUT_LINE('answer: '||res);
    END;
BEGIN
    print_nt(nt);
    nt.DELETE(2);
    print_nt(nt);
    nt(2) := 2222;
    print_nt(nt);
    nt.DELETE(2, 4);
    print_nt(nt);
    nt(3) := 3333;
    print_nt(nt);
    nt.DELETE;
    print_nt(nt);
END;
/

SELECT * FROM ZIREAEL.LIBRARY;

CREATE VIEW author_lb AS
    SELECT author, genre, number_book
    FROM ZIREAEL.LIBRARY;
/

SELECT * FROM author_lb;
/

SELECT author, genre  
FROM author_lb
WHERE genre = 'Детектив';
/

SELECT genre, name_book
FROM ZIREAEL.LIBRARY
WHERE number_store = 26;
/

SELECT author, number_book  
FROM ZIREAEL.LIBRARY
WHERE author = 'Джейн Остин';
/