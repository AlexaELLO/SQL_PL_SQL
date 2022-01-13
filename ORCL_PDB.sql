ALTER DATABASE OPEN;



CREATE TABLE ZIREAEL.DEPARTMENT (
    dept_id NUMBER NOT NULL,
    department VARCHAR2(44) NOT NULL,
    CONSTRAINT department_pk PRIMARY KEY(dept_id)
);
/




CREATE TABLE ZIREAEL.EMPLOYEES (
    employee_id NUMBER NOT NULL,
    post VARCHAR2(20) NOT NULL,
    name VARCHAR2(30) NOT NULL,
    phone_number NUMBER NOT NULL,
    salary NUMBER(7) NOT NULL,
    department VARCHAR2(44),
    dept_id NUMBER NOT NULL,
    CONSTRAINT employees_pk PRIMARY KEY(employee_id),
    CONSTRAINT employees_fk FOREIGN KEY(dept_id)
        REFERENCES zireael.department(dept_id)
);
/




INSERT ALL
    INTO ZIREAEL.DEPARTMENT(dept_id, department) VALUES(1124, 'Employees')
    INTO ZIREAEL.DEPARTMENT(dept_id, department) VALUES(2235, 'Library')
    INTO ZIREAEL.DEPARTMENT(dept_id, department) VALUES(3346, 'Stor')
    INTO ZIREAEL.DEPARTMENT(dept_id, department) VALUES(4457, 'Cashbox')
    INTO ZIREAEL.DEPARTMENT(dept_id, department) VALUES(5568, 'Providers')
    INTO ZIREAEL.DEPARTMENT(dept_id, department) VALUES(6679, 'Service of shop')
    INTO ZIREAEL.EMPLOYEES(employee_id, post, name, phone_number, salary, department, dept_id) VALUES(12, 'Seller', 'Alice Cole', 8123, 45000, 'Library', 1124)
    INTO ZIREAEL.EMPLOYEES(employee_id, post, name, phone_number, salary, department, dept_id) VALUES(13, 'Seller', 'Martin Canrit', 8456, 45000, 'Library', 1124)
    INTO ZIREAEL.EMPLOYEES(employee_id, post, name, phone_number, salary, department, dept_id) VALUES(31, 'Storekeeper', 'Alex Stone', 8789, 60000, 'Store', 3346)
    INTO ZIREAEL.EMPLOYEES(employee_id, post, name, phone_number, salary, department, dept_id) VALUES(32, 'Storekeeper', 'Mark Kerry', 8147, 70000, 'Store', 3346)
    INTO ZIREAEL.EMPLOYEES(employee_id, post, name, phone_number, salary, department, dept_id) VALUES(41, 'Cashier', 'Mary Lambert', 8258, 70000, 'Cashbox', 4457)
    INTO ZIREAEL.EMPLOYEES(employee_id, post, name, phone_number, salary, department, dept_id) VALUES(42, 'Cashier', 'Ariadne Codd', 8369, 70000, 'Cashbox', 4457)
SELECT * FROM dual;
/



SELECT * FROM ZIREAEL.DEPARTMENT;



SELECT * FROM ZIREAEL.EMPLOYEES;



SELECT e.dept_id, e.department, e.name 
FROM ZIREAEL.EMPLOYEES e
LEFT JOIN ZIREAEL.DEPARTMENT d
ON e.dept_id = d.dept_id;
/--left join


SELECT e.dept_id, e.department, e.name, e.post
FROM ZIREAEL.EMPLOYEES e
RIGHT JOIN zireael.department d
ON e.dept_id = d.dept_id;
/--right join


COMMIT;


SELECT e.dept_id, e.department, e.name, e.post
FROM zireael.employees e
FULL OUTER JOIN zireael.department d
ON e.dept_id = d.dept_id;
/--full join



SELECT *
FROM zireael.employees
CROSS JOIN zireael.department;
/--cross join



COMMIT;



SELECT employee_id 
FROM zireael.employees
WHERE NOT(salary <= 60000);
/--зарплата сотрудников, где она не меньше либо равна 60000


EXPLAIN PLAN FOR
    SELECT e.*, d.department
    FROM zireael.employees e
    JOIN zireael.department d ON e.dept_id = d.dept_id
    WHERE e.name LIKE 'A%' AND salary >= 60000;
    

