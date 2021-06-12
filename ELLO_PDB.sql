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

CREATE TABLE SCIENTIFIC_CENTER.LABORATORY (
    dept VARCHAR2(60) NOT NULL,
    number_staff NUMBER(10),
    phone_dept NUMBER(10) NOT NULL,
    CONSTRAINT dept_pk PRIMARY KEY (dept)
    );
    
CREATE TABLE SCIENTIFIC_CENTER.STAFF (
    depar VARCHAR2(60) NOT NULL,
    post VARCHAR2(40) NOT NULL,
    lf_name VARCHAR2(40) NOT NULL,
    salary NUMBER CHECK (salary < 100000),
    CONSTRAINT fk_depar
        FOREIGN KEY (depar)
        REFERENCES scientific_center.laboratory(dept)
    );
    
INSERT ALL
    INTO SCIENTIFIC_CENTER.LABORATORY (dept, number_staff, phone_dept)
    VALUES ('������������ � ����������', '4', '22335')
    INTO SCIENTIFIC_CENTER.LABORATORY (dept, number_staff, phone_dept)
    VALUES ('������������� ������', '3', '21334')
    INTO SCIENTIFIC_CENTER.LABORATORY (dept, number_staff, phone_dept)
    VALUES ('����������������� ������', '3', '23333')
SELECT * FROM dual;

INSERT ALL
    INTO SCIENTIFIC_CENTER.STAFF (depar, post, lf_name, salary)
    VALUES ('������������ � ����������', '������� �������', '������ �.', '85000')
    INTO SCIENTIFIC_CENTER.STAFF (depar, post, lf_name, salary)
    VALUES ('������������ � ����������', '������� �������', '�������� �.', '85000')
    INTO SCIENTIFIC_CENTER.STAFF (depar, post, lf_name, salary)
    VALUES ('������������ � ����������', '�������', '����� �.', '82000')
    INTO SCIENTIFIC_CENTER.STAFF (depar, post, lf_name, salary)
    VALUES ('������������ � ����������', '�������', '������ �.', '82000')
    INTO SCIENTIFIC_CENTER.STAFF (depar, post, lf_name, salary)
    VALUES ('������������� ������', '�����-��������', '������ �.', '70000')
    INTO SCIENTIFIC_CENTER.STAFF (depar, post, lf_name, salary)
    VALUES ('������������� ������', '�����-��������', '������� �.', '70000')
    INTO SCIENTIFIC_CENTER.STAFF (depar, post, lf_name, salary)
    VALUES ('������������� ������', '�����', '������ �.', '64000')
    INTO SCIENTIFIC_CENTER.STAFF (depar, post, lf_name, salary)
    VALUES ('����������������� ������', '�����', '����� �.', '64000')
    INTO SCIENTIFIC_CENTER.STAFF (depar, post, lf_name, salary)
    VALUES ('����������������� ������', '�����', '�������� �.', '64000')
    INTO SCIENTIFIC_CENTER.STAFF (depar, post, lf_name, salary)
    VALUES ('����������������� ������', '�����-��������', '����� �.', '70000')
SELECT * FROM dual;






    

    
    
