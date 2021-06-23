CREATE TABLESPACE tbs_01
    DATAFILE 'tbs_01.dat'
    SIZE 50M
    ONLINE;
    
CREATE TEMPORARY TABLESPACE tbs_tem_01
    TEMPFILE 'tbs_tem_01.dbf'
    SIZE 10M
    AUTOEXTEND ON;

CREATE USER SCIENTIFIC_CENTER
    IDENTIFIED BY lolo4
    DEFAULT TABLESPACE tbs_01
    TEMPORARY TABLESPACE tbs_tem_01
    QUOTA 40M ON tbs_01;  

CREATE TABLE SCIENTIFIC_CENTER.DEPARTMENT (
    dept_id NUMBER NOT NULL,
    department VARCHAR2(60) NOT NULL,
    number_staff NUMBER CHECK(number_staff < 20),
    phone_of_department NUMBER(6) NOT NULL,
    CONSTRAINT dept_pk PRIMARY KEY (dept_id)
    ); 
    
INSERT ALL
    INTO SCIENTIFIC_CENTER.DEPARTMENT (dept_id, department, number_staff, phone_of_department)
    VALUES ('10', 'Исследование и разработка', '4', '22335')
    INTO SCIENTIFIC_CENTER.DEPARTMENT (dept_id, department, number_staff, phone_of_department)
    VALUES ('20', 'Теоретическая физика', '5', '21334')
    INTO SCIENTIFIC_CENTER.DEPARTMENT (dept_id, department, number_staff, phone_of_department)
    VALUES ('30', 'Эксперементальная физика', '3', '23632')
SELECT * FROM dual;

CREATE TABLE SCIENTIFIC_CENTER.PROFESSIONS (
    profession_id NUMBER NOT NULL,
    profession VARCHAR2(40) NOT NULL,
    number_staff NUMBER CHECK(number_staff < 20) NOT NULL,
    department VARCHAR2(60) NOT NULL,
    depar_id NUMBER NOT NULL,
    CONSTRAINT proff_pk PRIMARY KEY (profession_id),
    CONSTRAINT depar_fk
        FOREIGN KEY (depar_id)
        REFERENCES scientific_center.department(dept_id)
    );
    
INSERT ALL
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('11', 'главный инженер', '2', 'Исследование и разработка', '10')
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('12', 'инженер', '2', 'Исследование и разработка', '10')
SELECT * FROM dual;

INSERT ALL
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('21', 'физик-теоретик', '2', 'Теоретическая физика', '20')
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('22', 'физик', '3', 'Теоретическая физика', '20')
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('31', 'материаловед', '1', 'Эксперементальная физика', '30')
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('32', 'физик-инженер', '2', 'Эксперементальная физика', '30')
SELECT * FROM dual;

CREATE TABLE SCIENTIFIC_CENTER.EMPLOYEES (
    employee_id NUMBER NOT NULL,
    employee VARCHAR2(40) NOT NULL,
    salary NUMBER CHECK(salary < 200000) NOT NULL,
    profession VARCHAR2(40) NOT NULL,
    proff_id NUMBER NOT NULL,
    CONSTRAINT emp_pk PRIMARY KEY (employee_id),
    CONSTRAINT proff_fk
        FOREIGN KEY (proff_id)
        REFERENCES scientific_center.professions(profession_id)
    );

INSERT ALL
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('110', 'Макейн Д.', '85000', 'главный инженер', '11')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('120', 'Лорри К.', '85000', 'главный инженер', '11')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('130', 'Элорн К.', '82000', 'инженер', '12')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('140', 'Дорент Ж.', '82000', 'инженер', '12')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('210', 'Коллин Р.', '85000', 'физик-теоретик', '21')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('220', 'Паррель К.', '85000', 'физик-теоретик', '21')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('230', 'Колуэн Л.', '83000', 'физик', '22')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('240', 'Келог А.', '83000', 'физик', '22')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('250', 'Коферман Л.', '83000', 'физик', '22')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('310', 'Петриков С.', '82000', 'материаловед', '31')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('320', 'Тонри Р.', '85000', 'физик-инженер', '32')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('330', 'Браун С.', '85000', 'физик-инженер', '32')
SELECT * FROM dual;   

CREATE SEQUENCE SCIENTIFIC_CENTER.DEPARTMENT_SEQ
START WITH 40
INCREMENT BY 10
MAXVALUE 300
MINVALUE 40
ORDER
CACHE 5;


INSERT INTO SCIENTIFIC_CENTER.DEPARTMENT (dept_id, department, number_staff, phone_of_department)
VALUES (scientific_center.department_seq.NEXTVAL, 'Органическая химия', '1', '24225');

SELECT SCIENTIFIC_CENTER.DEPARTMENT_SEQ.CURRVAL FROM dual;

SELECT SCIENTIFIC_CENTER.DEPARTMENT_SEQ.NEXTVAL FROM dual;

SELECT SCIENTIFIC_CENTER.DEPARTMENT_SEQ.CURRVAL FROM dual;

CREATE SEQUENCE SCIENTIFIC_CENTER.PROFF_SEQ
START WITH 41
INCREMENT BY 1
MAXVALUE 300
MINVALUE 41
ORDER
CACHE 20;

ALTER SEQUENCE SCIENTIFIC_CENTER.DEPARTMENT_SEQ
INCREMENT BY -10;

SELECT SCIENTIFIC_CENTER.DEPARTMENT_SEQ.NEXTVAL FROM dual;

ALTER SEQUENCE SCIENTIFIC_CENTER.DEPARTMENT_SEQ
INCREMENT BY 10;

SELECT SCIENTIFIC_CENTER.DEPARTMENT_SEQ.CURRVAL FROM dual;

INSERT INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
VALUES (scientific_center.proff_seq.NEXTVAL, 'химик', '1', 'Органическая химия', scientific_center.department_seq.CURRVAL);

INSERT INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
VALUES ('410', 'Аббадир М.', '80000', 'химик', scientific_center.proff_seq.CURRVAL);

CREATE USER MANAGERS
    IDENTIFIED BY lolo5
    DEFAULT TABLESPACE tbs_01
    TEMPORARY TABLESPACE tbs_tem_01
    QUOTA 20M ON tbs_01;
    
CREATE TABLE MANAGERS.MANAGER_DEPARTMENTS (
    manager_id NUMBER NOT NULL,
    name_manader VARCHAR2(40) NOT NULL,
    phone_manager NUMBER(6) NOT NULL,
    department VARCHAR2(60)not null,
    dept_id NUMBER NOT NULL
    );

INSERT ALL
    INTO MANAGERS.MANAGER_DEPARTMENTS (manager_id, name_manader, phone_manager, department, dept_id)
    VALUES ('1', 'Колин Ф.', '14721', 'Исследование и разработка', '10')
    INTO MANAGERS.MANAGER_DEPARTMENTS (manager_id, name_manader, phone_manager, department, dept_id)
    VALUES ('2', 'Андерсон М.', '25812', 'Теоретическая физика', '20')
    INTO MANAGERS.MANAGER_DEPARTMENTS (manager_id, name_manader, phone_manager, department, dept_id)
    VALUES ('3', 'Найтли Э.', '35796', 'Эксперементальная физика', '30')
    INTO MANAGERS.MANAGER_DEPARTMENTS (manager_id, name_manader, phone_manager, department, dept_id)
    VALUES ('4', 'Колли Л.', '45789', 'Органическая химия', '40')
SELECT * FROM dual;

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