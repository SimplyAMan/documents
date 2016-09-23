# PL/SQL IQA 2
http://oraitresource.blogspot.com/2011/08/plsql-iqa-2.html

1.   The number of cascading triggers is limited by which data base initialization parameter?
CASCADE_TRIGGER_CNT
**OPEN_CURSORS**
OPEN_TRIGGERS
OPEN_DB_TRIGGERS 
2.   Which type of package construct must be declared both within package specifications and package body?
a.     All package variables.
b.    Boolean variables.
c.     Private procedures and functions.
d.    **Public procedures and functions.**

3.   Why do stored procedures and functions improve performance? (choose two)
a.   **They reduce network round trips.**
b.   **They postpone PL/SQL parsing until run time.**
c.   They allow the application to perform high speed processing locally.
d.   They reduce the number of calls to the database and decrease network traffic by bundling commands.
e.   They reduce the number of calls to the database and decrease network traffic by using the local PL/SQL engine.

4.   When creating stored procedures and functions, which construct allows you to transfer values to and from the calling environment?
Local variables.
**Formal arguments.**
Boolean variables.
Substitution variables.
5.   You need to remove the database trigger, BUSINESS_RULE. Which command do you use to remove the trigger in the SQL*Plus environment?
a.     **DROP TRIGGER business_rule;**
b.    DELETE TRIGGER business_rule;
c.     REMOVE TRIGGER business_rule;
d.    ALTER TRIGGER business_rule;
e.     DELETE FROM USER_TRIGGER WHERE TRIGGER_NAME= ‘BUSINESS_RULE’;

6.   Which two tables are fused track object dependencies?
USER_DEPENDENSIES.
USER_IDEPTREE.
IDEPTREE.
USER_DEPTREE.
USER_DEPENDS.
7. The QUERY_PRODUCT procedure directly references the product table. There is a NEW_PRODUCT_VIEW view created based on the NOT NULL columns of the table. The ADD_PRODUCT procedure updates the table indirectly by the way of NEW_PRODUCT_VIEW view. Under which circumstances does the procedureADD_PRODUCT get invalidated but automatically get complied when invoked?
When the NEW_PRODUCT_VIEW is dropped.
When rows of the product table are updated through SQL Plus.
When the internal logic of the QUERY_PRODUCT procedure is modified.
When a new column that can contain null values is added to the product table.
When a new procedure is created that updates rows in the product table directly.

8.   You need to recompile several program units you have recently modified through a PL/SQL program. Which statement is true?
You cannot recompile program units using a PL/SQL program.
You can use the DBMS_DDL. REOMPILE package procedure to recompile the program units.
You can use the DBMS_ALTER. COMPILE packaged procedure to recompile the program units.
You can use the DBMS_DDL.ALTER_COMPILE packaged procedure to recompile the program units.
You can use the DBMS_SQL.ALTER_COMPILE packaged procedure to recompile the program units.

9.   Which type of argument passes a value from a calling environment?
VARCHER2
BOOLEAN
OUT
IN

10.  You need to create a trigger on the EMP table that monitors every row that is changed and places this information into the AUDIT_TABLE. Which type of trigger do you create?
Statement-level trigger on the EMP table.
For each row trigger on the EMP table. 
Statement-level trigger on the AUDIT_TABLE table.
For each row statement level trigger on the EMP table.
For each row trigger on the AUDIT_TABLE table.

11.  In order for you to create a run package, MAINTAIN_DATA, which privilege do you need?
EXECUTE privilege on the MAINTAIN_DATA package.
INVOKE privilege on the MAINTAIN_DATA package.
EXECUTE privilege on the program units in the MAINTAIN_DATA package.
Object privilege on all of the objects that the MAINTAIN_DATA package is accessing.
Execute privilege on the program units inside the MAINTAIN_DATA package and execute privilege on the MAINTAIN_DATA package.

12.  You have created a script file EMP_PROC.SQL that holds text to create a procedure, PROCESS_EMP. You have compiled the procedure for the SQL Plus environment by running the script file EMP_PROC.SQL. What happens if there are syntax errors in the procedure PROCESS_EMP?
The errors are stored in the EMP_PROC.ERR file.
The errors are displayed to the screen when the script file is run.
The errors are stored in the PROCEDURE_ERRORS data dictionary view.
You need to issue the SHOWERRORS command in the SQL Plus environment to see the errors.
You need to issue the DISPLAY ERRORS command in the SQL Plus environment to see the errors.

13.  Which statement about local dependent objects is true?
They are on different nodes.
They are in a different database.
They are on the same node in the same database.
They are on the same node in a different database.

14.  You need to create a stored procedure that deletes rows from a table.  The name of the table from which the rows are to be deleted is unknown until run time.  Which method do you implement while creating such a procedure?
Use SQL command DELETE in the procedure to delete the rows.
Use DBMS_SQL packaged routines in the procedure to delete the rows.
Use DBMS_DML packaged routines in the procedure to delete the rows.
Use DBMSDELETE packaged routines in the procedure to delete the rows.
YOU cannot have a delete statement without providing a table name before compile time.

15.  Under which situation do you create a server-side procedure?
When the procedure contains no SQL statements.
When the procedure contains no PL/SQL commands.
When the procedure needs to be used by many client applications accessing several remote databases.
When the procedure needs to be used by many users accessing the same schema objects on a local database.

16.  Examine this procedure:
      CREATE OR REPLACE PROCEDURE ADD_PLAYER
      (V_ID IN NUMBER, V_LAST_NAME VARCHER2)
      IS
                  BEGIN
                  INSERT INTO PLAYER(ID,LAST_NAME).
                  VALUES(V_ID,V_LAST_NAME);
                  COMMIT;
      END;
      This procedure must invoke the UPD-STAT procedure and pass a parameter. Which statement will successfully invoke this procedure?

EXECUTE UPD_BAT_STAT(V_ID);
UPD_BAT_STAT(V_ID);
RUN UPD_BAT_STAT(V_ID);
START UPD_BAT_STAT(V_ID);

17.  Match the purity levels to their correct definitions:
            Terms
            RNTS
            RNPS
            WNDS
            WNPS
            Definitions
            The function cannot modify the database tables.
            The function cannot change the values of the package variables.
            The function cannot query database tables.
            The function cannot reference the value of public packaged variables.

18.  Examine this function:
CREATE OR REPLACE FUNCTION CALC_PLAYER_AVG
(V_ID in PLAYER_BAT_STAT. PLAYER_ID%TYPE)
RETURN NUMBER
IS
V_AVG NUMBER;
SELECTS HITS/AT_BATS
INTO V_AVG
FROM PLAYER_BAT_STAT
WHERE PLAYER_ID_V_ID;
RETURN(V_AVG);
END;
      This function must be moved to a package. Which additional statement must be added to the function to allow you to continue using the function in the GROUP BY clause of a SELECT statement?
PRAGMA RESTRICT_REFERENCES (CALC_PLAYER_AVG, WNDS, WNPS);
PRAGMA RESTRICT_REFERENCES (CALC_PLAYER_AVG, WNPS);
PRAGMA RESTRICT_REFERENCES (CALC_PLAYER_AVG, RNPS, WNPS);
PRAGMA RESTRICT_REFERENCES (CALC_PLAYER_AVG, ALLOW_GROUP_BY);

