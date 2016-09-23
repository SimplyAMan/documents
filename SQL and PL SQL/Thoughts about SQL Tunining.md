# How to pick problematic SQL

If the SQL is still running, query GV$SESSION and GV$SQL

``` sql
  SELECT G.inst_id,
         G.SID,
         G.serial#,
         G.sql_id,
         G.event,
         G.machine,
         G.sql_exec_start,
         l.sql_text,
         l.PLAN_HASH_VALUE,
         G.blocking_session,
         G.SERVICE_NAME,
         G.status,
         G.LOGON_TIME
    FROM gv$session G,
         (SELECT DISTINCT sql_id,
                          CHILD_NUMBER,
                          PLAN_HASH_VALUE,
                          SQL_text
            FROM gv$sql) l
   WHERE G.username IS NOT NULL
     AND status = 'ACTIVE'
     AND G.sql_id = l.SQL_ID
     AND G.SQL_CHILD_NUMBER = l.CHILD_NUMBER
ORDER BY G.sql_exec_start;
```

For SQL tuning, we need to review and understand the execution plan.
Understand the execution plan is more important than understand the program logic in SQL tuning

## How to get SQL execution plan

If you get the problematic SQL from **AWR**, you can get the execution plan by running

``` sql
select * from table(Dbms_Xplan.display_awr('<SQL_ID>', null, null, 'ALL'))
```

You can get SQL_ID - unique for each SQL statement and Plan hash value – unique for each execution plan for this SQL for further tuning use.

If you get the problematic SQL from running session, you can view the execution plan by running **DBMS_XPLAN** in particular instance

``` sql
Set long 20000000
Set pagesize 0
Set linesize 200
Select * from table(dbms_xplan.display_cursor('<SQL_ID>',null , 'ALLSTATS LAST'))
```

If you get the problematic SQL from runnnig session, you can view the execution plan by using **SQL Monitor Report**

``` sql
Set long 20000000
Set pagesize 0
Set linesize 200
Select dbms_sqltune.report_sql_monitor(sql_id => 'SQL_ID') from dual
```

If you only know the package, enable trace 10046 before execute the package

```
ALTER SESSION SET max_dump_file_size=UNLIMITED;
ALTER SESSION SET tracefile_identifier='test';
ALTER SESSION SET EVENTS '10046 TRACE NAME CONTEXT forever, LEVEL 12';

EXEC PKG_TEST.PROC_TEST;
 
ALTER SESSION SET EVENTS '10046 TRACE NAME CONTEXT OFF';
```

After done, go the “user_dump_dest” and get the trace file with word 'test':

``` sql
SELECT Value
  FROM v$parameter
 WHERE NAME LIKE 'user_dump_dest';
```

# Recommended Methodology Of Tunning

## Are the underlying tables and indexes analyzed?

The cost based optimizer has the challenging job of evaluating any SQL statement and generating the "best" execution plan for the statement.
- Object metadata – The DBA controls the quality of the metadata via the dbms_stats package. This data includes the number of rows in a table, the distribution of values within a column and other critical information about the state of the tables and indexes.
- Disk I/O speed – The cost of disk I/O is the single most important factor in SQL optimization. Disk I/O is measured in thousandths of a second, an eternity for a database, and something that needs to be avoided whenever possible.

Incorrect statistic cause Optimizer:
- Choose wrong INDEX
- Choose wrong JOIN method


## Nested Loops VS Hash Join
• When to use **Hash joins**:
- At least one side of the join is returning many rows
- Low cardinality indexes are not available on the join keys.
- The join predicates use only equals (=) conditions.

• **Nested Loops** join is acceptable in a high volume SQL are:
- When the driving (inner) table will return 0 or 1 row. If you have a join query where one of the tables is supplied with the whole of a primary or unique key, Oracle can retrieve the row (if there is one) and then perform a full table scan on the second table. This is more efficient than either a sort-merge or a hash join.
- When the outer (second) table is very small (ie. fewer than 100 rows) and can fit into a single block. Since a single block is the smallest amount of data Oracle can read, a Table that fits into a single block can be accessed very fast with a Full Table Scan.

