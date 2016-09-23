# PL/SQL IQA 1
http://oraitresource.blogspot.com/2011/08/plsql-iqa-1.html

1.The worker table has 11 columns.  You often query the table with conditions based on four or more columns.  You create an index on all columns in the table.  What will result?
a. **Updates on the table will be slower.**
b. Updates on the table will be faster.
c. Queries on the table will be faster.
d. The size of the worker table will be increased.

2. Examine the following command:
```CREATE TABLE pay
(employee-id Number(9)
CONSTRAINT pay-pk PRIMARY KEY,
2000-pay NUMBER(8,2)
manager-name VARCHAR2(25)
CONSTRAINT mgr-name-nn.  NOT NULL,
pay-96 NUMBER(8,2));```

Which two lines of this command will return an error?
a. First
b. Second
c. Third
d. Fourth  ans
e. Fifth
f.  Sixth
g. Seventh   ans

3. You must store currency data.  All data will have two digits to the Right of the decimal point (ie, 25.xx).  The numbers to the left of the decimal point will vary.  Which data type is most appropriate?
a. NUMBER ANS
b. NUMBER(p,s) 
c. LANG
d. LANGRA

4. Examine the WORKER table below:
NAMENULL TYPE
WORKER ID  NOT NULLNUMBER(3)
NAMENOT NULLVARCHAR2(25)
PHONE  NOT NULLVARCHAR2(9)
ADDRESS VARCHAR2(50)
POSITION UPDATE
There are hundreds of records in the EMPLOYEE TABLE.  You need to modify the phone column to hold only number values.  Which statement will modify the data type appropriately?
a. ALTER TABLE worker MODIFY phone NUMBER(9)
b. ALTER WORKER table MODIFY COLUMN phone NUMBER(9)
c. A VARCHAR2 data type cannot be changed to a NUMBER data type for a column.
d. The data type of a column cannot be modified if there is data in the column.  ANS

5. What should be done after each fetch statement in a PL/SQL block?
a. Open the cursor.
b. Close the cursor.
c. Initialize the loop.
d. Test for rows using the cursor attribute.ANS

6. Examine this executable section of a PL/SQL block:
BEGIN
FOR worker_record IN pay_cursor LOOP
Worker_id_table(worker_id):=
Worker_record.last_name;
END LOOP;
CLOSE salary_cursor;
END;
Why does this section cause an error?
a. The cursor needs to be open.
b. No fetch statements were used.
c. Terminating conditions are missing.
d. The cursor does not need to be explicitly closed.  ANS

7. Your company will be granting workers a $150 salary increase.  You need to evaluate results of the increase from the worker table prior to the actual modification.  You do not want to store in the results in the current database.  Which of the following is untrue?
a. A column must be added to the worker table.
b. An arithmetic expression must be added that invokes the salary increment in the SET section of the upgrade clause.
c. An arithmetic expression must be added that invokes the salary increment in the SELECT clause of the SELECT statement.   ANS
d. An arithmetic expression must be added that invokes the salary increment in the UPDATE clause of the SELECT statement.

8.  What command should be used to execute a script file named QUERYCOLOR.SQL from the SQL Plus environment?
a. START QUERYCOLOR
b. EXECUTE QUERYCOLOR   
c. RUN QUERYCOLORANS  
d. GET QUERYCOLOR

9. You need to test if the current fetch within a PL/SQL loop was successful.  Which cursor attribute is needed to accomplish this task?
a. SQL%ISOPEN
b. SQL%ROWCOUNT
c. SQL%FOUND  ANS
d. A cursor attribute cannot be used within a PL/SQL loop.

10. You have been assigned the task of updating worker salaries.  If a salary is less than 1000, it must be incremented by 10%.  The SQL Plus substitution variable will be used to accept a worker number.  Which PL/SQL block successfully updates salaries?
a. DECLARE
V_sal worker.sal%type;
BEGIN
SELECT sal INTO v_sal FROM worker WHERE workerno=&&p_workerno;
IF 'v_sal<1000 then'
UPDATE worker INTO sal:=sal*1.1 WHERE workerno=&p_workerno;
END IF;
END;
b. DECLARE
V_sal worker.sal%type;
BEGIN
SELECT sal INTO v_sal FROM worker WHERE worker=&&p_wokerno;
IF 'v_sal<1000 then sal:=sal*1. 1'
END IF;
END;
c. DECLARE
V_sal worker.sal%type;
BEGIN
SELECT sal INTO v_sal FROM worker WHERE workerno=&&p_workerno;
IF 'v_sal<1000 then'
UPDATE emp sal:=sal*1.1 WHERE workerno=&p_workerno;
END IF;
END;
d. DECLARE
V_sal worker.sal%type;
BEGIN
SELECT sal INTO v_sal FROM worker WHERE workerno=&&p_workerno;
IF 'v_sal<1000' then
uPDATE worker SET sal:=sal*1.1  WHERE workerno=&p_workerno;
END IF;
END;  ANS

11.  Examine the following:
SET SERVER OUTPUT ON
DECLARE
X NUMBER;
V_sal NUMBER;
V_found VARCHAR2(10):= 'TRUE';
BEGIN
X:=1;
V_sal:=1000;
DECLARE
V_found VARCHAR2(10);
Y  NUMBER
BEGIN
IF(v_sal>500)
THEN v_found:= 'YES';
END IF;
DBMS_OUTPUT.PUT_LINE('VALUE OF v_found is'||v_found);
 DBMS_OUTPUT.PUT_LINE('VALUE OF v_sal is'||v_sal);
Y:=20;
END;
DBMS_OUTPUT.PUT_LIN('VALUE OF v_found is'||v_found);
DBMS_OUTPUT.PUT_LINE('VALUE OF Y is'||to_char(Y));
END;
SET SERVER OUT PUT OFF;
Why will this procedure produce an error when executed?
a. The value of v_found cannot be YES.
b. The variable v_found is declared in more than one location.
c. The variable Y is declared in the inner block and referred to in the outer block. ANS
d. The variable v_sal is declared in the outer block and referred to in the inner block.

12.  The worker table contains the following columns:
First_name   VARCHAR2(25)
Last_name   VARCHAR2(25)
Evaluate these two SQL statements:
SELECTCONTACT (first_name,last_name),LENGTH(CONTACT(first_name,last_name))
FROM worker  
WHERE UPPER(last_name)like '%J'  OR UPPER (last_name)like '%K'   OR UPPER (last_name)like '%L';

SELECTINITCAP(first_name) || INITCAP(last_name),   LENGTH(last_name)+LENGTH(first_name)
FROM worker
WHERE INTICAP(substr(last_name,1,1))In( 'J', 'K', 'L');
How will results differ between the two SQL statements?
a. Different data will be retrieved from the database.   ANS
b. The same data will be retrieved, but it will be displayed differently.
c. The first statement will be executed; the second will not.
d. The second statement will be executed; the first will not.

13. In the declarative section of a PL/SQL block, you create-but do not initialize-a number variable.  When the block executes, what will be the initial value of the variable?
a. 0
b. NullANS
c. The value will depend on the scale and precision of the variable.
d. The block will not execute because the variable was not initialized.

14.  The worker table contains the following columns:
LAST_NAME VARCHAR2(25)  FIRST_NAME  VARCHAR2(25)  DEPT_ID  NUMBER(9)
You need to display the names of workers that are not assigned to the department.  Evaluate the following:
SELECT last_name, first_name  FROM worker   WHERE dept_id is != NULL
Which of the following changes should be made to achieve the desired result?
a. Create an outer join.
b. Change the column in the WHERE condition.
c. Change the operator in the WHERE condition. ans
d. Add a second condition to the WHERE condition.

15.  Which of the following statements regarding SQL is true?
a. Null values are displayed last in ascending sequences.   ANS
b. DatE values are displayed in descending order by default.
c. You cannot specify a column alias in an ORDER BY clause.
d. Query results cannot be sorted by a column that is not included in the SELECT list.

16.  You are a user of the PROD database, which has over 1200 tables.  What data dictionary view must you query to determine the number of tables you can access?
a. ALL_OBJECTSans
b. DBA_TABLES
c. DBA_SEGMENTS
d. USER_OBJECTS

17. Evaluate the two following commands:
SELECTDISTINCT object-type FROM user-objects;
SELECTobject-typeFROM all-objects;
How will the results of the two commands differ?
a. The first statement will display the distinct object types in the database; the second statement will display the object types in the database.
b. The first statement will display the distinct object types owned by the users; the second statement will display all object types in the database.
c. The first statement will display distinct object types owned by the user; the second statement will display all the object types that the user can access.  ANS
d. The first statement will display the distinct object types that the user can access; the second statement will display all the object types that the user owns.