EXPLAIN PLAN FOR
    SELECT employee_id FROM zireael.employees;

SELECT * FROM plan_table$;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'ALL'));


SELECT * FROM TABLE (DBMS_XPLAN.display_cursor(3));


--просмотр плана выполнения запроса
SELECT * FROM ZIREAEL.employees z
WHERE z.employee_id = 13;
--сам запрос


SELECT * FROM V$SQL z 
WHERE LOWER(z.sql_fulltext) LIKE '%z.employee_id = 13';
--ищу sql_id


SELECT * FROM V$SQL_PLAN WHERE sql_id = 'a00za0g2cbzcv';
--показывает есть ли по нему статистика


SELECT * FROM TABLE(dbms_xplan.display_cursor(sql_id => 'a00za0g2cbzcv', format => 'ALLSTATS ADVANCED LAST'));
--план выполнения с подробной статистикой



COMMIT;


SELECT employee_id 
FROM zireael.employees
WHERE MOD(employee_id, 2) = 0;
/--поиск четных id


SELECT employee_id
FROM zireael.employees
WHERE MOD(employee_id, 2) = 1;
/--поиск нечётных id


COMMIT;



SELECT MIN(LENGTH(name))
--name || MAX(LENGTH(name))
FROM zireael.employees;



SELECT LAST_VALUE(name) OVER(ORDER BY name RANGE UNBOUNDED PRECEDING) AS long_value
FROM zireael.employees;



SELECT * FROM zireael.employees;



INSERT INTO ZIREAEL.EMPLOYEES(employee_id, post, name, phone_number, salary, department, dept_id) VALUES(118, 'Seller', 'Martin Canrit', 8456, 45000, NULL,1124);



SELECT * FROM 
    (SELECT DISTINCT name, LENGTH(name) 
    FROM zireael.employees 
    ORDER BY LENGTH(name) ASC, name ASC)
    WHERE rownum = 1
UNION
SELECT * FROM
    (SELECT DISTINCT name, LENGTH(name)
    FROM zireael.employees
    ORDER BY LENGTH(name) DESC, name DESC)
    WHERE rownum = 1;
/--stakoverflow - thanks!



--RANGE-партиционирование (по диапазону)
CREATE TABLE range_tab(
    order_id NUMBER,
    sernum VARCHAR2(100 CHAR),
    order_date DATE
)
PARTITION BY RANGE (order_date)--диапазон
(
    PARTITION pmin VALUES LESS THAN (DATE'2008-01-01'),
    PARTITION p200802 VALUES LESS THAN (DATE'2008-02-01'),
    PARTITION p200803 VALUES LESS THAN (DATE'2008-03-01'),
    PARTITION pmax VALUES LESS THAN (MAXVALUE)
);
/



INSERT INTO range_tab(order_id, sernum, order_date) VALUES(1, 111, SYSDATE);
INSERT INTO range_tab(order_id, sernum, order_date) VALUES(2, 222, DATE'2008-02-01');
INSERT INTO range_tab(order_id, sernum, order_date) VALUES(3, 333, DATE'2001-12-20');
COMMIT;


SELECT * FROM range_tab PARTITION (p200802);


SELECT * FROM range_tab PARTITION (pmax);


SELECT * FROM range_tab;


SELECT * FROM range_tab
PARTITION (pmin);


COMMIT;


SELECT * FROM user_tab_partitions t 
WHERE t.table_name = 'range_tab';--ничего нет. почему?
--узнать как посмотреть таблицу в системном словаре (представлении)
--представление чувствительно к регистру. в user_tab_partition можно посмотреть 
--все партиции (которыми я владею)... верхний регистр или UPPER('имя_таблицы') 


SELECT * FROM ALL_TAB_PARTITIONS a
WHERE a.TABLE_NAME = 'range_tab';--ничего - регистр!



INSERT INTO range_tab(order_id, sernum, order_date) VALUES(4, 587, DATE'2021-11-04');
INSERT INTO range_tab(order_id, sernum, order_date) VALUES(5, 458, DATE'2021-11-09');
INSERT INTO range_tab(order_id, sernum, order_date) VALUES(6, 125, DATE'2021-12-30');
COMMIT;