19.  A programmer develops a procedure, ACCOUNT_TRANSACTION, and has left your company.  You are assigned a task to modify this procedure.  You want to find all the program units invoking the ACCOUNT_TRANSACTION procedure.  How can you find this information?
Query the USER_SOURCE data dictionary view.
Query the USER_PROCEDURES data dictionary view.
Query the USER_DEPENDENCIES data dictionary views.
Set the SQL Plus environment variable trade code=true and run the ACCOUNT_TRANSACTION procedure. 
Set the SQL Plus environment variable DEPENDENCIES=TRUE and run the Account_Transaction procedure.

20.  Examine this package.
CREATE OR REPLACE PACKAGE BB_PACK
IS
V_MAX_TEAM_SALARY     NUMBER(12,2);
PROCEDURE ADD_PLAYER(V_ID NUMBER,V_LAST_NAME
VARCHER2,V_SALARY NUMBER);
END BB_PACK;
/
CREATE OR REPLACE PACKAGE BODY BB_PACK
IS
PROCEDURE UPD_PLAYER_STAT
(V_ID IN NUMBER,V_AB_IN NUMBER DEFAULT4,V_HITS IN NUMBER)
IS
BEGIN
            UPDATE PLAYER_BAT_STAT
            SET AT_BATS+V_AB,
            HITS=HITS+V_HITS
            WHERE PLAYER_ID=V_ID;
            COMMIT;
            END UPD_PLAYER_STAT;
            PROCEDURE ADD_PLAYER
(V_ID IN NUMBER,V_LAST_NAME VARCHER2,V_SALARY NUMBER)
IS
BEGIN
INSERT INTO PLAYER(ID,LAST_NAME,SALARY);
UPD_PLAYER_STAT(V_ID,0,0);
END ADD PLAYER;
END BB_PACK;
      Which statement successfully assigns $75000000 to the V_MAX_TEAM_SALARY variable from within a stand alone procedure?
V_MAX_TEAM_SALARY := 75000000;
BB_PACK.ADD_PLAYER. V_MAX_TEAM_SALARY := 75000000;
BB_PACK.V_MAX_TEAM_SALARY := 75000000;
This variable cannot be assigned a value from outside the package.

21.  Which two statements about the overloading feature of packages are true?
Only local or packaged sub programs can be overloaded.
Overloading allows different functions with the same name that differ only in their return types.
Overloading allows different subprograms with the same number, type and order of the parameter.
Overloading allows different subprograms with the same name and same number or type of the parameters.
Overloading allows different subprograms with the same name but different in either number or type or order of parameters.

22.  Examine this package:
CREATE OR REPLACE manag emps
IS
Tax_rate CONSTANT NUMBER(5,2):= . 28:,
V_id NUMBER;
PROCEDURE insert_emp(p-deptno NUMBER,p-sal NUMBER);
PROCEDURE delete_emp;
PROCEDURE update_emp:
FUNCTION calc_tax(o_sal NUMBER)
            RETURN NUMBER;
END manag_emps;
/
CREATE REPLACE PACKAGE BODY manage_emps
IS
BEGIN
Update emp
SET sal=|sal+p-raise_amt)+sal WHERE empno= v_id;
END;
PROCEDURE insert_emp
  (p_deptno NUMBER, p-sal NUMBER)
IS
BEGIN
INSERT INTO emp(empno, deptno,sal) VALUES(v_id, p_deptno, p_sal);
END insert emp;
PROCEDURE delete_emp
IS
BEGIN
DELETE FROM emp WHERE empno=v_id
END delete_emp;
PROCEDURE. Update_emp.
IS
V_sal NUMBER (10,2);
V_raise NUMBER(10,2);
BEGIN
SELECT Sal INTO v_sal FROM emp WHERE empno=v_id;
IF        v_sal<500 THEN             V_raise:=0. 05;
ELSIF   v_sal<1000 THEN          V_raise:=0. 07;
ELSE    V_raise:=0. 04
END IF;
Update_sal(v_raise);
END update_emp.
FUNCTION calc_tax
(p_sal NUMBER)
RETURN NUMBER
IS
BEGIN
            RETURN p_sal* tax-rate;
            END calc_tax;
END MANAGE_emp;
/
      What is the name of the private procedure in the package?
CALC_TAX
INSERT_EMP
UPDATE_SAL
DELETE_EMP
UPDATE_EMP
MANAGE_EMP

23.  Examine the code:
CREATE OR REPLACE TRIGGER update_emp
AFTER UPDATE ON emp
BEGIN
INSERT INTO audit_table (who, audited)
VALUES(USER, SYSDATE);
END;
      You issue an update command on the EMP table that result in changing ten rows.  How many rows are inserted into the AUDIT_TABLE?
a.             1
b.            10
c.             none
d.            Value equal to the  number of rows in the EMP table

24.  All users currently have INSERT privileges on the PLAYER table. You want only your users to insert into this table using the ADD_PLAYER procedure.  Which two actions must you take?
GRANT SELECT ON ADD_PLAYER TO PUBLIC;
GRANT EXECUTE ON ADD_PLAYER TO PUBLIC;
GRANT INSERT ON PLAYER TO PUBLIC;
GRANT EXECUTE, INSERT ON ADD_PLAYER TO PUBLIC;
REVOKE INSERT ON PLAYER FROM PUBLIC;

25.  Which oracle supply package allows you to run jobs that use defined times?
DBMS_JOB
DBMS_RUN
DBMS_PIPE
DBMS_SQL

26.  You need to drop a table from within a stored procedure.  How do you implement this?
You cannot drop a table from a stored procedure.
Use the DROP command in the procedure to drop the table.
Use the DBMS_DDL packaged routines in the procedure to drop the table.
Use the DBMS_SQL packaged routines in the procedure to drop the table. ans
Use the DBMS_DROP packaged routines in the procedure to drop the table.

27.  Which data dictionary view gives you the names and the source code of all the procedures you have created?
USER_SOURCE ans
USER_OBJECTS
USER_PROCEDURES
USER_SUBPROGRAMS

28.  Examine this package:
CREATE OR REPLACE PACKAGE BB_PACK
IS
V_MAX_TEAM_SALARY NUMBER(12,2);
PROCEDURE ADD_PLAYER(V_ID IN NUMBER, V_LAST_NAME)
VARCHAR2(V_SALARY NUMBER);
END BB_PACK;
/
CREATE OR REPLACE PACKAGE BODY BB_PACK
IS
V_PLAYER_AVG NUMBER(4,3);
PROCEDURE UPD_PLAYER_STAT
V_ID IN NUMBER, V_AB IN NUMBER DEFAULT4, V_HITS IN NUMBER)
IS
BEGIN
UPDATE PLAYER_BAT_STAT
SET ADD_BAT=ADD_BATS+V_AB,
HITS=HITS+V_HITS
WHERE PLAYER_ID=V_ID;
COMMIT;
VALIDATE_PLAYER_STAT(V_ID);
END UPD_PLAYER_STAT;
PROCEDURE ADD_PLAYER
(V_ID IN NUMBER, V_LAST_NAME, VARCHAR2, V_SALARY IN NUMBER);
IS
BEGIN
INSERT INTO PLAYER (ID, LAST_NAME, SALARY) VALUES(V_ID, V_LAST_NAME, V_SALARY);
UPD_PLAYER_STAT(V_ID,0,0);
END ADD_PLAYER;
END BB_PACK;
Which kind of packaged variable is V_MAX_TEAM_SALARY?
PRIVATE
PUBLIC ans
IN
OUT