18. Which of the following privileges is related to system-level security?
a. Drop any table  ANS
b. DELETE
c. ALTER
d. INDEX

19. Evaluate the following:
CREATE ROLE supervisor;
CREATE ROLE clerk;
CREATE ROLE janitor;
CREATE USER alex IDENTIFIED BY green;
GRANT janitor TO clerk;
GRANT clerk TO supervisor;
GRANT janitor to alex;
/
How many ROLEs will user alex have access to?
a. 0
b. 1 ANS
c. 2
d. 3

20. Mike forgot his password. Which of the following commands will set a password for user, mike?
a. ALTER USER mike PASSWORD BY green.  The command must be issued by Mike.
b. ALTER USER mike IDENTIFIED BY green.  The command must be issued by the DBA.ANS
c. ALTER USER mike IDENTIFIED BY green.  The command must be issued by Mike. 
d. CHANGE password to green WHERE "user=mike";  The command must be issued by the DBA.

21. You are updating the worker table.  Jane has been granted the same privileges as you.  You ask her to check your work before you issue a COMMIT command.  What can she do on the workers table?
a. Jane can access the table and verify your changes.
b. Jane cannot access the table.
c. Jane can access the table but cannot see your changes.  She can make changes for you.
d. Jane can access the table, but cannot see your changes or make changes to the roles you are changing. ANS

22.  Examine the following:
Name Null?  Type
PUPIL-ID  NOT NULL NUMBER(3)
NAME   NOT NULL VARCHAR2(25)
ADDRESS VARCHAR2(50)
GRADUATION  DATE
Which of these statements inserts a new row into the PUPIL table?
a. INSERT INTO pupil VALUES(121, 'Benson');
b. INSERT INTO pupil.VALUES(121, '50 NE Oak St.', '20-MAR-01', 'Benson');
c. INSERT INTO test.VALUES(121, 'Benson', '50 NE Oak St.', '20-MAR-01');
d. INSERT INTO pupil(pupil-id,address,name,graduation) VALUES(121, '50 NE Oak St.', 'Benson', '20-MAR-01'); ANS

23.  Examine the following:
NAME   NULL?TYPE
PUPIL_ID NOT NULL NUMBER(3)
NAME   NOT NULL VARCHAR2(25)
ADDRESS VARCHAR2(50)
GRADUATION DATE
The GRADUATION column is a foreign key column to the table.  Examine the data in the GRADE DATA table:
Graduation11-May-2001
13-Jan-2001
19-Dec-2001
25-Jun-2000
Which of the following statements will produce the error…."ORA-02291 integrity constraint (sys_c23) violated.  Parent key not found.?
a. UPDATE pupil
SET pupil-id=999,
Graduation='11-MAY-2001'
WHERE stud-id=101;'
b. UPDATE pupil
SET name='Benson',
Graduation='11-MAY-2001'
WHERE pupil-id=101;
c. UPDATE pupil
SET name='Benson',
Graduation='15-AUG-200' ans
WHERE pupil-id=101
d. UPDATE pupil
SET stud-id=NULL,
Address='50 NE Oak St'
WHERE graduation='18-APR-2001'ans

24. Within SQL Plus, you issue the following:
Delete from Department where department_id=80;
You receive an integrated constraint error indicating the child record was found.  What should be done to make the statement execute?
a. Delete the child record first.  ans
b. Add a fourth keyword to the command.
c. Add the constraints cascade option to the command.
d. The statement cannot be executed.

25. The view WORKER-VIEW is created based on the WORKER table as follows:
CREATE OF REPLACE VIEW worker-viewM
AS
SELECT deptno,Sum(sal)TOT-SAL,COUNT(*) NOF-WORKER FROM worker GROUP BY deptno;
What happens when the following command is issued?
UPDATE worker-view
SET lot-sal=25000
WHERE deptno=8;
a. The base table cannot be updated through this view.   ANS
b. The TOT_SAL column in the WORKER table is updated to 25,000 for department 8.
c. The TOT_SAL column in the WORKER view is updated to 25,000 for department 8.
d. The SAL column in the WORKER table is updated to 25,000 for employees in department 8.

26. You view a card, ANN_SAL, that is based on the worker table.  The structure of the ANN_SAL view is:
NAMENULL TYPE
WORKERNO NOT NULLNUMBER(4)
YEARLY_SAL   NUMBER(9,2)
MONTHLY_SAL   NUMBER(9,2)
Which statement retrieves data from the ANN_SAL view?
a. SELECT * FROM ANN_SAL ANS
b. SELECT * FROM WORKER
c. SELECT * FROM VIEW ANN_SAL
d. SELECT * FROM VIEW ANN_SAL IS DON WORKER

27.  Evaluate the following:
IF v-value>100 THEN v-new-value:=2*v-value;
ELSIF v-value>200 THEN v-new-value:=3*v-value;
ELSIF v-value>300 THEN v-new-value:=4*v-value;
ELSE  v-new-value:=5*v-value;
END IF
What would be assigned to v_new_value if v_value=250?
a. 250
b. 500 ANS
c. 750
d. 1000

28.  The PARTICIPANTS table contains the following columns:
IDNUMBER(9)
NAMEVARCHAR(2)
COACHID NUMBER(9)
Evaluate the following statements:
SELECTp.name,c.name FROM   participant p,participant c  WHERE  c-id= c.coach-id;
SELECTp.name,c.name FROM   participant p,player c WHERE   c.coach-id=p.id;
How will the results of the two statements differ?
a. The first statement will not execute; the second statement will.
b. The first statement will execute; the second statement will not execute.
c. The first statement is a self join; the second statement is not.  ANS
d. The results will be the same, but will be displayed differently.

29.  How would you declare a PL/SQL table of records to hold the rows selected from the WORKER table?
a. DECLARE
worker-table is TABLE OF worker%ROWTYPE 
b. BEGIN
TYPE worker-table is TABLE of worker%ROWTYPE
worker-table  worker-table-type;
c. DECLARE
TYPE worker-table is TABLE of worker%ROWTYPE
INDEX BY WHOLE NUMBER:
worker-table  worker-table-type;
d. DECLARE
TYPE worker-table-type is TABLE of worker%ROWTYPE
INDEX BY BINARY INTEGER.
worker-table  worker-table-type;   ans

30.  Which type of cursor should be created when you want to create a cursor that can be used several times in a block, selecting a different active set each time it is opened?
a. A loop cursor.
b. A multiple selection cursor.
c. A cursor for each active set.
d. A cursor that uses parameters. ANS

31.  Which of the following is true when writing a cursor for loop?
a. You must explicitly fetch the rows within a cursor for loop.
b. You must explicitly open the cursor prior to the cursor for loop.
c. You must explicitly close the cursor prior to the end of the program.
d. You do not explicitly open, fetch, or close a cursor within a cursor for loop. ANS

32.  The structure of the HOUSE table is as follows:
Name Null?  Type
HOUSE NO   Not NULL  Number(25)
DNAME VARCHAR2(14)
LOCVARCHAR2(13)
Examine the following:
DECLARE
house-rec house%ROWTYPE:
BEGIN
SELECT* INTOhouse-rec FROM house WHERE houseno=10;
END;
Which PL/SQL statement displays the location of a selected department?
a. DBMS-OUTPUT.PUT_LINE(house-rec):
b. DBMS.OUTPUT.PUT_LINE(house-rec.loc); ANS
c. DBMS.OUTPUT.PUT_LINE(house-rec(1).loc);
d. You can't display a single file in the record because they are not specially identified in the declarative section.

33. Which of the following statements about implicit cursors is true?
a. They are declared implicitly only for DML statements.
b. They are declared implicitly for all DML and SELECT statement that returns single row.ANS
c. Implicit cursors must be closed before the end of PL/SQL programs.
d. Implicit cursors can be declared using the cursor type in the declaration section.

34.  Evaluate the following:
DECLARE
v-result   NUMBER(2);
BEGIN
DELETEFROM worker
WHERE division-id IN(10,20,30);
v-result:=   SQL%ROWCOUNT;
COMMIT;
END;
What will be the value of v_result if no rows are deleted?
a. 0 ANS
b. 1
c. True
d. Null

35.   Which two conditions in a PL/SQL block cause an exception error to occur?
a. Select statement does not return a row.  ANS
b. Select statement returns more than one row.ANS
c. Select statement contains a group by clause.
d. Select statement does not have a WHERE clause.