SELECT * FROM range_tab;


CREATE TABLE auto_range_tab(
    order_id NUMBER,
    sernum VARCHAR2(100 CHAR),
    order_date DATE
)
PARTITION BY RANGE (order_date)
INTERVAL(INTERVAL '10' MINUTE)
(
    PARTITION pmin VALUES LESS THAN (DATE'2022-01-04')
);




INSERT INTO auto_range_tab(order_id,
                           sernum,
                           order_date)
SELECT LEVEL, 'sernum_'||LEVEL, SYSDATE + LEVEL FROM dual CONNECT BY LEVEL <= 10;



SELECT * FROM auto_range_tab ORDER BY order_date;


SELECT * FROM user_tab_partitions t 
WHERE t.table_name = 'auto_range_tab';



DROP TABLE auto_range_tab PURGE;




SELECT * FROM user_tab_partitions
WHERE TABLE_NAME = UPPER('range_tab');



--list
CREATE TABLE list_tab(
    order_id NUMBER,
    sernum VARCHAR2(100 CHAR),
    state_code VARCHAR2(10 CHAR)
)
PARTITION BY LIST (state_code) --диапазон
(
    PARTITION region_east VALUES ('MA', 'NY'),
    PARTITION region_west VALUES ('CA', 'AZ'),
    PARTITION region_south VALUES ('TX', 'KY'),
    PARTITION region_null VALUES (NULL),
    PARTITION region_unknown VALUES (DEFAULT)
);


COMMIT;


INSERT INTO list_tab(order_id, sernum, state_code) VALUES(1, '111', 'MA');
INSERT INTO list_tab(order_id, sernum, state_code) VALUES(2, '222', 'TX');
INSERT INTO list_tab(order_id, sernum, state_code) VALUES(3, '333', NULL);
INSERT INTO list_tab(order_id, sernum, state_code) VALUES(4, '444', 'SSS');
COMMIT;



SELECT * FROM list_tab;



SELECT * FROM user_tab_partitions
WHERE table_name = UPPER('list_tab');
--запрос партиции в подзапросе where?



CREATE TABLE hash_tab(
    order_id NUMBER,
    sernum VARCHAR2(100 CHAR),
    state_code VARCHAR2(10 CHAR)
)
PARTITION BY HASH (order_id)
(partition p1, partition p2, partition p3, partition p4);



INSERT INTO hash_tab(order_id, sernum, state_code) VALUES(1, '111', 'JH');
INSERT INTO hash_tab(order_id, sernum, state_code) VALUES(2, '258', 'KU');
INSERT INTO hash_tab(order_id, sernum, state_code) VALUES(3, '369', 'OI');
INSERT INTO hash_tab(order_id, sernum, state_code) VALUES(4, '452', 'KI');
COMMIT;



SELECT * FROM hash_tab;



--composit. не буду сейчас на этом останавливаться.
CREATE TABLE message_log(
    mtype VARCHAR2(2),
    dtime DATE DEFAULT SYSDATE,
    message VARCHAR2(200 CHAR)
)
PARTITION BY RANGE (dtime)
INTERVAL (INTERVAL '10' MINUTE)
SUBPARTITION BY LIST (mtype)
SUBPARTITION TEMPLATE
    (
    SUBPARTITION sp_error VALUES ('E'),
    SUBPARTITION sp_warning VALUES ('W'),
    SUBPARTITION sp_info VALUES ('I')
    )
(
    PARTITION pmin VALUES LESS THAN (DATE '1900-01-01')
);



ALTER TABLE message_log ADD CONSTRAINT message_log_mtype_ch CHECK (mtype IN ('E', 'I', 'W'));


/*INSERT INTO message_log VALUES ('I', SYSDATE + 1, 'Info 1');
INSERT INTO message_log VALUES ('I', SYSDATE - 1, 'Info 2');
INSERT INTO message_log VALUES ('W', SYSDATE + 10, 'Warning 1');
INSERT INTO message_log VALUES ('W', SYSDATE - 10, 'Warning 2');
INSERT INTO message_log VALUES ('E', SYSDATE + 10, 'Error 1');
INSERT INTO message_log VALUES ('E', SYSDATE - 10, 'Error 2');*/
--не вставляются. ORA-14300