If you have dynamic working table you have two solution:
**Solution 1**:
• Gather statistic on dynamic working table after bulk insert / delete
• In the package logic:
1. Delete table
2. Insert record
3. Add Gather table statistic
4. Run other jobs

**Solution 2**:
Use SPM (SQL PLAN MANAGEMENT) for a statement, subsequent executions of that statement will use the SQL plan baseline.

1. Create a SPM for a correct execution plan
``` sql
SQLPLUS> VARIABLE CNT NUMBER ;
SQLPLUS> execute :CNT :=DBMS_SPM.LOAD_PLANS_FROM_CURSOR_CACHE(SQL_ID => '<SQL_ID>', PLAN_HASH_VALUE => '<PLAN_HASH_VALUE>');
```

Check the added SPM
``` sql
SELECT * FROM DBA_SQL_PLAN_BASELINES ORDER BY LAST_MODIFIED;
```

Check the SPM execution plan:
``` sql
SELECT * 
  FROM TABLE(DBMS_XPLAN.DISPLAY_SQL_PLAN_BASELINE('<SQL_HANDLE>'));
```  

If SPM is used, a note will indicate it when you view the execution plan:

```
SQL plan baseline SYS_SQL_PLAN_fcc170b0a62d0f4d used for this statement
```

## Does the SQL already have optimized joining method?

• During SQL tuning, objective:
- Reduce logical reads / buffer gets
- Most reliable metric
- Reduce CPU time
• Optimizer generates execution plans based on the 2 metrics
• Given a specific plan, CPU time and Buffer Gets won‟t change. But other metrics such as Elapsed time, Physical reads could change


## Does SQL has appropriate join predicates?

Oracle's Cost Based Optimizer works by analyzing several of the possible execution paths for a SQL and choosing the one that it considers best. For instance, a two table join could drive off table A and lookup table B for each row returned, or it could drive off table B. By adding in the possibilities of join methods and index selection, the number of possible execution paths increases.

2 tables : table A & table B
``` sql
Select * from A, B where A.a=B.a
```

1. Driving table A -> table B
Or
2. Driving table B -> table A

3 tables : table A & table B & table C
``` sql
Select * from A, B, C where A.a=B.a and B.b=C.b
```

1. Driving (table A -> table B result set) -> table C
2. Driving (table B -> table A result set) -> table C
3. Driving (table B -> table C result set) -> table A
4. Driving (table C -> table B result set) -> table A
5. Driving table A -> (table B -> table C result set)
6. Driving table C -> (table B -> table A result set)

A three table join has three times as many alternatives, a four table join has four times the alternatives of a three table join. In general, the number of possible execution paths for a join statement is proportional to n! (ie. n x n-1 x n-2 x ... x 2 x 1), where n is the number of tables in the join.

The problem of choosing the absolute best execution path becomes near impossible as n increases. Mathematicians call this an np-hard - or nonpolynomial - problem

If you have a table join (ie. a FROM clause) with five or more tables, and you have not included a hint for join order (eg. ORDERED or LEADING ), then Oracle may be joining the tables in the wrong order.

### How to fix it

• If the tables are being joined in the wrong order, you can supply a hint to suggest a better order.
• If Oracle is just starting with the wrong table, try a LEADING hint to suggest the best table to start with. SQLs with equi-joins will often get the rest of the joins right if only they know where to start.
• For ultimate control, update the FROM clause to list the tables in the exact order that they should be joined, and specify the ORDERED hint.

# High Level Guideline for using INDEX

• If you think Oracle should be using an index to resolve your query and it is not doing so, then make sure
- the index exists.
- the index status is USABLE
• Discuss with the DBA the prospect of adding a new index. Providing the index is efficient

• Index is good when
- Used on a medium-large table (> 500 rows) as the outer table of a Nested Loop join.
- Used on a medium-large table (> 500 rows) in a Nested Sub-Query.