36.  You must create a program to insert records into the worker table.  Which of the following successfully uses the INSERT command?
a. DECLARE
v-hiredate DATE:=SYSDATE:
BEGIN
INSERT INTO worker(workernp, wname, hiredate, divisionno)
VALUES(workerno-sequence.nextval, '& name', v_hiredate ,&divisionno)  ----- plese check ---Ans
b. DECLARE
v-hiredate DATE:=SYSDATE:
BEGIN
INSERT INTO worker(workernp, wname, hiredate, divisionno)
c. DECLARE
v-hiredate DATE:=SYSDATE:
BEGIN
INSERT INTO worker(workernp, wname, hiredate)
VALUES(workerno-sequence.nextval, '& name',& v_hiredate &Divisionno)   
END:
d. DECLARE
v-hiredate DATE:=SYSDATE:
BEGIN
INSERT INTO worker(wordernp, wname, v_hiredate and divisionno)
Job=Clerk
END:

37. Evaluate the following:
BEGIN
FOR i IN 1..10 LOOP
 IF I=4 OR I=6
   THEN  null;
   ELSE
INSERT INTO test(result) VALUES (I);
   END IF;
COMMIT;
END LOOP;
ROLL BACK;
END.
How many values will be inserted into the test table?
a. 0
b. 4
c. 6 
d. 8   ANS
e. 12

38.  You issue the following command:
CREATE public synonym WORKER for ed.worker;
What is the result of the command?
a. The object can be accessed by all users.
b. All users are given object privileges to the table.
c. The need to qualify the object name with its schema is eliminated only for the commanding issuer.
d. The need to qualify the object name with its schema is eliminated for all users.  ANS

39.  In which order does an Oracle Server evaluate clauses?
a. HAVING, WHERE, GROUPBY
b. WHERE, GROUPBY, HAVINGANS
c. GROUPBY, HAVING, WHERE
d. WHERE, HAVING, GROUPBY

40.  You query a database with the following command:
SELECT section_no,AVG(MONTHS_BETWEEN(SYSDATE,hire-data))
FROM worker WHERE AVG(MONTHS_BETWEEN(SYSDATE,hire_date))>60
GROUP BY by section_no
ORDER BY AVG(MONTHS_BETWEEN(SYSDATE,hire_date));
Why does the command cause an error?
a. A SELECT clause cannot contain a group function.
b. A WHERE clause cannot be used to restrict groups. ANS
c. An ORDER BY clause cannot contain a group function.
d. A group function cannot contain a single row function.

41.  The path table contains the following columns:
ID NUMBER(7) PK
COST NUMBER(7,2)
PRODUCT_ID  NUMBER(7)
Evaluate the following SQL statements:
SELECT ROUND(max(cost),2),  ROUND(min(cost),2), round(sum(cost),2), ROUND(AVG(cost),2) FROM part;
SELECT product_id, ROUND(max(cost),2),ROUND(min(cost),2), ROUND(sum(cost),2), ROUND(AVG(cost),2)
FROM part GROUPBY product_id;
How will the results of the two statements differ?
a. The results will be the same, but displayed differently.
b. The first statement will only display one row of results; the second statement can display more than one row of results. --Ans
c. The first statement will display a result for each part; the second statement will display a result for each product.   
d. One of the statements will cause an error.

42. In which section of a PL/SQL block is a user-defined exception written? 
a. Heading
b. Executable
c. Declarative
d. Exception handling   ANS

43. Examine the following:
SET SERVER OUTPUT ON
DECLARE
v_char_val varchar2(100);
BEGIN
v_char_val:= 'Welcome Home',
DBMS_OUTPUT.PUT_LINE(v_char_val);
END
SET SERVER OUTPUT OFF
This code is stored in a script file named welcome.sql.  Which of the following statements will execute the code in the script file?
a. welcome.sql
b. RUN welcome.sql   ----RUNS THE CODE IN THE SCRIPT FILE
c. START welcome.sql   (  ANS)
d. EXECUTE welcome.sql

44. Which of the following statements regarding nesting blocks is true?
a. Variable names must be unique between blocks.
b. A variable defined in the outer block is visible in the inner block. ANS
c. A variable defined in the inner block is visible in the outer block.
d. A variable in an inner block may have the same name as a variable in an outer block only if the data types are different.

45. Which of the following statements is valid within the executable section of a PL/SQL block?
a. BEGIN
Worker_rec worker%ROWtype
END;
b. WHEN NO_DATA FOUND THEN DBMS_OUTPUT PUT.LIN("Nothing found");  
c. SELECT wname,sal INTO w_ename,w_sal FROM worker WHERE workno=106;   ANS
d. Procedure cal_max(n1 NUMBER n2 NUMBER, p_max OUT NUMBER)
IS
BEGIN
If n1>n2 then
p_max:=n1;
Else p_max=n2;
END.

46.  What command will send the output of an SQL* Plus session to a text file named LOG.LST?
a. SAVE LOG.LST
b. SPOOL LOG.LST   ANS
c. PRINT LOG.LST
d. SEND LOG.LST

47.  The merchandise table contains the following columns:
CODENUMBER(9)  PK
COST NUMBER(7,2)
SALE_PRICE   NUMBER(7,2)
Your supervisor asks you to calculate net revenue per unit for each product if the cost of each product is increased 10% and the sale price of each product is increased 25%.  You issue the following:
SELECT code, sale_price * 1.25 - cost * 1.10 FROM merchandise;
What conclusion can be drawn from the results?
a. Only the required results are displayed.
b. The results provide more information than management requested.
c. A function needs to be included in the SELECT statement to achieve the desired result.  ANS
d. The order of the statement must be changed to get the requested results.

48.  You have been instructed to create a report that shows different jobs in each division within your company.  No duplicate roles can be displayed.  Which of the following SELECT statements should be used?
a. SELECT divisionno, job FROM worker;
b. SELECT no duplicate divisionno, job FROM worker;
c. SELECT distinct divisionno, job FROM worker;  ANS
d. CREATE report DISPLAY divisionno, job

49. Which of the following SELECT statements displays worker names, salary, division numbers, and average salaries for all workers who earn more than the average salary in their department?
a. SELECT wname, sal, divsionno, AVG(sal) FROM workers GROUPBY wname, sal, divisionno
b. SELECT wname, sal, divsionno, AVG(sal) FROM WORKER  HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM WORKER);   ANS

50.  Mrs. Jensen is president of her company.  Four managers report to her, and all other employees report to the four managers.  Examine the following:
SELECT w.wname FROM work w WHERE w.workno not in (SELECT m.mgr FROM work m);
The above statement returns no rows.  Why?
a. All employees have a manager.
b. None of the employees have a manager.
c. A null value is returned from the subquery.   ANS
d. An operator is not allowed in subqueries.

51. Which of the following statements regarding column subqueries is true?
a. A pair wise comparison produces a cross product.
b. A non-pair wise comparison produces a cross product.
c. In a pair wise query, the values returned from the subquery are compared individually to the value in the outer query.ANS
d. In a non-pair wise query, the values returned from the subquery are compared as a group to the values in the outer query.

52.  You query a database with the following command:
SELECT dept_no,  AVG (MONTHS_BETWEEN (SYSDATE, hire_date)) FROM worker
WHERE  AVG (MONTHS_BETWEEN (SYSDATE, hire_date))   >  60
GROUP  BY  dept_no
ORDER BY   AVG (MONTHS_BETWEEN (SYSDATE, hire_date) )
Where does the statement cause an error?
a. A SELECT clause cannot contain a group function.
b. A WHERE clause cannot be used to restrict groups.   ANS
c. An ORDER BY clause cannot contain a group function.
d. A group function cannot contain a single row function.

53.  A group function ______.
a. Produces a group of results from each row.
b. Produces one result from each row of a table.
c. Produces one result from many rows per group.  ANS
d. Produces many results from many rows per group.

54.  The worker table contains the following columns:
ID_NUMBER(9)   PK
LAST_NAMEVARCHAR2(25)   NN
DEPT_ID   NUMBER(9)
Evaluate the following:
DEFINEid_3=93011
SELECT * FROM worker WHEREid = (& id_3)
Which change should be made to the script so that it will execute?
a. Remove the ampersand.
b. Use the ACCEPT account.
c. Close the cursor.
d. No change is needed.  ans

55.  Evaluate the following:
SELECTw.id,  (.15* w.salary) + (.25* w.bonus))
(w.sale_amount * (.15* w.commision_pct))
FROM worker w , sales
WHERE w.id = s.worker_id;
What would be the result of removing all parentheses from the calculation?
a. Results will be higher.
b. Results will be lower.
c. The results will be the same.  ANS   
d. The statement will not execute.

56.  Which of the following is not an i SQL Plus command?
a. DESCRIBE   
b. UPDATE  --Ans 
c. CHANGE
d. ACCEPT

