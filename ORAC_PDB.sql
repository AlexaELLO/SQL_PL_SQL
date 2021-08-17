CREATE TABLESPACE cr_tbs_01
DATAFILE 'cr_tbs_01.dat'
SIZE 100M
ONLINE;
/



CREATE TEMPORARY TABLESPACE cr_temp_01
TEMPFILE 'cr_temp_01.dbf'
SIZE 50M
AUTOEXTEND ON;
/



CREATE USER MY_HEART
    IDENTIFIED BY cr1478
    DEFAULT TABLESPACE cr_tbs_01
    TEMPORARY TABLESPACE cr_temp_01
    QUOTA 70M ON cr_tbs_01;
/



CREATE TABLE MY_HEART.CLIENT (
    id NUMBER,
    cl_name VARCHAR2(80),
    date_birth DATE,
    CONSTRAINT client_pk PRIMARY KEY(id)
);
/



CREATE TABLE MY_HEART.PR_CRED (
    id NUMBER,
    num_dog VARCHAR2(30),
    summa_dog NUMBER,
    date_begin DATE,
    date_end DATE,
    id_client NUMBER,
    collect_plan NUMBER,
    collect_fact NUMBER,
    CONSTRAINT pr_cred_pk PRIMARY KEY(id),
    CONSTRAINT plan_ukey UNIQUE(collect_plan),
    CONSTRAINT fact_ukey UNIQUE(collect_fact),
    CONSTRAINT my_h_fk 
        FOREIGN KEY(id_client)
        REFERENCES MY_HEART.CLIENT(id)
);
/



CREATE TABLE MY_HEART.PLAN_OPER (
    collection_id NUMBER,
    p_date DATE,
    p_summa NUMBER,
    type_oper VARCHAR2(40),
    CONSTRAINT plan_oper_fk 
        FOREIGN KEY(collection_id)
        REFERENCES my_heart.pr_cred(collect_plan)
);
/



CREATE TABLE MY_HEART.FACT_OPER (
    collection_id NUMBER,
    f_date DATE,
    f_summa NUMBER,
    type_oper VARCHAR2(40),
    CONSTRAINT fact_oper_fk 
        FOREIGN KEY(collection_id)
        REFERENCES my_heart.pr_cred(collect_fact)
);
/



CREATE OR REPLACE FUNCTION my_heart.sum_fact_giving (sum_cred_give IN NUMBER)
RETURN NUMBER
IS
    result_sum NUMBER;
BEGIN
    SELECT SUM(f_summa) 
    INTO result_sum
    FROM MY_HEART.FACT_OPER
    WHERE collection_id = sum_cred_give
    AND type_oper = 'Выдача кредита'; 
    RETURN result_sum;
END;
/--сумма фактической выдачи кредита



COMMIT;



CREATE OR REPLACE FUNCTION my_heart.sum_fact_repayment (sum_cred_rep IN NUMBER)
RETURN NUMBER
IS
    result_rep NUMBER;
BEGIN
    SELECT SUM(f_summa) 
    INTO result_rep
    FROM MY_HEART.FACT_OPER
    WHERE collection_id = sum_cred_rep
    AND type_oper = 'Погашение кредита'
    AND f_date <= sysdate; 
    RETURN result_rep;
END;
/--сумма фактического погашения кредита



CREATE OR REPLACE FUNCTION my_heart.debt_balance (oper_id IN NUMBER)
RETURN NUMBER
IS
    result_sum NUMBER;
BEGIN
    result_sum := my_heart.sum_fact_giving(oper_id) - my_heart.sum_fact_repayment(oper_id);
    RETURN result_sum;
END;
/--остаток ссудной задолженности на дату 



CREATE OR REPLACE FUNCTION my_heart.sum_plan_percents_rep (sum_plan_per_rep IN NUMBER)
RETURN NUMBER
IS
    result_p NUMBER;
BEGIN
    SELECT SUM(p_summa) 
    INTO result_p
    FROM MY_HEART.PLAN_OPER
    WHERE collection_id = sum_plan_per_rep
    AND type_oper = 'Погашение процентов'
    AND p_date <= sysdate; 
    RETURN result_p;