29.  Examine this trigger:
CREATE OR REPLACE TRIGGER UPD_TEAM_SALARY
AFTER INSERT OR UPDATE OR DELETE ON PLAYER
FOR EACH ROW
BEGIN
UPDATE TEAM
SET TOT_SALARY=TOT_SALARY+:NEW SALARY.
WHERE ID=:NEW:TEAM_ID;
You will be adding additional code later but for now you want the current block to fire when updating the salary column. Which solution should you use to verify that the user is performing an update on the salary column?
ROW_UPDATE('SALARY')
UPDATING('SALARY') ans
CHANGING('SALARY')
COLUMN_UPDATE('SALARY')

30.  Examine this package:
CREATE OR REPLACE PACKAGE discounts IS
G_ID NUMBER:=7839;
DISCOUNT_RATE NUMBER 0. 00;
PROCEDURE DISPLAY_PRICE (V_PRICE NUMBER);
END DISCOUNTS;
/
CREATE OR REPLACE PACKAGE BODY discounts
IS
PROCEDURE DISPLAY_PRICE (V_PRICE_NUMBER)
IS
BEGIN DBMS_OUTPUT.PUT_LINE('DISCOUNTED||2_4 (V_PRICENVL(DISCOUNT_RATE, 1)))
END DISPLAY_PRICE;
BEGIN DISCOUNT_RATE;=0. 10;
END DISCOUNTS;
/
Which statement is true?
The value of DISCOUNT_RATE always remain 0.00 in a session.
The value of DISCOUNT_RATE is set to 0.10 each time the package is invoked in a session.
The value of DISCOUNT_RATE is set to 1 each time the procedure DISPLAY_PRICE is invoked.
The value of DISCOUNT_RATE is set to 0.10 when the package is invoked for the first time in a session. ans

31.  Examine this package:
CREATE OR REPLACE PACKAGE BB_PACK
V_MAX_TEAM_SALARY NUMBER(12,2);
PROCEDURE ADD_PLAYER(V_ID IN NUMBER, V_LAST_NAME
VARCHAR2, V_SALARY NUMBER);
DB_PACK;/ CREATE OR REPLACE PACKAGE BODY BB_PACK
IS
V_WHERE_AVG NUMBER(4,3);
PROCEDURE UPD_PLAYER_STAT
(V_ID IN NUMBER, V_AVG IN NUMBER DEFAULT 4,V_HITS IN NUMBER)
IS
BEGIN
UPDATE PLAYER_BAT_STAT
SET AT_BATS=AT_BATS+V_AB,
HITS=HITS+V_HITS
WHERE PLAYER_ID=V_ID;
COMMIT;
VALIDATE_PLAYER_STAT(V_ID);
END UPD_PLAYER_STAT;
PROCEDURE ADD-PLAYER
(V_ID IN NUMBER,  V_LAST_NAME VARCHAR2, V_SALARY NUMBER)
IS
BEGIN
INSERT INTO PLAYER(ID, LAST_NAME, SALARY) VALUES(V_ID, V_LAST_NAME, V_SALARY);
UPD_PLAYER_STAT(V_ID,0,0);
END ADD_PLAYER;
END BB_PACK;
An outside procedure VALIDATE_PLAYER_STAT is executed from this package.  What will happen         when this procedure changes?
The package specification is dropped.
The package specification is invalidated.
The package is invalid to begin with.
The package body is invalidated ans

1. Examine this function:
CREATE OR REPLACE FUNCTION CALC_PLAYER_AVG
 (V_ID in PLAYER_BAT_STAT.PLAYER_ID%TYPE)
  RETURN NUMBER IS V_AVG NUMBER;
BEGIN
  SELECT HITS / AT_BATS INTO V_AVG
  FROM PLAYER_BAT_STAT
  WHERE PLAYER_ID = V_ID;
  RETURN (V_AVG);
 END;
Which statement will successfully invoke this function in SQL *Plus?
A.    SELECT CALC_PLAYER_AVG(PLAYER_ID) FROM PLAYER_BAT_STAT;
B.    EXECUTE CALC_PLAYER_AVG(31);
C.    CALC_PLAYER('RUTH');
D.    CALC_PLAYER_AVG(31);
E.    START CALC_PLAYER_AVG(31)           Ans:  a

2.   Which three are true statements about dependent objects? (Choose three)
Invalid objects cannot be described.
An object with status of invalid cannot be a referenced object.
The Oracle server automatically records dependencies among objects.
All schema objects have a status that is recorded in the data dictionary.
You can view whether an object is valid or invalid in the USER_STATUS data dictionary view.
You can view whether an object is valid or invalid in the USER_OBJECTS data dictionary view. Ans:  cdf

3. You have created a stored procedure DELETE_TEMP_TABLE that uses dynamic SQL to remove a table in your schema. You have granted the EXECUTE privilege to user A on this procedure. When user A executes the DELETE_TEMP_TABLE procedure, under whose privileges are the operations performed by default?
SYS privileges
Your privileges
Public privileges
User A's privileges
User A cannot execute your procedure that has dynamic SQL. Ans:  b

4. Examine this code:
CREATE OR REPLACE PRODECURE add_dept (p_dept_name VARCHAR2 DEFAULT 'placeholder', p_location VARCHAR2 DEFAULT 'Boston')
IS BEGIN INSERT INTO departments VALUES (dept_id_seq.NEXTVAL, p_dept_name, p_location); END add_dept; /
Which three are valid calls to the add_dep procedure? (Choose three)
add_dept;
add_dept('Accounting');
add_dept(, 'New York');
add_dept(p_location=>'New York');        Ans:  abd

5. Which two statements about packages are true? (Choose two)
Packages can be nested.
You can pass parameters to packages.
A package is loaded into memory each time it is invoked.
The contents of packages can be shared by many applications.
You can achieve information hiding by making package constructs private. Ans:  de

6. Which two programming constructs can be grouped within a package? (Choose two)
Cursor
Constant
Trigger
Sequence
View                       Ans:  ab

7. Which two statements describe the state of a package variable after executing the package in which it is declared? (Choose two)
It persists across transactions within a session.
It persists from session to session for the same user.
It does not persist across transaction within a session.
It persists from user to user when the package is invoked.
It does not persist from session to session for the same user.   Ans:  ae

8. Which code can you use to ensure that the salary is not increased by more than 10% at a time nor is it ever decreased?
ALTER TABLE emp ADD CONSTRAINT ck_sal CHECK (sal BETWEEN sal AND  sal c1.1);
CREATE OR REPLACE TRIGGER check_sal BEFORE UPDATE OF sal ON emp FOR EACH ROW WHEN (new.sal < old.sal OR new.sal > old.sal * 1.1) BEGIN RAISE_APPLICATION_ERROR ( - 20508, 'Do not decrease salary not increase by more than 10%'); END;
CREATE OR REPLACE TRIGGER check_sal BEFORE UPDATE OF sal ON emp WHEN (new.sal < old.sal OR new.sal > old.sal * 1.1) BEGIN RAISE_APPLICATION_ERROR ( - 20508, 'Do not decrease salary not increase by more than 10%'); END;
CREATE OR REPLACE TRIGGER check_sal AFTER UPDATE OR sal ON emp WHEN (new.sal < old.sal OR -new.sal > old.sal * 1.1) BEGIN RAISE_APPLICATION_ERROR ( - 20508, 'Do not decrease salary not increase by more than 10%'); END;      Ans:  b

9.   Examine this code:
CREATE OR REPLACE PACKAGE bonus IS g_max_bonus NUMBER := .99;
FUNCTION calc_bonus (p_emp_id NUMBER) RETURN NUMBER;
FUNCTION calc_salary (p_emp_id NUMBER) RETURN NUMBER; END;

CREATE OR REPLACE PACKAGE BODY bonus IS v_salary employees.salary%TYPE;
v_bonus employees.commission_pct%TYPE; FUNCTION calc_bonus (p_emp_id NUMBER) RETURN NUMBER IS
BEGIN
SELECT salary, commission_pct INTO v_salary, v_bonus FROM employees WHERE employee_id = p_emp_id; RETURN v_bonus * v_salary; END calc_bonus FUNCTION calc_salary (p_emp_id NUMBER) RETURN NUMBER IS
BEGIN
SELECT salary, commission_pct INTO v_salary, v_bonus FROM employees WHERE employees RETURN v_bonus * v_salary + v_salary;
END cacl_salary;
END bonus; /
Which statement is true?
You can call the BONUS.CALC_SALARY packaged function from an INSERT command against EMPLOYEES table.
You can call the BONUS.CALC_SALARY packaged function from a SELECT command against EMPLOYEES table.
You can call the BONUS.CALC_SALARY packaged function form a DELETE command against EMPLOYEES table.
You can call the BONUS.CALC_SALARY packaged function from an UPDATE command against EMPLOYEES table.            Ans:  b

10. Which statement is valid when removing procedures?
Use a drop procedure statement to drop a standalone procedure.
Use a drop procedure statement to drop a procedure that is part of a package. Then recompile the package specification.
Use a drop procedure statement to drop a procedure that is part of a package. Then recompile the package body.
For faster removal and re-creation, do not use a drop procedure statement. Instead, recompile the procedure using the alter procedure statement with the REUSE SETTINGS clause.                        Ans:  a

11. Examine this package:
CREATE OR REPLACE PACKAGE BB:PACK IS V_MAX_TEAM:SALAR NUMBER(12,2);
PROCEDURE ADD_PLAYER(V_ID IN NUMBER, V_LAST_NAME VARCHAR2, V_SALARY NUMBER);
END BB_PACK; /
CREATE OR REPLACE PACKAGE BODY BB_PACK IS PROCEDURE UPD_PLAYER_STAT (V_ID IN NUMBER, V_AB IN NUMBER DEFAULT 4, V_HITS IN NUMBER) IS BEGIN UPDATE PLAYER_BAT_STAT SET AT_BATS = AT_BATS + V_AB, HITS = HITS + V_HITS WHERE PLAYER_ID = V_ID;
COMMIT;
END UPD_PLAYER_STAT;
PROCEDURE ADD_PLAYER (V_ID IN NUMBER, V_LAST_NAME VARCHAR2, V_SALARY NUMBER) IS BEGIN INSERT INTO PLAYER(ID,LAST_NAME,SALARY) VALUES (V_ID, V_LAST_NAME, V_SALARY);
UPD_PLAYER_STAT(V_ID,0,0); END ADD_PLAYER;
END BB_PACK;
You make a change to the body of the BB_PACK package. The BB_PACK body is recompiled.
What happens if the stand alone procedure VALIDATE_PLAYER_STAT references this package?
a.     VALIDATE_PLAYER_STAT cannot recompile and must be recreated.
b.    VALIDATE_PLAYER_STAT is not invalidated.
c.     VALDIATE_PLAYER_STAT is invalidated.
d.    VALIDATE_PLAYER_STAT and BB_PACK are invalidated.          Ans:  b

12. You need to create a trigger on the EMP table that monitors every row that is changed and places this information into the AUDIT_TABLE. What type of trigger do you create?
A.    FOR EACH ROW trigger on the EMP table.
B.    Statement-level trigger on the EMP table.
C.    FOR EACH ROW trigger on the AUDIT_TABLE table.
D.    Statement-level trigger on the AUDIT_TABLE table.
E.    FOR EACH ROW statement-level trigger on the EMP table. Ans:  a

13. Which statements are true? (Choose all that apply)
If errors occur during the compilation of a trigger, the trigger is still created.
If errors occur during the compilation of a trigger you can go into SQL *Plus and query the USER_TRIGGERS data dictionary view to see the compilation errors.
If errors occur during the compilation of a trigger you can use the SHOW ERRORS command within iSQL *Plus to see the compilation errors.
If errors occur during the compilation of a trigger you can go into SQL *Plus and query the USER_ERRORS data dictionary view to see compilation errors. Ans:  acd

14. Which two dictionary views track dependencies? (Choose two)
USER_SOURCE
UTL_DEPTREE.
USER_OBJECTS
DEPTREE_TEMPTAB
USER_DEPENDENCIES
DBA_DEPENDENT_OBJECTS  Ans:  de

15. Given a function CALCTAX:
CREATE OR REPLACE FUNCTION calctax (sal NUMBER) RETURN NUMBER IS
BEGIN RETURN (sal * 0.05); END;
If you want to run the above function from the SQL *Plus prompt, which statement is true?
You need to execute the command CALCTAX(1000);
You need to execute the command EXECUTE FUNCTION calctax;
You need to create a SQL *Plus environment variable X and issue the command :X := CALCTAX(1000);
You need to create a SQL *Plus environment variable X and issue the command EXECUTE :X := CALCTAX;
You need to create a SQL *Plus environment variable X and issue the command EXECUTE :X := CALCTAX(1000); Ans:  d

16. What happens during the execute phase with dynamic SQL for INSERT, UPDATE, and DELETE operations?
The rows are selected and ordered.
The validity of the SQL statement is established.
An area of memory is established to process the SQL statement.
The SQL statement is run and the number of rows processed is returned.
The area of memory established to process the SQL statement is released. Ans:  d

17. What part of a database trigger determines the number of times the trigger body executes?
Trigger type
Trigger body
Trigger event
Trigger timing Ans:  a

18. Examine this code:
CREATE OR REPLACE FUNCTION gen_email_name (p_first_name VARCHAR2, p_last_name VARCHAR2, p_id NUMBER) RETURN VARCHAR2 is v_email_name VARCHAR2(19);
BEGIN v_email_home := SUBSTR(p_first_name, 1, 1) || SUBSTR(p_last_name, 1, 7) || '@Oracle.com';
UPDATE employees SET email = v_email_name WHERE employee_id = p_id;
RETURN v_email_name; END;
You run this SELECT statement:
SELECT first_name, last_name gen_email_name(first_name, last_name, 108) EMAIL FROM employees;
What occurs?
Employee 108 has his email name updated based on the return result of the function.
The statement fails because functions called from SQL expressions cannot perform DML.
The statement fails because the functions does not contain code to end the transaction.
The SQL statement executes successfully, because UPDATE and DELETE statements are ignoring in stored functions called from SQL expressions.
The SQL statement executes successfully and control is passed to the calling environment. Ans:  b

19. Which table should you query to determine when your procedure was last compiled?
A.    USER_PROCEDURES
B.    USER_PROCS
C.    USER_OBJECTS
D.    USER_PLSQL_UNITS Ans:  c

20. Examine this code:
CREATE OR REPLACE TRIGGER secure_emp BEFORE LOGON ON employees
BEGIN
IF (TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN')) OR (TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00')
THEN RAISE_APPLICATION_ERROR (-20500, 'You may insert into the EMPLOYEES table only during business hours.');
END IF; END; /
What type of trigger is it?
A.    DML trigger
B.    INSTEAD OF trigger
C.    Application trigger
D.    System event trigger
E.    This is an invalid trigger. Ans:  e

21. Examine this package:
CREATE OR REPLACE PACKAGE discounts IS g_id NUMBER := 7829;
discount_rate NUMBER := 0.00;
PROCEDURE display_price (p_price NUMBER);
END discounts; /
CREATE OR REPLACE PACKAGE BODY discounts IS PROCEDURE display_price (p_price NUMBER) IS BEGIN DBMS_OUTPUT.PUT_LINE('Discounted '|| TO_CHAR(p_price*NVL(discount_rate, 1)));
END display_price;
BEGIN discount_rate := 0.10;
END discounts; /
Which statement is true?
A.    The value of DISCOUNT_RATE always remains 0.00 in a session.
B.    The value of DISCOUNT_RATE is set to 0.10 each time the package is invoked in a session.
C.    The value of DISCOUNT_RATE is set to 1.00 each time the procedure DISPLAY_PRICE is invoked.
D.    The value of DISCOUNT_RATE is set to 0.10 when the package is invoked for the first time in a session. Ans:  d

22. Examine this code:
CREATE OR REPLACE TRIGGER update_emp AFTER UPDATE ON emp BEGIN INSERT INTO audit_table (who, dated) VALUES (USER, SYSDATE); END;
You issue an UPDATE command in the EMP table that result in changing 10 rows. How many rows are inserted into the AUDIT_TABLE?
1
10
None
A value equal to the number of rows in the EMP table. Ans:  a

23. Examine this package:
CREATE OR REPLACE PACKAGE BB_PACK IS V_MAX_TEAM_SALARY NUMBER(12,2);
PROCEDURE ADD_PLAYER(V_ID IN NUMBER, V_LAST_NAME VARCHAR2, V_SALARY_NUMBER; END BB_PACK; /
CREATE OR REPLACE PACKAGE BODY BB_PACK IS
PROCEDURE UPD_PLAYER_STAT (V_ID IN NUMBER, V_AB IN NUMBER DEFAULT 4, V_HITS IN NUMBER) IS
BEGIN UPDATE PLAYER_BAT_STAT SET AT_BATS = AT_BATS + V_AB, HITS = HITS + V_HITS WHERE PLAYER_ID = V_ID) COMMIT;
END UPD_PLAYER_STAT;
PROCEDURE ADD_PLAYER (V_ID IN NUMBER, V_LAST_NAME VARCHAR2, V_SALARY NUMBER) IS BEGIN INSERT INTO PLAYER(ID,LAST_NAME,SALARY) VALUES (V_ID, V_LAST_NAME, V_SALARY);
UPD_PLAYER_STAT(V_ID,0.0);
END ADD_PLAYER; END BB_PACK;
Which statement will successfully assign $75,000,000 to the V_MAX_TEAM_SALARY variable from within a stand-alone procedure?
A.    V_MAX_TEAM_SALARY := 7500000;
B.    BB_PACK.ADD_PLAYER.V_MAX_TEAM_SALARY := 75000000;
C.    BB_PACK.V_MAX_TEAM_SALARY := 75000000;
D.    This variable cannot be assigned a value from outside the package. Ans:  c

24. There is a CUSTOMER table in a schema that has a public synonym CUSTOMER and you are granted all object privileges on it. You have a procedure PROCESS_CUSTOMER that processes customer information that is in the public synonym CUSTOMER table. You have just created a new table called CUSTOMER within your schema. Which statement is true?
Creating the table has no effect and procedure PROCESS_CUSTOMER still accesses data from public synonym CUSTOMER table.
If the structure of your CUSTOMER table is the same as the public synonym CUSTOMER table then the procedure PROCESS_CUSTOMER is invalidated and gives compilation errors.
If the structure of your CUSTOMER table is entirely different from the public synonym CUSTOMER table then the procedure PROCESS_CUSTOMER successfully recompiles and accesses your CUSTOMER table.
If the structure of your CUSTOMER table is the same as the public synonym CUSTOMER table then the procedure PROCESS_CUSTOMER successfully recompiles when invoked and accesses your CUSTOMER table. Ans:  d

25. Which two statements about packages are true? (Choose two)
Both the specification and body are required components of a package.
The package specification is optional, but the package body is required.
The package specification is required, but the package body is optional.
The specification and body of the package are stored together in the database.
The specification and body of the package are stored separately in the database. Ans:  ce

26. When creating a function in SQL *Plus, you receive this message:
"Warning: Function created with compilation errors."
Which command can you issue to see the actual error message?
SHOW FUNCTION_ERROR
SHOW USER_ERRORS
SHOW ERRORS
SHOW ALL_ERRORS   Ans:  c

27. Which four triggering events can cause a trigger to fire? (Choose four)
A specific error or any errors occurs.
A database is shut down or started up.
A specific user or any user logs on or off.
A user executes a CREATE or an ALTER table statement.
A user executes a SELECT statement with an ORDER BY clause.
A user executes a JOIN statement that uses four or more tables. Ans:  abcd

28. Examine this procedure:
CREATE OR REPLACE PROCEDURE ADD_PLAYER (V_ID IN NUMBER,   V_LAST_NAME VARCHAR2) IS
BEGIN
INSERT INTO PLAYER (ID,LAST_NAME) VALUES (V_ID, V_LAST_NAME);               COMMIT;   END;
This procedure must invoke the UPD_BAT_STAT procedure and pass a parameter.
Which statement, when added to the above procedure will successfully invoke the UPD_BAT_STAT procedure?
A.    EXECUTE UPD_BAT_STAT(V_ID);
B.    UPD_BAT_STAT(V_ID);
C.    RUN UPD_BAT_STAT(V_ID);
D.    START UPD_BAT_STAT(V_ID); Ans:  b

29. Which statement about triggers is true?
You use an application trigger to fire when a DELETE statement occurs.
You use a database trigger to fire when an INSERT statement occurs.
You use a system event trigger to fire when an UPDATE statement occurs.
You use INSTEAD OF trigger to fire when a SELECT statement occurs. Ans:  b

30. You want to create a PL/SQL block of code that calculates discounts on customer orders. This code will be invoked from several places, but only within the program unit ORDERTOTAL. What is the most appropriate location to store the code that calculates the discounts?
A stored procedure on the server.
A block of code in a PL/SQL library.
A standalone procedure on the client machine.
A block of code in the body of the program unit ORDERTOTAL.
A local subprogram defined within the program unit ORDERTOTAL. Ans: e

31. Which type of argument passes a value from a procedure to the calling environment?
VARCHAR2
BOOLEAN
OUT
IN Ans: c

32. You create a DML trigger. For the timing information, which is valid with a DML trigger?
DURING
INSTEAD
ON SHUTDOWN
BEFORE
ON STATEMENT EXECUTION Ans: d

33. You are about to change the arguments of the CALC_TEAM_AVG function. Which dictionary view can you query to determine the names of the procedures and functions that invoke the CALC_TEAM_AVG function?
USER_PROC_DEPENDS
USER_DEPENDENCIES
USER_REFERENCES  
USER_SOURCE Ans: b

34. A CALL statement inside the trigger body enables you to call ______.
A package.
A stored function.
A stored procedure.
Another database trigger. Ans: c

35. You need to remove the database trigger BUSINESS_HOUR. Which command do you use to remove the trigger in the SQL *Plus environment?
DROP TRIGGER business_hour;
DELETE TRIGGER business_hour;
REMOVE TRIGGER business_hour;
ALTER TRIGGER business_hour REMOVE;
DELETE FROM USER_TRIGGERS WHERE TRIGGER_NAME = 'BUSINESS_HOUR'; Ans: a

36. How can you migrate from a LONG to a LOB data type for a column?
Use the DBMS_MANAGE_LOB.MIGRATE procedure.
Use the UTL_MANAGE_LOB.MIGRATE procedure.
Use the DBMS_LOB.MIGRATE procedure.
Use the ALTER TABLE command.
You cannot migrate from a LONG to a LOB date type for a column. Ans: d

37. Examine this procedure:
CREATE OR REPLACE PROCEDURE INSERT_TEAM (V_ID in NUMBER, V_CITY in VARCHAR2 DEFAULT 'AUSTIN', V_NAME in VARCHAR2) IS
BEGIN
INSERT INTO TEAM (id, city, name) VALUES (v_id, v_city, v_name); COMMIT;
END
Which two statements will successfully invoke this procedure in SQL *Plus? (Choose two)
EXECUTE INSERT_TEAM;
EXECUTE INSERT_TEAM(3, V_NAME=>'LONGHORNS', V_CITY=>'AUSTIN');
EXECUTE INSERT_TEAM(3, 'AUSTIN','LONGHORNS');
EXECUTE INSERT_TEAM (V_ID := V_NAME := 'LONGHORNS', V_CITY := 'AUSTIN'); E. EXECUTE INSERT_TEAM (3, 'LONGHORNS'); Ans: bc

38. To be callable from a SQL expression, a user-defined function must do what?
A.    Be stored only in the database.
B.    Have both IN and OUT parameters.
C.    Use the positional notation for parameters.
D.    Return a BOOLEAN or VARCHAR2 data type. Ans: c

39. Which two describe a stored procedure? (Choose two)
A.    A stored procedure is typically written in SQL.
B.    A stored procedure is a named PL/SQL block that can accept parameters.
C.    A stored procedure is a type of PL/SQL subprogram that performs an action.
D.    A stored procedure has three parts: the specification, the body, and the exception handler part.
E.    The executable section of a stored procedure contains statements that assign values, control execution, and return values to the calling environment. Ans: bc

40. Examine this code:
CREATE OR REPLACE PROCEDURE add_dept (p_name departments.department_name%TYPE DEFAULT 'unknown', p_loc departments.location_id%TYPE DEFAULT 1700) IS.
BEGIN
INSERT INTO departments(department_id, department_name, loclation_id) VALUES(dept_seq.NEXTVAL,p_name, p_loc); END add_dept; /
You created the add_dept procedure above, and you now invoke the procedure in SQL *Plus.
Which four are valid invocations? (Choose four)
A.    EXECUTE add_dept(p_loc=>2500)
B.    EXECUTE add_dept('Education', 2500)
C.    EXECUTE add_dept('2500', p_loc =>2500)
D.    EXECUTE add_dept(p_name=>'Education', 2500)
E.    EXECUTE add_dept(p_loc=>2500, p_name=>'Education') Ans: abce

41. Which three are valid ways to minimize dependency failure? (Choose three)
Querying with the SELECT * notification.
Declaring variables with the %TYPE attribute.
Specifying schema names when referencing objects.
Declaring records by using the %ROWTYPE attribute.
Specifying package.procedure notation while executing procedures. Ans: abd

42. Which two dopes the INSTEAD OF clause in a trigger identify? (Choose two)
The view associated with the trigger.
The table associated with the trigger.
The event associated with the trigger.
The package associated with the trigger.
The statement level or for each row association to the trigger. Ans: ac

43. Examine this package:
CREATE OR REPLACE PACKAGE manage_emps IS tax_rate CONSTANT NUMBER(5,2) := .28;
v_id NUMBER;
PROCEDURE insert_emp (p_deptno NUMBER, p_sal NUMBER);
PROCEDURE delete_emp; PROCEDURE update_emp;
FUNCTION calc_tax (p_sal NUMBER) RETURN NUMBER;
END manage_emps;

CREATE OR REPLACE PACKAGE BODY manage_emps IS PROCEDURE update_sal (p_raise_amt NUMBER) IS BEGIN
UPDATE emp SET sal = (sal * p_raise_emt) + sal WHERE empno = v_id;
END;
PROCEDURE insert_emp (p_deptno NUMBER, p_sal NUMBER) IS BEGIN INSERT INTO emp(empno, deptno, sal) VALYES(v_id, p_depntno, p_sal); END insert_emp;
PROCEDURE delete_emp IS BEGIN DELETE FROM emp WHERE empno = v_id;
END delete_emp; PROCEDURE update_emp IS v_sal NUMBER(10, 2); v_raise NUMBER(10, 2);
BEGIN
SELECT sal INTO v_sal FROM emp WHERE empno = v_id;
IF v_sal < 500 THEN v_raise := .05;
ELSIF v_sal < 1000 THEN v_raise := .07;
ELSE v_raise := .04;
END IF;
update_sal(v_raise);
END update_emp;
FUNCTION calc_tax (p_sal NUMBER) RETURN NUMBER IS BEGIN RETURN p_sal * tax_rate;
END calc_tax;
END manage_emps; /
What is the name of the private procedure in this package?
A.    CALC_TAX
B.    INSERT_EMP
C.    UPDATE_SAL
D.    DELETE_EMP
E.    UPDATE_EMP
F.    MANAGE_EMPS Ans: c

44. What can you do with the DBMS_LOB package?
A.    Use the DBMS_LOB.WRITE procedure to write data to a BFILE.
B.    Use the DBMS_LOB.BFILENAME function to locate an external BFILE.
C.    Use the DBMS_LOB.FILEEXISTS function to find the location of a BFILE.
D.    Use the DBMS_LOB.FILECLOSE procedure to close the file being accessed. Ans: d

45. Examine this package:
CREATE OR REPLACE PACKAGE BB_PACK IS V_MAX_TEAM_SALARY NUMBER(12,2); PROCEDURE ADD_PLAYER(V_ID IN NUMBER, V_LAST_NAME VARCHAR2, V_SALARY NUMBER); END BB_PACK;
CREATE OR REPLACE PACKAGE BODY BB_PACK IS V_PLAYER_AVG NUMBER(4,3); PROCEDURE UPD_PLAYER_STAT V_ID IN NUMBER, V_AB IN NUMBER DEFAULT 4, V_HITS IN NUMBER) IS BEGIN UPDATE PLAYER_BAT_STAT SET AT_BATS = AT_BATS + V_AB, HITS = HITS + V_HITS WHERE PLAYER_ID = V_ID; COMMIT;
VALIDATE_PLAYER_STAT(V_ID);
 END UPD_PLAYER_STAT;
 PROCEDURE ADD_PLAYER (V_ID IN NUMBER, V_LAST_NAME VARCHAR2, V_SALARY NUMBER) IS BEGIN INSERT INTO PLAYER(ID,LAST_NAME,SALARY) VALUES (V_ID, V_LAST_NAME, V_SALARY);