57.  When selecting data, projection ______.
a. Allows you to choose rows.
b. Allows you to choose columns. ANS
c. Allows you to join tables together.
d. Allows you to add columns to a table.

58.  The worker table contains the following columns:
IDNUMBER(9)
LAST_NAMEVARCHAR2(25)
FIRST_NAME   VARCHAR2(25)
COMMISSION  NUMBER(7,2)
You must display commission calculations for employees, and are given the following guidelines:
·   Display commission multiplied by 1.5.
·   Exclude employees with zero commission.
·   Display a zero for employees with null commission value.
Evaluate the following statement:
SELECT id, last_name, first_name, commission*1.5 FROM worker WHERE commission <>0;
How many guidelines are met by the statement?
a. 3
b. 2 ANS
c. 1
d. The statement generates an error.

59.  Click EXHIBIT and examine the trace instance chart for the worker table (exhibit not available). What SQL statement must be used to display each worker hire date from earliest to last?
a. SELECThire_date   FROM worker;
b. SELECThire_date   FROM workerORDER BYhire_date; ANS
c. SELECTworkerFROM workerORDER BYhire_date;
d. SELECThire_date   FROM workerORDER BYhire_date DESC;

60.  The division table is structured as follows:
Name Null Type
DIVISIONNO NOT NULLNUMBER(2)
DNAME VARCHAR2(14)
LOCVARCHAR2(13)
Examine the following declaration:
DECLARE
TYPE  division_table_type  IS TABLE OF division %ROWTYPE
INDEX BY BINARYINTEGER
division_table   division_table_type;
You need to assign LOC file in record 13 of value 'Boston'.  Which of the following statements should be used?
a. division_table.loc.13   := 'Boston';
b. division_table[13].loc  := 'Boston';
c. division_table(13).loc := 'Boston'; ANS
d. division_table_type(13).loc   := 'Boston';

61.  You need to change the job title "Secretary" to "Administrative Assistant" for all secretaries.  Which of the following statements accomplishes this?
a. UPDATE  worker
b. UPDATE  worker
Job := 'Administrative Assistant'
WHERE  UPPER(job)  =  'Secretary'
c. UPDATE worker
SET job  =  'Administrative Assistant'ANS
WHERE UPPER(job)  =  upper('Secretary');
d. UPDATE  worker
SET values job  =  'Administrative Assistant'
WHERE UPPER(job)  =  'Secretary';

62.  You must remove all data from the color table while leaving the table definition intact.  What command should you issue, if you must be able to undo the operation?
a. DROP TABLE color.
b. DELETE FROM color.ANS
c. TRUNCATE TABLE color.
d. This cannot be done.

63.  In which section of a PL/SQL block is a user-defined exception raised?
a. Heading.
b. Execution.   ANS
c. Declarative.
d. Exception handling.

64.  In nesting blocks, ______.
a. A variable name must be unique between blocks.
b. A variable defined in the outer block is visible in the inner blocks.  ANS
c. A variable defined in the inner block is visible in the outer blocks.
d. Variable in an inner block may have the same name as a variable in an outer block if the data types are different.

65.  Examine the following:
DECLARE
i  NUMBER  :=   0;
x_date  DATE  ;
BEGIN
i   :=i  +   1;
LOOP
i:=  v_date+ 5;
i:=   i   +   1;
EXIT   WHEN  i   =   5;
ENDLOOP;
END;
You encounter unexpected results while executing the above code.  How can you trace the values of counter variable 1 and date variable x_date in an SQL* PLUS environment?
a. Set the SQL* PLUS session variable DEBUGGER=TRUE.
b. Insert the statement:
DBMS_OUTPUT  .PUT_LINE  (I, x_date);  
Between lines 8-9
c. Insert the statement:
DBMS_OUTPUT  .DEBUG_VAR  (I, x_date);
Between lines 8-9
d. Insert the statement:   ANS
DBMS_OUTPUT  .PUT_LINE  (I ||''|| TO_CHAR(v_date));
Between lines 8-9

66.  Examine the following:
SETSERVEROUTPUTON
DECLARE
v_name worker.wname%TYPE;
v_num   NUMBER;
v_sal  NUMBER(8,2);
BEGIN
---  This code displays salaries if larger than 10,000.
SELECT wname, sal
INTO v_name, v_sal
FROM worker
WHERE workerno=101;
IF(v_sal.GT.10000) THEN
DBMS_OUTPUT.PUT_LINE('Salary is '||' v_sal
|| 'for worker' || v_name);
END IF;
END
SET SERVER OUTPUT OF
This statement produces a compilation error when which PL/SQL block is executed?
a. v_num   NUMBER;
b. v_name NUMBER;
c. IF  (v_sal.GT.10000) THEN  ANS
d. This code displays salaries if larger than 10,000.

67.  You query the worker database with this command:
SELECT  last_name, first_name  FROM  worker WHERE  SALARY  IN
(SELECT salary FROM worker WHERE division_no=3 OR division_no=5);
Which values are displayed?
a. Last name and first name of workers in division numbers 3 and 5.
b. Last name and first name of all workers except those working in divisions 3 and 5.
c. Last name and first name of all workers with the same salary as workers in divisions 3 and 5.ANS
d. Last name and first name of workers whose salaries fall in the range of salaries in divisions 3 and 5.

68.  Which operator is not appropriate in the joined condition of a non-equijoin select statement?
a. In operators.
b. Like operators
c. Equal operators.ANS
d. Greater than and equal to operators.

69.  You must permanently remove all data from the INVOICE table, but will need the table structure in the future.  What single command should be issued?

a. DROP TABLE invoice
b. TRUNCATE TABLE invoice  ANS
c. DELETE FROM invoice   
d. TRNCATE TABLE invoice KEEP STRUCTURE;

70.  You issue the following command:
CREATE PUBLIC SYNONYM work FOR e. worker;
Which task has been accomplished?
a. The object is now accessible to all users.
b. All users are given object privileges to the table.
c. The need to qualify object names with the schema is eliminated only for you.
d. The need to qualify object names with the schema is eliminated for all users ANS

71.  Which data type should be used for calculating statistical probabilities with varying decimal placements (ie, 5.1236, 5, 5.1, 5.001)?
a. LONG
b. NUMBER ANS
c. NUMBER(p,s)
d. INTEGER

72.  If a DROP TABLE command is executed on a table, ______.
a. Any appending transactions are rolled back.
b. The structure of the table remains in the database and the indexes are deleted.
c. The DROP TABLE command can be executed on a table on which there are pending transactions.
d. The table structure and its deleted data cannot be rolled back and restored once the DROP TABLE command is executed.  ANS

