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
    VALUES ('10', '������������ � ����������', '4', '22335')
    INTO SCIENTIFIC_CENTER.DEPARTMENT (dept_id, department, number_staff, phone_of_department)
    VALUES ('20', '������������� ������', '5', '21334')
    INTO SCIENTIFIC_CENTER.DEPARTMENT (dept_id, department, number_staff, phone_of_department)
    VALUES ('30', '����������������� ������', '3', '23632')
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
    VALUES ('11', '������� �������', '2', '������������ � ����������', '10')
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('12', '�������', '2', '������������ � ����������', '10')
SELECT * FROM dual;

INSERT ALL
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('21', '�����-��������', '2', '������������� ������', '20')
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('22', '�����', '3', '������������� ������', '20')
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('31', '������������', '1', '����������������� ������', '30')
    INTO SCIENTIFIC_CENTER.PROFESSIONS (profession_id, profession, number_staff, department, depar_id)
    VALUES ('32', '�����-�������', '2', '����������������� ������', '30')
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
    VALUES ('110', '������ �.', '85000', '������� �������', '11')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('120', '����� �.', '85000', '������� �������', '11')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('130', '����� �.', '82000', '�������', '12')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('140', '������ �.', '82000', '�������', '12')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('210', '������ �.', '85000', '�����-��������', '21')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('220', '������� �.', '85000', '�����-��������', '21')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('230', '������ �.', '83000', '�����', '22')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('240', '����� �.', '83000', '�����', '22')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('250', '�������� �.', '83000', '�����', '22')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('310', '�������� �.', '82000', '������������', '31')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('320', '����� �.', '85000', '�����-�������', '32')
    INTO SCIENTIFIC_CENTER.EMPLOYEES (employee_id, employee, salary, profession, proff_id)
    VALUES ('330', '����� �.', '85000', '�����-�������', '32')
SELECT * FROM dual;   

CREATE SEQUENCE SCIENTIFIC_CENTER.DEPARTMENT_SEQ
START WITH 40
INCREMENT BY 10
MAXVALUE 300
MINVALUE 40
ORDER
CACHE 5;


INSERT INTO SCIENTIFIC_CENTER.DEPARTMENT (dept_id, department, number_staff, phone_of_department)
VALUES (scientific_center.department_seq.NEXTVAL, '������������ �����', '1', '24225');

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
VALUES (scientific_center.proff_seq.NEXTVAL, '�����', '1', '������������ �����', scientific_center.department_seq.CURRVAL);