UPD_PLAYER_STAT(V_ID,0,0);
END ADD_PLAYER;
END BB_PACK /
Which statement will successfully assign .333 to the V_PLAYER_AVG variable from a procedure outside the package?
V_PLAYER_AVG := .333;
BB_PACK.UPD_PLAYER_STAT.V_PLAYER_AVG := .333;
BB_PACK.V_PLAYER_AVG := .333;
This variable cannot be assigned a value from outside of the package. Ans: d

46. Examine this code:
CREATE OR REPLACE PACKAGE comm_package IS g_comm NUMBER := 10;
PROCEDURE reset_comm(p_comm IN NUMBER);
ND comm_package;
User Jones executes the following code at 9:01am:           
EXECUTE comm_package.g_comm := 15
User Smith executes the following code at 9:05am:
EXECUTE comm_paclage.g_comm := 20
Which statement is true?
g_comm has a value of 15 at 9:06am for Smith.
g_comm has a value of 15 at 9:06am for Jones.
g_comm has a value of 20 at 9:06am for both Jones and Smith.
g_comm has a value of 15 at 9:03 am for both Jones and Smith.
g_comm has a value of 10 at 9:06am for both Jones and Smith.
g_comm has a value of 10 at 9:03am for both Jones and Smith    Ans: b