73.  Examine the structure of the PUPILS table:
Name Null Type
PUPIL ID   NOT NULLNUMBER(3)
NAMENOT NULLVARCHAR2(25)
ADDRESS VARCHAR2(50)
GRADUATION  DATE
What statement will add a new column after the NAME column to hold phone numbers?
a. ALTER TABLE pupils ADD COLUMN3(phone varchar2(9))
b. ALTER TABLE pupils ADD COLUMN3(phone varchar2(9)AS COLUMN3;
c. ALTER TABLE pupils ADD COLUMN3(phone varchar2/9)POSITION 3;
d. Position cannot be specified when a new column is added.   ANS

74.  Which three SQL arithmetic expressions will return a date?
a. '09-dec-99' + 6   ANS
b. '09-dec-99' - 12   ANS
c. '09-dec-99' + (12/24) ANS
d. '09-dec-99' - '10-dec-99'
e. ('09-dec-99' - '10-dec-99') /6
f.  ('09-dec-99' - '10-dec-99') /12

75.  Which statement should be used to add and immediately enable a primary key constraint to the customer table using the id-number column?
a. This cannot be done.
b. ALTER TABLE customer ADD CONSTRAINT cus-id-pk PRIMARY key(id-number);  ANS
c. ALTER TABLE customer ADD (id-number CONSTRAINT cus-id-pk PRIMARY KEY);
d. ALTER TABLE customer MODIFY(id-number CONSTRAINT cus-id-pk PRIMARY KEY);

76.  Which of the following SELECT statements will query the worker table and retrieve the last name and salary of the employee whose idea is 5?
a. SELECT last-name,salary FROM worker;
b. SELECT last-name,salary FROM worker WHERE id=5; ANS
c. SELECT last-name,salary INTO v-last-name,v-salary WHERE id=5;
d. SELECT last-name,salary FROM worker INTO v-last-name,v-salary WHERE id=5;

77.  The structure of the division table is as follows:
Name Null?  Type  
DIVISION NONot NULL  Number(20)
DNAME VARCHAR2(12)
LOCVARCHAR2(13)
Examine the following declaration:
DECLARE
TYPE division-record-type is RECORD (dno NUMBER, name VARCHAR(20));
  division-rec division-record-type;
How can you retrieve an entire row of the division table using the division-rec variable?
a. SELECT * INTO division-rec FROM division WHERE division no=10;
b. SELECT divisionno, dname, loc INTO division-rec FROM division WHERE division no=10;
c. You can't retrieve an entire row using the division-rec variable declared in the code.  ANS
d. SELECT* INTO division-rec.dno, division-rec. name, division-rec FROM division WHERE division no=10;

78.  Examine the following:
DECLAR
CURSOR worker-cursor IS SELECT  wname,divisionno FROM  worker;
worker-rec worker-cursor %ROWTYPE
BEGIN
OPEN worker-cursor
LOOP
FETCH worker cursor
INTO worker-rec
EXIT WHEN worker-cursor NOT FOUND;
INSERT INTO temp-worker(name'dno) VALUES(worker-rec.wname,worker-rec divisionno);
END LOOP;
CLOSE worker-cursor;
END;
Using a cursor FOR loop, which PL/SQL block is equivalent to the above code?
a. DECLARE
CURSOR work-cursor 1S
SELECT wname, divisionno FROM work;
BEGIN
FOR work-rec IN work-cursor LOOP
INSERT INTO temp-work(name, dno) VALUES (work-rec.wname, work-re.divisionno);
END LOOP
END;  ans
b. DECLARE
CURSOR work-cursor 1S
SELECT wname, divisionno FROM work;
BEGIN
FOR work-rec IN  work-cursor LOOP
OPEN work-cursor;
INSERT INTO temp-work(name, dno) VALUES (work-rec.wname, work-re.divisionno);
END LOOP
END;
c. DECLARE
CURSOR work-cursor 1S
SELECT wname, divsisionno FROM work;   
BEGIN
FOR work-rec  IN  work-cursor LOOP
OPEN work-cursor;
INSERT INTO temp-work(name, dno) VALUES (work-rec.wname, work-re.divisionno);
END LOOP
CLOSE work-cursor;
END;
d. The above code cannot be simulated with a LOOP.

79.  An explicit cursor must be used ______.
a. When any DML or select statement is used in a PL/SQL block.
b. When a delete statement in a PL/SQL block deletes more than one row.
c. When a select statement in a PL/SQL block is more than one row.  ANS
d. When an update statement in a PL/SQL block has to modify more than one row.

80.  Examine the following:
DECLARE
CURSOR query_cursor (v_salary) IS
SELECT LAST_NAME, SALARY, DIVISION_NO FROM WORKER WHERE SALARY > V_SALARY;
Why does this statement cause an error?
a. The parameter mode was not defined.
b. A WHERE clause is not allowed in a cursor statement.
c. The INTO clause is missing from the SELECT statement.
d. A scalar type was not specified for the parameter.  ans

81.  Using SQL Plus, you create a user with the following command:
CREATE USER Joshua IDENTIFIED BY jyd205
What must you do to allow Joshua database access?
a. Use the ALTER USER command to assign default table space to Joshua.
b. Grant Joshua the CREATE SESSION privilege.ans
c. Use the ALTER USER command to assign Joshua a default profile.
d. Database access is granted by default.

82.  A DBA has added privileges to Randall's account to create tables and procedures on a database.  Which of the following can Randall perform?
a. He can create tables, drop tables, and create procedures in any schema of the database.
b. He can create any table or procedure in his schemas only.  He can drop any table from his schema only.  ANS
c. He can create a table in any schema of the database but can drop tables from and create procedures only within his own schemas.
d. He can create a table or procedure in any schema of a database and can also drop tables in any schema of the database.

83.  Which data dictionary view contains the definition of a view?
a. MY_VIEWS
b. USER_VIEWS  ans
c. SYSTEM_VIEWS
d. USER_TAB_VIEWS

84.  You create the worker table using the following command:
CREATE VIEW division-salary-vu
AS SELECT division-no,salary,last-name
FROM worker
WHERE salary>45000
WITH CHECK OPTION;
Click on the EXHIBIT button and examine the worker table (exhibit not available).  For which employee can you update the dept no column using this view?
a. Brown
b. South
c. Chizza
d. None

85.  Click on the exhibit button and examine the table instance chart of the patient table
Column name  Id_numberlast_name first_namebirth_date  physician_id
Key typePK  
Nulls/UniqueNN, UU  NN  NN 
FK table PHYSICIAN
FK columnID_NUMBER
Data type   NUM   VARCHAR2  VARCHAR2  DATE NUM
Length   10   25   25   10
You create the patient_vu view based on the id number and last name columns from the patient table.  How should you modify the view to contain only patients born in 1998?
a. Replace the view, adding a WHERE clause. ans
b. Use the ALTER command to add a WHERE clause to verify the date.
c. Drop the patient_vu, then create a new view with a WHERE clause.
d. Drop the patient_vu, then create a new view with a HAVING clause.

86.  Which of the following statements regarding the use of a sub query in the FROM clause is true?
a. A sub query cannot be used in the FROM clause.
b. The need to create a new view or table is eliminated by placing a sub query in the FROM clause. ANS
c. The need to grant SELECT privileges is eliminated by placing a sub query in the FROM clause.
d. Placing a sub query in the FROM clause defines a data source for future SELECT statements.  

87.  Examine the following chart:
Column name  Id_numberlast_name first_namebirth_date  physician_id
Key typePK  
Nulls/UniqueNN, UU  NN  NN 
FK table PHYSICIAN
FK columnID_NUMBER
Data type   NUM   VARCHAR2  VARCHAR2  DATE NUM
Length   10   25   25   10
You create the patient_id_seq sequence to be used with the patient table's primary key column.  The sequence begins at 1000 and has a maximum value of 99999999 and increments by 1.  You must write a script to insert a row into the patient table and use the sequence you created.  Which script should be used?
a. This cannot be done.
b. INSERT INTO patient(id_number, last_name, first_name, Birth_date)
VALUES(patient_id_seq, last_name, first_name, birth_date) /
c. INSERT INTO patient(id_number, last_name, first_name, Birth_date)
VALUES(patient_id_seq.NEXTVALUE, &last_name,&first_name, & birth_date) /
d. INSERT INTO patient(id_number, last_name, first_name, Birth_date)
VALUES(patient_id_seq.NEXTVAL, &last_name,&first_name, & birth_date)   /ANS

88.  The fruit table has ten columns.  Because you query the table with conditions based on four or more columns, you create an index on all columns in the table.  Which of the following will occur?
a. Updates on the table will be slower.ANS
b. Inserts will be faster.
c. All queries will be faster.
d. The size of the fruit table will increase.

89.  Examine the worker table:
WORKER
Column name  ID_NONAMESALARY DEPT_NOHIRE_DATE
Key typePK   FK  
Nulls/unique NN, UU  NN 
FK table DEPARMENT  
FK columnDEPT_NO
Data type   NUM   VARCHAR2  NUM   NUM DATE
Length   9  25   8,2  3 
You must display hire_date values in the following format:
16 of January 2001
Which SELECT statement must be used?
a. SELECT hire_date(fmDD "of"MONTH YYYY') "Date Hired" FROM worker;
b. SELECT hire_date('DD "of"MONTH YYYY') "Date Hired" FROM worker;
c. SELECT TO_CHAR (hire_date,'DDspth of MONTH YYYY') "Date Hired" FROM worker;
d. SELECT TO_CHAR(hire_date,'fmDD "of" MONTH YYYY')DATE HIRED FROM worker;   ANS

90.  Examine the worker table:
WORKER
Column name  ID_NONAMESALARY DEPT_NO  HIRE_DATE
Key typePK   FK  
Nulls/unique NN, UU  NN 
FK table DEPARMENT  
FK columnDEPT_NO
Data type   NUM   VARCHAR2  NUM   NUM   DATE
Length   9  25   8,2  3 
Which SQL statement will display employee hire date from earliest to latest?
a. SELECT hire_date FROM worker;
b. SELECT hire_date FROM worker ORDER BY hire_date;ANS
c. SELECT hire_date FROM worker GROUP BY hire_date;
d. SELECT hire_date FROM worker ORDER BY hire_date DESC;

91.  Evaluate the following PL/SQL block:
BEGIN
FROM I IN 1 . . 5 LOOP
IF i=1 THEN NULL;
ELSIF i=3 THEN COMMIT;
ELSIF i=5 THEN ROLLBACK;
ELSE INSERT INTO calculate(results);
VALUES(i);
END IF;
END LOOP;
COMMIT;
END;
How many values will be permanently inserted into the calculate table?
a. 0
b. 1 
c. 2  ---Ans
d. 3
e. 4
f.  5

92.  Which of the following scripts could be used to query the data dictionary to view only the names of the primary key constraints using a substitution parameter for the table name?
a.   ACCEPT TABLE PROMPT('table to view primary key constraint:')
SELECT constraint_name FROM user_constraint  WHERE table_name=upper('&table') AND constraint_type= 'P';  ANS
b. ACCEPT TABLE PROMPT('table to view primary key constraint:')
SELECT constraint_name FROM user_constraint WHERE table_name=upper('&table') AND constraint_type= 'PRIMARY';
c. ACCEPT TABLE PROMPT('table to view primary key constraint:')
SELECT constraint_name,constraint_type FROM user_constraint WHERE table_name=upper('&table');
d. ACCEPT TABLE PROMPT('table to view primary key constraint:')
SELECT constraint_name FROM user_cons_columns WHERE table_name=upper('&table') AND constraint_type= 'P';

93.  Match the Constraint Name to its appropriate Definition:
Constraint Name Definition 
CHECK  The column must contain a value in each row. 
NOT NULLEach value must be different in a column.
UNIQUEThe value must be unique and present.  
PRIMARY KEY  Defines a condition that each row must satisfy. 
FOREIGN KEY  Establishes a relationship between columns.  
ANS: The correct matching is
CHECK: Defines a condition that each row must satisfy.
NOT NULL:The column must contain a value in each row.
UNIQUE:Each value must be different in a column.
PRIMARY KEY:  The value must be unique and present.
FOREIGN KEY:  Establishes a relationship between columns.

94.  What statement would be used to add a primary key constraint to the patient table using the id_number column, immediately enabling the constraint?
a. This cannot be done.
b. ALTER TABLE patient MODIFY(id_number CONSTRAINT pat_id_pk PRIMARY KEY);
c. ALTER TABLE patient ADD (id_number CONSTRAINT pat_id_pk PRIMARY KEY);
d. ALTER TABLE patient ADD CONSTRAINT pat_id_pk PRIMARY KEY(id_number);  ANS

95.  You attempt to create the salary table with this command:
CREATE TABLE TENURE (worker_id NUMBER(9) CONSTRAINT tenure_pk PRIMARY KEY, 1995_salary NUMBER(8,2), NUMBER manager_name VARCHAR2(25) CONSTRAINT mgr_name_nn NOT NULL,
$ salary_96 NUMBER(8,2));
Which two lines of the statement will return errors?
a. 1
b. 2
c. 3 
d. 4  ANS
e. 5
f.  6
g. 7  ANS

96.  Which SELECT statement displays the Order ID, Product ID, and quantity of items in the merchandise table that matches both the Product ID and quantity of an item, order(20)?
a. SELECT ordeid,prodid,qty FROM merchandise WHERE (prodid,qty) IN
(SELECT prodid,qty FROM merchandise WHERE ordid=20)ANS
b. SELECT ordeid,prodid,qty FROM merchandise WHERE (prodid,qty) =
(SELECT prodid,qty FROM merchandise WHERE ordid=20) AND ordid<>20;
c. SELECT ordeid,prodid,qty FROM merchandise WHERE (prodid,qty) IN
(SELECT ordid,prodid,qty FROM item WHERE ordid=20) AND ordid<>20;
d. SELECT ordeid,prodid,qty FROM merchandise WHERE (prodid,qty) IN
(SELECT prodid,qty FROM merchandise WHERE ordid=20) AND ordid<>20;

97.  Which of the following SELECT statements displays all workers without a subordinate?
a. SELECT w.wname FROM work w WHERE w.mgr IS NOT NULL;
b. SELECT w.wname FROM work w WHERE w.workno NOT IN (select m.mgr  ans FROM work w WHER m.mgr IS NOT NULL);
c. SELECT w.wname FROM work w WHERE w.workno IN (select m.mgr FROM work m);
d. SELECT w.wname FROM work w WHERE w.workno NOT IN (select m.mgr FROM work m);

98.  Examine the following cursor statement:
DECLARE
CURSOR query_cursor(v_salary)IS
SELECT last_name,salary_divison_no
FROM worker
WHERE SALARY>v_salary;
Why does this statement cause an error?
a. The INTO clause is missing.
b. A WHERE clause cannot be used in a cursor statement.
c. A scalar data type was not specified by the parameter.  ANS
d. The parameter mode is not defined in the statement.

99.  Examine the structure of the EMP table:
EMP TABLE
NAMENULL?   TYPE
EMP NUMBER NOT NULLNUMBER(4)
JOBVARCHAR2(30)  
MGR   NUMBER(4)
HIREDATEDATE
SALARY NUMBER(7,2)
COMM   NUMBER(7,2)
DEPT NO  NOT NULLNUMBER(2)
TAX TABLE   VARCHAR2(20)
NAMENULL?   TYPE
TAX GRADE NUMBER
LOWSAL   NUMBER
HIGHSAL  NUMBER
You must create a report that displays employee details along with the tax category of each employee.  The tax category is determined by comparing the salary of the employee from the emp table to the upper and lower salary values in the tax table.  Which of the following SELECT statements will perform the necessary comparisons?
a. SELECT e.name,e.salary,e.tax grade FROM emp e,tax t WHERE e.salary between t.lowsal and t.highsal;ANS
b. SELECT e.name,e.salary,e.tax grade FROM emp e,tax t WHERE e.salary>=t.lowsal and <= t.highsal;
c. SELECT e.name,e.salary,e.tax grade FROM emp e,tax t WHERE e.salary in t.lowsal and t.highsal.
d. SELECT e.name,e.salary,e.tax grade FROM emp e,tax t WHERE e.salary<=t.lowsal and >= t.highsal;

100. Examine the structure of the product and part tables:
PRODUCT
Id PK  Name
PART
Id PK  name Product_idcost
You issue the following statement:
SELECT pt.name FROM part pt,product.printer  WHERE pt.product_id(+)=pr.id;
What will occur?
a. A list of product names will be displayed.
b. A list of products is displayed for parts that have products assigned.
c. An error will be generated.*
d. A list of all products is displayed for products with parts.

101. A group function produces ______.
a. A group of results from one row.
b. One result from each row in a table.
c. Many results from many rows per group.
d. One result from many rows per group.   ANS

102. Examine the structure of the division and worker tables below:
DIVISION
id PK  Name
WORKER
id PK  Last_name   First_name   Divion_id
Evaluate the following statement:
CRATE INDEX worker_division_id_idx
ON  worker(divison_id);
What will be the result of the statement?
a. Store and index the worker table.
b. Increase the chance of full table scans.
c. Reduce disk I/O for SELECT statements.   ANS
d. Reduce disk I/O for INSERT statements.

103. Examine the patient table:
Column name  id_numberlast_name first_namebirth_date  Physician_id
Key typePK  
Nulls/UniqueNN, U NN  NN 
FK table PHYSICIAN
FK columnID_NUMBER
Data type   NUM   VARCHAR2  VARCHAR2  DATE NUM
Length   10   25   25   10
You must create the patient_id_seq sequence to be used with the patient table's primary key column.  The sequence will begin with 1000, have a maximum value of 9999999, not reuse numbers, and increment in quantities of 1.  Which of the following statements will accomplish the task?
a. CREATE SEQUENCE patient_id_seq START WITH 1000 MAXVALUE 9999999 NO CYCLE;   ANS
b. CREATE SEQUENCE patient_id_seq START WITH 1000 MAXVALUE 9999999 STEP BY 1;
c. CREATE SEQUENCE patient_id_seq ON PATIENT(patient_id) MINVALUE 1000 MAXVALUE 9999999
INCREMENT BY 1 NO CYCLE;
d. This cannot be done.

104. You issue the following command:
CREATE SYNONYM work FOR ed.employee;
Because of the command, the need to qualify an object name with its schema has been eliminated for ______.
a. All users.
b. Only yourself.   ANS
c. User Ed.
d. Users with access.

105. You must create a report that gives, per division, the number of workers and total salary as a percentage of all divisions.  Examine the results of the report:
DIVISION   %WORKERS%SALARY
10   21.430.15
20   35.71  37.47
30   42.86  32.39
Which of the following SELECT statements will produce the above report?
a. SELECT divsionno "division", (COUNT(*)/count(workno))* 100 "%workers", (SUM(sal)count(*))* 100 "%salary"
FROM scott.work GROUP BY divisiono;
b. SELECT divisionno "division", PCT(workno) "%workers", PCT(sal) "%salary" FROM scott.work GROUP BY divisionno;
c. SELECT a.divisionno "division", (a.num_work/COUNT(*))* 100 "%workers", (a.sal_sum/COUNT(*))*100 "%salary" FROM (SELECT divisionno,COUNT(*)num_work,SUM(SAL)sal_sum FROM scott.work GROUP BY divisionno)a; ANS
d. SELECT "division", a.divisionno ROUND(a.num_work/b.total_count * 100,2)"%workers" ROUND(a.sal_sum/b.total_sal * 100,2)"%salary% FROM (SELECT divisionno, COUNT(*) num_work, SUM(SAL) sal_sum FROM scott.work GROUP BY divisionno)b;

106. In which situation would an outer query be used?
a. The worker table has two columns that correspond.
b. The worker table column corresponding to the region table contains null values for rows that need to be displayed. ANS
c. The worker and region tables have no corresponding columns.
d. The worker and region tables have corresponding columns.

107. The worker table has three columns:
LAST_NAMEVARCHAR2(23)
FIRST_NAME   VARCHAR2(23)
SALARY NUMBER(7,2)
Your manager requests that you write a statement to display all workers earning more than the average salary of all workers.  Evaluate the following SQL statement:
SELECTlast_name
FROM worker
WHERE salary > AVG(salary);
What change should be made to the statement?
a. Move the function to the SELECT clause and add a GROUP BY clause.
b. Use a sub query in the WHERE clause to compare the salary value.  ANS
c. Change the function in the WHERE clause.
d. The statement requires no modification.

108. You attempt to query the worker database with the following command:
SELECT name,salary FROM worker Where salary=
(SELECT salary FROM worker WHERE last_name= 'Johnson' OR dept_no=43)
The statement will cause an error because ______.
a. Sub queries cannot be used with the WHERE clause.
b. A multiple-row sub query has been used with a single row comparison operator.---Ans
c. A single row query has been used with a multiple-row comparison operator.  
d. Logical apparatus are not allowed in the WHERE clause.

109. Which statement will provide the view definition of the work_view that is created based on the worker table?
a. Describe work
b. DESCRIBE view work_view
c. SELECT TEXT FROM user_views WHERE view_name= 'WORK_VIEW';   ANS
d. SELECT view_text FROM my_views WHERE view_name= 'WORK_VIEW''

110. Examine the structure of the movie title, copy, and check_out tables:
MOVIE
IdPK   TitleDirector
COPY
IdPK   Title id PK  Available
CHECK_OUT
IdPKCopy_idTitle_idCheck_out_dateExpected_return_dateCustomer-id
You need to create the MOVIES_AVAILABE view, and have the following parameters:
·   Include the title of each movie.
·   Include the availability of each movie.
·   Order the results by director.
Evaluate the following statement:
CREATE VIEW movies_available
AS
SELECT b.title,c.available FROM movie_title b,copy c WERE b.id=c.title_id ORDER BY b.director;
Which of the parameters are met?
a. All
b. Twoans
c. One
d. A syntax error results. --Ans ORDERY BY  IS  USED IN THE SELECT STATE MENT OF THE VIEW

111. There are three divisions within your company and each division has at least one worker bonus program and at least one worker.  Bonus values do not exceed 500; not all employees receive bonuses.  Evaluate the following block:
DECLARE V_bonus worker.bonus%TYPE:=270;
BEGIN
UPDATE worker SET bonus=bonus+v_bonus WHERE division_id IN (10,20,30);
COMMIT;
END;
What is the result of the statement?
a. All employees will be given a bonus of 270.
b. A subset of 270 employees will be given a bonus of 270.
c. All employees will be given a 270 increase in bonus.
d. A subset of employees will be given a 270 increase in bonus. ans*

112. You have been given update privileges on the last_name column of the worker table.  Which data dictionary view would you query to display the column?  The privileges were granted on the schema that owns the worker table.
a. ALL_TABLES
b. TABLE_PRIVILEGES
c. ALL_COL_PRIVS_RECD  ans
d. This cannot be retrieved from a single view.

113. Which of the following ALTER commands reinstates a disabled primary constraint?
a. ALTER TABLE FRUIT ENABLE PRIMARY KEY(ID)
b. ALTER TABLE FRUIT Enable PRIMARY KEY(id)CASCADE;
c. ALTER TABLE FRUIT ENALBE CONSTRAINT fruit_id_pk;ans
d. ALTER TABLE FRUIT ADD CONSTRAINT fruit_id_pk PRIMARY KEY(id);

114. You have been assigned the task of making major updates to the worker table. You disable the primary key constraint on the workid column and the check constraint on the job column.  What happens when you try to enable the constraint after the update is completed?
a. Existing rows that don't conform with the constraints are automatically deleted.
b. Indexes on both columns with the primary key constraint and the check constraints are automatically recreated.
c. All existing column values are verified to conform with the constraints and an error message is narrated if any existing values are not confirmed. Ans
d. The constraints must be recreated once they are disabled.

115. Which of the following is a valid table name?
a. #_9
b. 24_bottles
c. colors-1999
d. Slipper_#66*ANS

116. Examine the structure of the pupil table:
NAMENULL?   TYPE
PUP_ID NOT NULLNUMBER(3)
NAMENOT NULLVARCHAR2(25)
PHONE  NOT NULLVARCHAR2(9)
ADDRESS VARCHAR2(50)
GRADUATION  DATE
There are over two hundred records in the pupil table.  You want to change the name of the graduation column to grad_date.  Which of the following is true?
a. You can use the ALTER TABLE command with the MODIFY COLUMN clause to modify the column.
b. You can use the ALTER TABLE command with the RENAME COLUMN clause to rename the column.
c. You can use the ALTER TABLE command with the MODIFY clause to rename the column.
d. You cannot rename the column.  ----Ans

117. Examine the automobile table:
AUTOMOBILE
Column name  IDMODEL  STYLEColor  LOT_NO
Key typePK   FK
Nulls/UniqueNN, UU  NN  NN  NN  NN
FK table LOT
FK columnLOT_NO
Data type   NUM   CHAR CHAR CHAR NUM
Length   9  20   20   20   3
Which SELECT statement will display the style, color, and lot number for all cars based on model?
a. SELECT style,color,lot_no FROM automobile WHERE model=UPPER('%model');
b. SELECT style,color,lot_no FROM automobile WHERE UPPER 'model'=('&model');
c. SELECT style,color,lot_no FROM automobile WHERE UPPER 'model'=UPPER('&model');
d. SELECT style,color,lot_no FROM automobile WHERE model='&model';

118. Examine the following DECLARE statement:
DECLARE
CURSOR work_cursor(p_divisionno NUMBER, p_job VARCHAR2)
IS
SELECT WORKNO, WNAME FROM WORK WHERE WORKNO=p_divisionno AND JOB=p_job;
BEGIN
. . .
Which statement opens the cursor successfully?
a. OPEN work_cursor.
b. OPEN work_cursor('clerk;,10);
c. OPEN work_cursor(10, 'manager');---Ans
d. OPEN work_cursor(p_divisionno,p_job);

119 As DBA, you use the CREATE USER command to create an account for user, Davis.  Davis must create tables and packages in his own schema.  What command must be executed next to grant him these privileges?
a. GRANT CREATE TABLE, CREATE PACKAGE TO davis;
b. GRANT CREATE CONNECT, CREATE TABLE, CREATE PROCEDURE TO davis;
c. GRANT CREATE TABLE, CREATE PROCEDURE TO davis;
d. GRANT CREATE SESSION,CREATE TABLE, CREATE PROCEDURE TO davis; ---Ans

120. The WORK table has columns designated for the birth date and hire date of all workers.  Both columns are defined with the DATE data type.  You want to insert a row with the details of employee Wallace, who was born in 1952 and hired in 2001.  Which of the following statements will insert the values into the table in the correct century?
a. INSERT INTO WORK(workno,wname,birthdate,hiredate)
VALUES(WORKNO_SEQ.NEXTVAL, 'Wallace', '10-nov-52', '13-jan-01')
b. INSERT INTO WORK(workno,wname,birthdate,hiredate)
VALUES(WORKNO_SEQ.NEXTVAL,  'Wallace',
TO_DATE('10-nov-52', 'DD-MON-YY'), TO_DATE('13-jan-01', 'DD-MON-YY'));
c. INSERT INTO WORK(workno,wname,birthdate,hiredate)
VALUES(WORKNO_SEQ.NEXTVAL,  'Wallace',
TO_DATE('10-nov-52', 'DD-MON-RR'), TO_DATE('13-jan-01', 'DD-MON-RR'));   ANS
d. d. INSERT INTO WORK(workno,wname,birthdate,hiredate)
VALUES(WORKNO_SEQ.NEXTVAL,  'Wallace',
TO_DATE('10-nov-52', 'DD-MON-YYYY'), TO_DATE('13-jan-01', 'DD-MON-RR'));

121. You must retrieve worker details from the work table and process them in a PL/SQL block.  Which variable type must be created in the PL/SQL block to retrieve all rows and columns using a single SELECT statement from the work table?
a. PL/SQL record.
b. PL/SQL table of records.
c. %ROWTYPE variable.--Ans
d. PL/SQL table of scalars.

122. Examine the following table:
ID NO LAST_NAMEFIRST_NAME   SALARY DEPT_NO
7  BrownJerry   30000255
6  Warner   James233
4  West   Dawn 25000102
3  Chalmers  Mack  50000   
2  Landers Jillian 32000145
5  Brunswick Kate233
1  Lauder   Susan55000   
8  Ott   Trixie  145
You query the database using the following command:
SELECT dept_no,last_name,SUM(salary) FROM worker WHERE salary < 50000 GROUP BY dept_no ORDER BY last_name;
Which clause causes an error?
a. FROM employee
b. WHERE salary<50000
c.   GROUP BY dept_no  ----Ans
d. ORDER by last_name

123. Which of the following will display the average salary of divisions 3 and 6, but only if the departments have an average salary of at least 3100?
a. SELECT divisionno, AVG(sal) FROM work WHERE divisionno IN(3,6) GROUP BY divisionno HAVING AVG (sal)>=3100;  ----Ans
b. SELECT divisionno, AVG(sal) FROM work WHERE divisionno IN (3,6) AND AVG (sal)>=3100 GROUP BY divisionno;
c. SELECT divisionno, AVG(sal) FROM work WHERE divisionno IN (3,6) GROUP BY AVG(sal) HAVING AVG(sal)>=3100;
d. SELECT divisionno, AVG(sal) FROM work GROUP BY divisionno HAVNG AVG (sal)>=2000;  Divisionno IN (3,6);

124. Examine the automobile table:
AUTOMOBILE
Column name  IDMODEL  STYLEColor  LOT_NO
Key typePK   FK
Nulls/UniqueNN, UU  NN  NN  NN  NN
FK table LOT
FK columnLOT_NO
Data type   NUM   CHAR CHAR CHAR NUM
Length   9  20   20   20   3
You query the database with the following command:
SELECT  lot_number "lot number,count(*) number of cars available" FROM automobile WHERE model= 'e300' GROUP BY lot_no HAVING COUNT (*)>10 ORDER BY COUNT (*);
Which clause restricts which groups are displayed?
a. SELECT  lot_number "lot number,count(*) number of cars available"
b. WHERE model= 'e300'
c. GROUP BY lot_no
d. HAVING COUNT (*)>10m --Ans

125. You need to create a report to display the ship date and order totals of your inventory table.  If an order has not been shipped, the report must indicate "not shipped."  If a total is not available, the report must indicate "not available."  In the inventory table, the ship date column has a data type of date and the total column has a data type of number.  Which of the following statements should be used to create the report?
a. Select inventory, ship date "Not shipped", Total "Not available" FROM order;
b. Select inventory, To-CHAR (ship date, 'Not ship') To-CHAR (total, 'Not available') FROM order;
c. Select inventory, NVL (Ship date Not), NVL (total, "Not available") FROM order;
d. Select inventory, NVL(TO=CHAR(shipdate) ,"Not Shipped") NVL (To char(total), 'not available') FROM order;

126. You want to display data about all workers with the last name Randall, but are not sure what case last names are stored in.  What statement will be successful?
a. Select last name, first name FROM work WHERE last name='randall';
b. Select last name, first name FROM work WHERE last name=UPPER ('randall');
c. Select last name, first name FROM work WHERE UPPER(last name)=('randall');
d. Select last name, first name FROM work WHERE LOWER(lastname)=('smith');

127. Your manager requests that you analyze the time taken between when orders are taken and when they are shipped.  You must create a report that displays the customer number, date of order, date shipped, and the number of months in whole numbers from the time the order is placed to the time the order is shipped.  Which statement meets these required results?
a. SELECT custid, orderdate, shipdate, ROUND(MONTHS-BETWEEN(shipdate,orderdate)) "Time Taken" FROM ord;
b. SELECT custid, orderdate, shipdate, ROUND(DAYS-BETWEEN(shipdate,orderdate))/30 FROM ord;
c. SELECT custid, orderdate, shipdate, MONTHS-BETWEEN (shipdate,orderdate) "Time Taken" FROM ord;
d. SELECT custid, orderdate, shipdate, ROUND OFF(shipdate-orderate) "Time Taken" FROM ord;

128. The worker table has the following columns:
FIRST NAMEVARCHAR2(20)
COMMISSION  NUMBER(3,2)
Evaluate the following statement:
SELECT first-name, commission FROM worker WHERE commission
(SELECT commission FROM employee WHERE UPPER(first-name)='Charles');
Which of the following will cause this statement to fail?
a. The first name values in the database are in lower case.
b. There is no employee with the first name Charles.
c. Charles has zero commission.
d. Charles has null commission.

129. You create the invoice table with the following command:
CREATE TABLE invoice (purchase_no NUMBER(8) CONSTRAINTinvoice-purchase-no-pk PRIMARY KEY,
Customer_id NUMBER(8) CONSTRAINT invoice-customer-id-nkNOT NULL);
Which index or indexes are created for the invoice table?
a. No indexes are created.
b. An index is created for each column.
c. An index is created for the purchase_no column.  -----Ans
d. An index is created for the customer_no column.

130. How would a foreign key constraint be added on the division_no column in the worker table, referring to the ID column in the division table?
a. Use the ALTER TABLE command with the ADD clause in the DETP table.
b. Use the ALTER TABLE command with the ADD clause on the EMP table.
c. Use the ALTER TABLE command with the MODIFY clause on the DEPT table.
d. This cannot be done.

131. Examine the structure of the pupil table:
Name Null Type
PUP ID   NOT NULLNUMBER(4)
NAMEVARCHAR2(20)
ADDRESS VARCHAR2(40)
GRADUATION  DATE
The table is currently empty. Which statement prevents NULL values from being entered into the Name column?
a. ALTER TABLE pupil ADD CONSTRAINT name(NOT NULL);
b. ALTER TABLE pupil MODIFY CONSTRAINT name(NOT NULL)
c. ALTER TABLE pupil ADD CONSTRAIONT NOT NULL (name);
d. ALTER TABLE pupil MODIFY(name varchar2(20) NOT NULL);   Ans

132. Examine the table instance chart for the invoice table:
INVOICE
Column name  PURCHASE_NO CUSTOMER_ID   CAR_ID SALES_ID
Key typePK   FK   FK   FK
Nulls/UniqueNN, U NN  NN  NN
FK table CUSTOMER CAREMPLOYEE
FK columnIDIDID
Data type   NUM   NUM   NUM   NUM
Length   8  8  8  8
You issue the following command:
INSERT INTO invoice(purchase_no, customer_id, cars_id) VALUES(1234,345,6);
If this statement fails, which condition explains the failure?
a. Too many foreign keys in the table.
b. Invalid data types in the statement.
c. Missing mandatory column value.   Ans
d. This statement will not fail.

133. Examine the patient table:
PATIENT
Column name  Id_numberlast_name first_namebirth_date  physician_id
Key typePK  
Nulls/UniqueNN, UU  NN  NN 
FK table PHYSICIAN
FK columnID_NUMBER
Data type   NUM   VARCHAR2  VARCHAR2  DATE NUM
Length   10   25   25   10
Which of the following DELETE statements will del ete a patient from the table by prompting the user for the id_number of the patient to be deleted.
a. DELETE FROM patient WHERE id_number=&id_number /
b. DEFINE: id_number
DELETE FROM patient   WHERE id_number=&id_number /
c. DELETE
DEFINE & id_number FROM patient WHERE id_number=&id_number
d. This cannot be done.

134. You must retrieve worker names and salaries from the work table. They must be displayed in descending order. If two names match for a salary, then the two names will be displayed in alphabetical order. Which statement should be used?
a. SELECT wname,sal FROM work ORDER BY sal,wname;
b. SELECT wname,sal FROM work ORDER BY sal,DESC,wname;
c. SELECT wname,sal FROM work ORDER BY sal,wname;
d. This cannot be done.

135.For which three of these tasks would the WHERE clause be used?
a. To display unique data.
b. To designate table location.
c. To compare two values. ANS
d. To restrict rows to be displayed.   ANS
e. To restrict the output of a group function.
f.  To only display data greater than a specified value.ANS