END;
/--сумма плановых процентов



CREATE OR REPLACE FUNCTION my_heart.sum_fact_percents_rep (sum_fact IN NUMBER)
RETURN NUMBER
IS
    result_f NUMBER;
BEGIN
    SELECT SUM(f_summa) 
    INTO result_f
    FROM MY_HEART.FACT_OPER
    WHERE collection_id = sum_fact
    AND type_oper = 'Погашение процентов'
    AND f_date <= sysdate; 
    RETURN result_f;
END;
/--сумма фактических процентов



CREATE OR REPLACE FUNCTION my_heart.repayment_percents (p_oper_id IN NUMBER, f_oper_id IN NUMBER)
RETURN NUMBER
IS
    result_rep NUMBER;
BEGIN
    result_rep := my_heart.sum_plan_percents_rep(p_oper_id) - my_heart.sum_fact_percents_rep(f_oper_id);
    RETURN result_rep;
END;
/--остаток предстоящих процентов к погашению 




CREATE OR REPLACE FORCE VIEW my_heart.info_cred
(num_dog, cl_name, summa_dog, date_begin, date_end, debt_balance, repayment_percents, report_dt)
    AS SELECT p.num_dog, c.cl_name, p.summa_dog, p.date_begin, p.date_end, 
    debt_balance(p.collect_fact), repayment_percents(p.collect_plan, p.collect_fact), sysdate
    FROM MY_HEART.PR_CRED p, MY_HEART.CLIENT c
    WHERE p.id_client = c.id
    ORDER BY p.date_begin;
/--MAIN VIEW 



COMMIT;


SAVEPOINT normalize_plan_oper;



ALTER DATABASE OPEN;


GRANT read, write ON DIRECTORY myreport TO MY_HEART;


CREATE OR REPLACE DIRECTORY myreport AS 'C:\Users\lolol\Documents\IO';


COMMIT;


CREATE OR REPLACE PROCEDURE my_heart.write_view
IS
    l_file UTL_FILE.FILE_TYPE;
    l_string VARCHAR2(20);
BEGIN
    l_file := UTL_FILE.fopen('MYREPORT', 'infodata.csv', 'w', 11);
    l_string := 'lolololol';
    UTL_FILE.put_line(l_file, l_string);
    UTL_FILE.fclose(l_file);
END write_view;
/


COMMIT;



BEGIN
    my_heart.write_view;
END;
/



CREATE OR REPLACE PROCEDURE my_heart.write_test 
AS
    CURSOR c_date IS
        SELECT num_dog, 
               cl_name,
               summa_dog, 
               TO_CHAR(date_begin, 'DD.MM.YYYY') AS date_begin,
               TO_CHAR(date_end, 'DD.MM.YYYY') AS date_end,
               debt_balance,
               repayment_percents,
               TO_CHAR(report_dt, 'DD.MM.YYYY') AS report_dt
        FROM my_heart.info_cred;
        
    c_file UTL_FILE.FILE_TYPE;
BEGIN
    c_file := UTL_FILE.FOPEN_NCHAR(location => 'MYREPORT', filename => 'infodata.txt',
                             open_mode => 'w', max_linesize => 32000);
    FOR info_rec IN c_date LOOP
        UTL_FILE.PUT_LINE_NCHAR(c_file,
                                info_rec.num_dog || ',  ' ||
                                info_rec.cl_name || ',  ' ||
                                info_rec.summa_dog || ',  ' ||
                                info_rec.date_begin || ',  ' ||
                                info_rec.date_end || ',  ' ||
                                info_rec.debt_balance || ',  ' ||
                                info_rec.repayment_percents || ',  ' ||
                                info_rec.report_dt);
    END LOOP;
    UTL_FILE.FCLOSE(c_file);
EXCEPTION
WHEN OTHERS THEN
    UTL_FILE.FCLOSE(c_file);
    RAISE;
END write_test;
/



COMMIT;

SAVEPOINT global_point;