47. Examine this code:
CREATE OR REPLACE FUNCTION gen_email_name (p_first_name VARCHAR2, p_last_name VARCHAR2, p_id NUMBER) RETURN VARCHAR2 IS v_email_name VARCHAR2(19=; BEGIN v_email_name := SUBSTR(p_first_name, 1, 1) || SUBSTR(p_last_name, 1, 7) || '@Oracle.com'; UPDATE employees SET email = v_email_name WHERE employee_id = p_id; RETURN v_email_name; END;
Which statement removes the function?
DROP gen_email_name;
REMOVE gen_email_name;
DELETE gen_email_name;
***MISSING*** Ans: d

48. Examine this procedure:
CREATE OR REPLACE PROCEDURE UPD_BAT_STAT (V_ID IN NUMBER DEFAULT 10, V_AB IN NUMBER DEFAULT 4) IS BEGIN UPDATE PLAYER_BAT_STAT SET AT_BATS = AT_BATS + V_AB WHERE PLAYER_ID = V_ID; COMMIT; END;
Which two statements will successfully invoke this procedure in SQL *Plus? (Choose two)
EXECUTE UPD_BAT_STAT;
EXECUTE UPD_BAT_STAT(V_AB=>10, V_ID=>31);
EXECUTE UPD_BAT_STAT(31, 'FOUR','TWO');
UPD_BAT_STAT(V_AB=>10, V_ID=>31);
RUN UPD_BAT_STAT; Ans: ab

49. Examine this code:
CREATE OR REPLACE PROCEDURE audit_action (p_who VARCHAR2) AS BEGIN INSERT INTO audit(schema_user) VALUES(p_who); END audit_action; /
CREATE OR REPLACE TRIGGER watch_it AFTER LOGON ON DATABASE.
CALL audit_action(ora_login_user) ;
What does this trigger do?
The trigger records an audit trail when a user makes changes to the database.
The trigger marks the user as logged on to the database before an audit statement is issued.
The trigger invoked the procedure audit_action each time a user logs on to his/her schema and adds the username to the audit table.
The trigger invokes the procedure audit_action each time a user logs on to the database and adds the username to the audit table. Ans: d

50. Which view displays indirect dependencies, indenting each dependency?
DEPTREE
IDEPTREE
INDENT_TREE
I_DEPT_TREE Ans: b

51. The OLD and NEW qualifiers can be used in which type of trigger?
Row level DML trigger
Row level system trigger
Statement level DML trigger
Row level application trigger
Statement level system trigger
Statement level application trigger Ans: a

52. Which statement is true?
Stored functions can be called from the SELECT and WHERE clauses only.
Stored functions do not permit calculations that involve database links in a distributed environment.
Stored functions cannot manipulate new types of data, such as longitude and latitude.
Stored functions can increase the efficiency of queries by performing functions in the query rather than in the application. Ans: d

53. Examine the trigger:
CREATE OR REPLACE TRIGGER Emp_count AFTER DELETE ON Emp_tab FOR EACH ROW DELCARE n INTEGER;
BEGIN SELECT COUNT(*) INTO n FROM Emp_tab;
DMBS_OUTPUT.PUT_LINE(' There are now ' || a || ' employees,'); END;
This trigger results in an error after this SQL statement is entered:
DELETE FROM Emp_tab WHERE Empno = 7499;
How do you correct the error?
Change the trigger type to a BEFORE DELETE .
Take out the COUNT function because it is not allowed in a trigger.
Remove the DBMS_OUTPUT statement because it is not allowed in a trigger.
Change the trigger to a statement-level trigger by removing FOR EACH ROW. Ans: d

54. What is true about stored procedures?
A.    A stored procedure uses the DELCLARE keyword in the procedure specification to declare formal parameters.
B.    A stored procedure is named PL/SQL block with at least one parameter declaration in the procedure specification.
C.    A stored procedure must have at least one executable statement in the procedure body.
D.    A stored procedure uses the DECLARE keyword in the procedure body to declare formal parameters. Ans: c

55. Examine this code:
CREATE OR REPLACE PROCEDURE insert_dept (p_location_id NUMBER) IS v_dept_id NUMBER(4);
 BEGIN
     INSERT INTO departments VALUES (5, 'Education', 150, p_location_id);
     SELECT department_id INTO v_dept_id FROM employees WHERE employee_id=99999; END insert_dept; /
CREATE OR REPLACE PROCEDURE insert_location ( p_location_id NUMBER, p_city VARCHAR2) IS
BEGIN
     INSERT INTO locations(location_id, city) VALUES (p_location_id, p_city);
     insert_dept(p_location_id);
END insert_location; /
You just created the departments, the locations, and the employees table. You did not insert any rows. Next you created both procedures. You now invoke the insert_location procedure using the following command:
EXECUTE insert_location (19, 'San Francisco')
What is the result in this EXECUTE command?
A.    The locations, departments, and employees tables are empty.
B.    The departments table has one row. The locations and the employees tables are empty.
C.    The location table has one row. The departments and the employees tables are empty.
D.    The locations table and the departments table both have one row. The employees table is empty. Ans: a

56. The creation of which four database objects will cause a DDL trigger to fire? (Choose four)
Index
Cluster
Package
Function
Synonyms
Dimensions
Database links Ans: abcd

57. Which two program declarations are correct for a stored program unit? (Choose two)
A.    CREATE OR REPLACE FUNCTION tax_amt (p_id NUMBER) RETURN NUMBER
B.    CREATE OR REPLACE PROCEDURE tax_amt (p_id NUMBER) RETURN NUMBER
C.    CREATE OR REPLACE PROCEDURE tax_amt (p_id NUMBER, p_amount OUT NUMBER)
D.    CREATE OR REPLACE FUNCTION tax_amt (p_id NUMBER) RETURN NUMBER(10,2)
E.    CREATE OR REPLACE PROCEDURE tax_amt (p_id NUMBER, p_amount OUT NUMBER(10, 2)) Ans: ac

58. You need to implement a virtual private database (vpd). In order to have the vpd functionality, a trigger is required to fire when every user initiates a session in the database. What type of trigger needs to be created?
DML trigger
System event trigger
INSTEAD OF trigger
Application trigger Ans: b

59. You have a row level BEFORE UPDATE trigger on the EMP table. This trigger contains a SELECT statement on the EMP table to ensure that the new salary value falls within the minimum and maximum salary for a given job title. What happens when you try to update a salary value in the EMP table?
A.    The trigger fires successfully.
B.    The trigger fails because it needs to be a row level AFTER UPDATE trigger.
C.    The trigger fails because a SELECT statement on the table being updated is not allowed.
D.    The trigger fails because you cannot use the minimum and maximum functions in a BEFORE UPDATE trigger. Ans: c

60. Examine this code:
CREATE OR REPLACE STORED FUNCTION get_sal (p_raise_amt NUMBER, p_employee_id employees.employee_id%TYPE) RETURN NUMBER.
IS v_salary NUMBER; v_raise NUMBER(8,2); BEGIN SELECT salary INTO v_salary FROM employees WHERE employee_id = p_employee_id; v_raise := p_raise_amt * v_salary; RETURN v_raise; END;
Which statement is true?
This statement creates a stored procedure named get_sal.
This statement returns a raise amount based on an employee id.
This statement creates a stored function named get_sal with a status of invalid.
This statement creates a stored function named get_sal.
This statement fails. Ans: e

61. You need to disable all triggers on the EMPLOYEES table. Which command accomplishes this?
None of these commands; you cannot disable multiple triggers on a table in one command.
ALTER TRIGGERS ON TABLE employees DISABLE;
ALTER employees DISABLE ALL TRIGGERS;
ALTER TABLE employees DISABLE ALL TRIGGERS;  Ans:  d

62. An internal LOB is _____.
A table.
A column that is a primary key.
Stored in the database.
A file stored outside of the database, with an internal pointer to it from a database column. Ans: c

63. Examine this code:
CREATE OR REPLACE FUNCTION calc_sal (p_salary NUMBER) RETURN NUMBER IS v_raise NUMBER(4,2) DEFAULT 1.08;
BEGIN
 RETURN v_raise * p_salary;
END calc_sal; /
Which statement accurately call the stored function CALC_SAL ? (Choose two)
UPDATE employees (calc_sal(salary)) SET salary = salary * calc_sal(salary);
INSERT calc_sal(salary) NOT employees WHERE department_id = 60;
DELETE FROM employees(calc_sal(salary)) WHERE calc_sal(salary) > 1000;
SELECT salary, calc_sal(salary) FROM employees WHERE department_id = 60;
SELECT last_name, salary, calc_sal(salary) FROM employees ORDER BY calc_sal(salary); Ans: de

64. This statement fails when executed:
CREATE OR REPLACE TRIGGER CALC_TEAM_AVG AFTER INSERT ON PLAYER BEGIN
INSERT INTO PLAYER_BATSTAT (PLAYER_ID, SEASON_YEAR,AT_BATS,HITS) VALUES (:NEW.ID, 1997, 0,0); END;
To which type must you convert the trigger to correct the error?
Row.
Statement
ORACLE FORM trigger
Before Ans: a

65. Examine this code:
CREATE OR REPLACE PROCEDURE audit_emp (p_id IN emp_empno%TYPE) IS
 v_id NUMBER;
PROCEDURE log_exec IS BEGIN INSERT INTO log_table (user_id, log_delete) VALUES (USER, SYSDATE); END log_excec;
v_name VARCHAR2(20);
BEGIN
DELETE FROM emp WHERE empno = p_id; log_exec; SELECT ename, empno INTO v_name, v_id FROM emp WHERE empno = p_id; END audit_temp;
Why does this code cause an error when compiled?
An statement is not allowed in a subprogram declaration.
Procedure LOG_EXEC should be declared before any identifiers.
Variable v_name should be declared before declaring the LOG_EXEC procedure.
The LOG_EXEC procedure should be invoked as EXECUTE log_exec with the AUDIT_EMP procedure. Ans: c

66. Examine this code:
CREATE OR REPLACE PACKAGE metric_converter IS c_height CONSTRAINT NUMBER := 2.54; c_weight CONSTRAINT NUMBER := .454; FUNCTION calc_height (p_height_in_inches NUMBER) RETURN NUMBER;
FUNCTION calc_weight (p_weight_in_pounds NUMBER) RETURN NUMBER;
END;
CREATE OR REPLACE PACKAGE BODY metric_converter IS FUNCTION calc_height (p_height_in_inches NUMBER) RETURN NUMBER IS BEGIN RETURN p_height_in_inches * c_height;
END calc_height;
FUNCTION calc_weight (p_weight_in_pounds NUMBER) RETURN NUMBER IS BEGIN RETURN p_weight_in_pounds * c_weight END calc_weight END metric_converter; /
CREATE OR REPLACE FUNCTION calc_height (p_height_in_inches NUMBER) RETURN NUMBER IS BEGIN RETURN p_height_in_inches * metric_converter.c_height; END calc_height; /
Which statement is true?
a.     If you remove the package specification, then the package body and the stand alone stored function CALC_HEIGHT are removed.
b.    If you remove the package body, then the package specification and the stand alone stored function CALC_HEIGHT are removed.
c.     If you remove the package specification, then the package body is removed.
d.    If you remove the package body, then the package specification is removed.
e.     If you remove the stand alone stored function CALC_HEIGHT, then the METRIC_CONVERTER package body and the package specification are removed.
f.     The stand alone function CALC_HEIGHT cannot be created because its name is used in a packaged function. Ans:  c

67. What is a condition predicate in a DML trigger?
A.    A conditional predicate allows you to specify a WHEN-LOGGING-ON condition in the trigger body.
B.    A conditional predicate means you use the NEW and OLD qualifiers in the trigger body as a condition.
C.    A conditional predicate allows you to combine several DBM triggering events into one in the trigger body.
D.    A conditional predicate allows you to specify a SHUTDOWN or STARTUP condition in trigger body. Ans:  c

68. Examine this package specification:
CREATE OR REPLACE PACKAGE concat_all IS v_string VARCHAR2(100);
PROCEDURE combine (p_num_val NUMBER);
PROCEDURE combine (p_date_val DATE);
PROCEDURE combine (p_char_val VARCHAR2, p_num_val NUMBER);
END concat_all; /
Which overloaded COMBINE procedure declaration can be added to this package specification?
a.     PROCEDURE combine;
b.    PROCEDURE combine (p_no NUMBER);
c.     PROCEDURE combine (p_val_1 VARCHAR2, p_val_2 NUMBER;
d.    PROCEDURE concat_all (p_num_val VARCHAR2, p_char_val NUMBER); Ans:  a

69. Local procedure A calls remote procedure B. Procedure B was compiled at 8 A.M. Procedure A was modified and recompiled at 9 A.M. Remote procedure B was later modified and recompiled at 11 A.M.
The dependency mode is set to TIMESTAMP. What happens when procedure A is invoked at 1 P.M?
A.    There is no affect on procedure A and it runs successfully.
B.    Procedure B is invalidated and recompiles when invoked.
C.    Procedure A is invalidated and recompiles for the first time it is invoked.
D.    Procedure A is invalidated and recompiles for the second time it is invoked. Answer

70. Under which two circumstances do you design database triggers? (Choose two)
To duplicate the functionality of other triggers.
To replicate built-in constraints in the Oracle server such as primary key and foreign key.
To guarantee that when a specific operation is performed, related actions are performed.
For centralized, global operations that should be fired for the triggering statement, regardless of which user or application issues the statement. Ans:  cd

71. Examine this procedure
CREATE OR REPLACE PROCEDURE DELETE_PLAYER (V_ID IN NUMBER) IS BEGIN DELETE FROM PLAYER WHERE ID = V_ID EXCEPTION
WHEN STATS_EXITS_EXCEPTION THEN
DBMS_OUTPUT.PUT_LINE ('Cannot delete this player, child records exist in PLAYER_BAT_STAT table');
END;
What prevents this procedure from being created successfully?
A comma has been left after the STATS_EXIST_EXCEPTION exception.
The STATS_EXIST_EXCEPTION has not been declared as a number.
The STATS_EXIST_EXCEPTION has not been declared as an exception.
Only predefined exceptions are allowed in the EXCEPTION section.        Ans:  c