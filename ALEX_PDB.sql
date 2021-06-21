show con_name;

CREATE TABLESPACE alex_tbs_01
    DATAFILE 'alex_tbs_01.dat'
    SIZE 70M
    ONLINE;
    
CREATE TEMPORARY TABLESPACE alex_tbs_tem_01
    TEMPFILE 'alex_tbs_tem_01.dbf'
    SIZE 30M
    AUTOEXTEND ON;
    
CREATE USER UNIVERSITY
    IDENTIFIED BY gaga15
    DEFAULT TABLESPACE alex_tbs_01
    TEMPORARY TABLESPACE alex_tbs_tem_01
    QUOTA 50M ON alex_tbs_01;