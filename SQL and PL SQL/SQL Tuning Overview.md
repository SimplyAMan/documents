[Оригінал статті](https://docs.oracle.com/cd/B19306_01/server.102/b14211/sql_1016.htm)
[](){#BEGIN} <span id="PAGE" style="display:none;">19/33</span> [](){#g42927}
# <span class="secnum">11</span> [](){#PFGRF006}SQL Tuning Overview {#sql-tuning-overview .chapter}

This chapter discusses goals for tuning, how to identify high-resource SQL statements, explains what should be collected, and provides tuning suggestions.

This chapter contains the following sections:

-   [Introduction to SQL Tuning](#i35699)

-   [Goals for Tuning](#i22038)

-   [Identifying High-Load SQL](#i26072)

-   [Automatic SQL Tuning Features](#i35740)

-   [Developing Efficient SQL Statements](#i30971)

    <div class="infoboxnotealso">

    See Also:

    -   [<span class="italic">Oracle Database Concepts</span>](../../server.102/b14220/sqlplsql.htm#CNCPT015){.olink .CNCPT015} for an overview of SQL

    -   [<span class="italic">Oracle Database 2 Day DBA</span>](../../server.102/b14196/montune.htm#ADMQS010){.olink .ADMQS010} for information on monitoring and tuning the database

    </div>

[](){#i35699}
<div class="sect1">

## <span class="secnum">11.1</span> Introduction to SQL Tuning {#introduction-to-sql-tuning .sect1}

An important facet of database system performance tuning is the tuning of SQL statements. SQL tuning involves three basic steps:

-   Identifying high load or top SQL statements that are responsible for a large share of the application workload and system resources, by reviewing past SQL execution history available in the system.

-   Verifying that the execution plans produced by the query optimizer for these statements perform reasonably.

-   Implementing corrective actions to generate better execution plans for poorly performing SQL statements.

These three steps are repeated until the system performance reaches a satisfactory level or no more statements can be tuned.

</div>

[](){#i22038}
<div class="sect1">

## <span class="secnum">11.2</span> Goals for Tuning {#goals-for-tuning .sect1}

The objective of tuning a system is either to reduce the response time for end users of the system, or to reduce the resources used to process the same work. You can accomplish both of these objectives in several ways:

-   [Reduce the Workload](#i26861)

-   [Balance the Workload](#i26857)

-   [Parallelize the Workload](#i26853)

[](){#i26861}
<div class="sect2">

### <span class="secnum">11.2.1</span> Reduce the Workload {#reduce-the-workload .sect2}

SQL tuning commonly involves finding more efficient ways to process the same workload. It is possible to change the execution plan of the statement without altering the functionality to reduce the resource consumption.

Two examples of how resource usage can be reduced are:

1.  If a commonly executed query needs to access a small percentage of data in the table, then it can be executed more efficiently by using an index. By creating such an index, you reduce the amount of resources used.

2.  If a user is looking at the first twenty rows of the 10,000 rows returned in a specific sort order, and if the query (and sort order) can be satisfied by an index, then the user does not need to access and sort the 10,000 rows to see the first 20 rows.

</div>

[](){#i26857}
<div class="sect2">

### <span class="secnum">11.2.2</span> Balance the Workload {#balance-the-workload .sect2}

Systems often tend to have peak usage in the daytime when real users are connected to the system, and low usage in the nighttime. If noncritical reports and batch jobs can be scheduled to run in the nighttime and their concurrency during day time reduced, then it frees up resources for the more critical programs in the day.

</div>

[](){#i26853}
<div class="sect2">

### <span class="secnum">11.2.3</span> Parallelize the Workload {#parallelize-the-workload .sect2}

Queries that access large amounts of data (typical data warehouse queries) often can be parallelized. This is extremely useful for reducing the response time in low concurrency data warehouse. However, for OLTP environments, which tend to be high concurrency, this can adversely impact other users by increasing the overall resource usage of the program.

</div>

</div>

[](){#i26072}
<div class="sect1">

## <span class="secnum">11.3</span> Identifying High-Load SQL {#identifying-high-load-sql .sect1}

This section describes the steps involved in identifying and gathering data on high-load SQL statements. High-load SQL are poorly-performing, resource-intensive SQL statements that impact the performance of the Oracle database. High-load SQL statements can be identified by:

-   Automatic Database Diagnostic Monitor

-   Automatic Workload Repository

-   `V$SQL` view

-   Custom Workload

-   SQL Trace

<div class="sect2">

[](){#sthref826}
### <span class="secnum">11.3.1</span> Identifying Resource-Intensive SQL {#identifying-resource-intensive-sql .sect2}

The first step in identifying resource-intensive SQL is to categorize the problem you are attempting to fix:

-   Is the problem specific to a single program (or small number of programs)?

-   Is the problem generic over the application?

<div class="sect3">

[](){#sthref827}
#### <span class="secnum">11.3.1.1</span> Tuning a Specific Program {#tuning-a-specific-program .sect3}

If you are tuning a specific program (GUI or 3GL), then identifying the SQL to examine is a simple matter of looking at the SQL executed within the program. Oracle Enterprise Manager provides tools for identifying resource intensive SQL statements, generating explain plans, and evaluating SQL performance.

<div class="infoboxnotealso">

See Also:

-   [<span class="italic">Oracle Enterprise Manager Concepts</span>](../../em.102/b31949/toc.htm){.olink .OEMCN} for information about its capabilities for monitoring and tuning SQL applications

-   [Chapter 12, "Automatic SQL Tuning"](sql_tune.htm#g42443) for information on automatic SQL tuning features

</div>

If it is not possible to identify the SQL (for example, the SQL is generated dynamically), then use `SQL_TRACE` to generate a trace file that contains the SQL executed, then use `TKPROF` to generate an output file.

The SQL statements in the `TKPROF` output file can be ordered by various parameters, such as the execution elapsed time (`exeela`), which usually assists in the identification by ordering the SQL statements by elapsed time (with highest elapsed time SQL statements at the top of the file). This makes the job of identifying the poorly performing SQL easier if there are many SQL statements in the file.

<div class="infoboxnotealso">

See Also:

[Chapter 20, "Using Application Tracing Tools"](sqltrace.htm#g33356)

</div>

</div>

<div class="sect3">

[](){#sthref828}
#### <span class="secnum">11.3.1.2</span> Tuning an Application / Reducing Load {#tuning-an-application-reducing-load .sect3}

If your whole application is performing suboptimally, or if you are attempting to reduce the overall CPU or I/O load on the database server, then identifying resource-intensive SQL involves the following steps:

1.  Determine which period in the day you would like to examine; typically this is the application's peak processing time.

2.  Gather operating system and Oracle statistics at the beginning and end of that period. The minimum of Oracle statistics gathered should be file I/O (`V$FILESTAT`), system statistics (`V$SYSSTAT`), and SQL statistics (`V$SQLAREA`, `V$SQL` or `V$SQLSTATS``, V$SQLTEXT`, `V$SQL_PLAN`, and `V$SQL_PLAN_STATISTICS`).

    <div class="infoboxnotealso">

    See Also:

    [Chapter 6, "Automatic Performance Diagnostics"](diagnsis.htm#g41683) for information on how to use Oracle tools to gather Oracle instance performance data

    </div>

3.  Using the data collected in step two, identify the SQL statements using the most resources. A good way to identify candidate SQL statements is to query `V$SQLSTATS`. `V$SQLSTATS` contains resource usage information for all SQL statements in the shared pool. The data in `V$SQLSTATS` should be ordered by resource usage. The most common resources are:

    -   Buffer gets (`V$SQLSTATS`.`BUFFER_GETS`, for high CPU using statements)

    -   Disk reads (`V$SQLSTATS`.`DISK_READS`, for high I/O statements)

    -   Sorts (`V$SQLSTATS`.`SORTS`, for many sorts)

One method to identify which SQL statements are creating the highest load is to compare the resources used by a SQL statement to the total amount of that resource used in the period. For `BUFFER_GETS`, divide each SQL statement's `BUFFER_GETS` by the total number of buffer gets during the period. The total number of buffer gets in the system is available in the `V$SYSSTAT` table, for the statistic session logical reads.

Similarly, it is possible to apportion the percentage of disk reads a statement performs out of the total disk reads performed by the system by dividing `V$SQL_STATS.DISK_READS` by the value for the `V$SYSSTAT` statistic physical reads. The SQL sections of the Automatic Workload Repository report include this data, so you do not need to perform the percentage calculations manually.

<div class="infoboxnotealso">

See Also:

[<span class="italic">Oracle Database Reference</span>](../../server.102/b14237/dynviews_part.htm#REFRN003){.olink .REFRN003} for information about dynamic performance views

</div>

After you have identified the candidate SQL statements, the next stage is to gather information that is necessary to examine the statements and tune them.

</div>

</div>

<div class="sect2">

[](){#sthref829}
### <span class="secnum">11.3.2</span> Gathering Data on the SQL Identified {#gathering-data-on-the-sql-identified .sect2}

If you are most concerned with CPU, then examine the top SQL statements that performed the most `BUFFER_GETS` during that interval. Otherwise, start with the SQL statement that performed the most `DISK_READS`.

<div class="sect3">

[](){#sthref830}
#### <span class="secnum">11.3.2.1</span> Information to Gather During Tuning {#information-to-gather-during-tuning .sect3}

The tuning process begins by determining the structure of the underlying tables and indexes. The information gathered includes the following:

1.  Complete SQL text from `V$SQLTEXT`

2.  Structure of the tables referenced in the SQL statement, usually by describing the table in SQL\*Plus

3.  Definitions of any indexes (columns, column orderings), and whether the indexes are unique or non-unique

4.  Optimizer statistics for the segments (including the number of rows each table, selectivity of the index columns), including the date when the segments were last analyzed

5.  Definitions of any views referred to in the SQL statement

6.  Repeat steps two, three, and four for any tables referenced in the view definitions found in step five

7.  Optimizer plan for the SQL statement (either from `EXPLAIN` `PLAN`, `V$SQL_PLAN`, or the `TKPROF` output)

8.  Any previous optimizer plans for that SQL statement

    <div class="infobox-note">

    Note:

    It is important to generate and review execution plans for all of the key SQL statements in your application. Doing so lets you compare the optimizer execution plans of a SQL statement when the statement performed well to the plan when that the statement is not performing well. Having the comparison, along with information such as changes in data volumes, can assist in identifying the cause of performance degradation.

    </div>

</div>

</div>

</div>

[](){#i35740}
<div class="sect1">

## <span class="secnum">11.4</span> Automatic SQL Tuning Features {#automatic-sql-tuning-features .sect1}

Because the manual SQL tuning process poses many challenges to the application developer, the SQL tuning process has been automated by the automatic SQL Tuning manageability features. Theses features have been designed to work equally well for OLTP and Data Warehouse type applications. See [Chapter 12, "Automatic SQL Tuning"](sql_tune.htm#g42443).

[](){#sthref831}ADDM

[](){#sthref832}[](){#sthref833}[](){#sthref834}[](){#sthref835}Automatic Database Diagnostic Monitor (ADDM) analyzes the information collected by the AWR for possible performance problems with the Oracle database, including high-load SQL statements. See ["Automatic Database Diagnostic Monitor"](diagnsis.htm#i37241).

[](){#sthref836}SQL Tuning Advisor

[](){#sthref837}[](){#sthref838}SQL Tuning Advisor allows a quick and efficient technique for optimizing SQL statements without modifying any statements. See ["SQL Tuning Advisor"](sql_tune.htm#i34782).

[](){#sthref839}SQL Tuning Sets

When multiple SQL statements are used as input to ADDM or SQL Tuning Advisor, a [](){#sthref840}SQL Tuning Set (STS) is constructed and stored. The STS includes the set of SQL statements along with their associated execution context and basic execution statistics. See ["SQL Tuning Sets"](sql_tune.htm#i34915).

[](){#i35202}SQLAccess Advisor

In addition to the SQL Tuning Advisor, Oracle provides the [](){#sthref841}SQLAccess Advisor that provides advice on materialized views, indexes, and materialized view logs. The SQLAccess Advisor helps you achieve your performance goals by recommending the proper set of materialized views, materialized view logs, and indexes for a given workload. In general, as the number of materialized views and indexes and the space allocated to them is increased, query performance improves. The SQLAccess Advisor considers the trade-offs between space usage and query performance and recommends the most cost-effective configuration of new and existing materialized views and indexes.

[](){#sthref842}[](){#sthref843}To access the SQLAccess Advisor through Oracle Enterprise Manager Database Control:

-   Click the <span class="bold">Advisor</span> <span class="bold">Central</span> link under <span class="bold">Related</span> <span class="bold">Links</span> at the bottom of the <span class="bold">Database</span> pages.

-   On the <span class="bold">Advisor</span> <span class="bold">Central</span> page, you can click the <span class="bold">SQLAccess</span> <span class="bold">Advisor</span> link to analyze a workload source.

See ["Using the SQL Access Advisor"](advisor.htm#i1026391).

</div>

[](){#i30971}
<div class="sect1">

## <span class="secnum">11.5</span> Developing Efficient SQL Statements {#developing-efficient-sql-statements .sect1}

This section describes ways you can improve SQL statement efficiency:

-   [Verifying Optimizer Statistics](#i28375)[Verifying Optimizer Statistics](#i28375)

-   [Reviewing the Execution Plan](#i28403)

-   [Restructuring the SQL Statements](#i28528)

-   [Restructuring the Indexes](#i25277)

-   [Modifying or Disabling Triggers and Constraints](#i22336)

-   [Restructuring the Data](#i22339)

-   [Maintaining Execution Plans Over Time](#i23988)

-   [Visiting Data as Few Times as Possible](#i25211)

    <div class="infobox-note">

    <span class="bold">Note</span>:

    The guidelines described in this section are oriented to production SQL that will be executed frequently. Most of the techniques that are discouraged here can legitimately be employed in ad hoc statements or in applications run infrequently where performance is not critical.

    </div>

[](){#i28375}
<div class="sect2">

### <span class="secnum">11.5.1</span> Verifying Optimizer Statistics {#verifying-optimizer-statistics .sect2}

The query optimizer uses statistics gathered on tables and indexes when determining the optimal execution plan. If these statistics have not been gathered, or if the statistics are no longer representative of the data stored within the database, then the optimizer does not have sufficient information to generate the best plan.

Things to check:

-   If you gather statistics for some tables in your database, then it is probably best to gather statistics for all tables. This is especially true if your application includes SQL statements that perform joins.

-   If the optimizer statistics in the data dictionary are no longer representative of the data in the tables and indexes, then gather new statistics. One way to check whether the dictionary statistics are stale is to compare the real cardinality (row count) of a table to the value of `DBA_TABLES.NUM_ROWS`. Additionally, if there is significant data skew on predicate columns, then consider using histograms.

</div>

[](){#i28403}
<div class="sect2">

### <span class="secnum">11.5.2</span> Reviewing the Execution Plan {#reviewing-the-execution-plan .sect2}

When tuning (or writing) a SQL statement in an OLTP environment, the goal is to drive from the table that has the most selective filter. This means that there are fewer rows passed to the next step. If the next step is a join, then this means that fewer rows are joined. Check to see whether the access paths are optimal.

When examining the optimizer execution plan, look for the following:

-   The plan is such that the driving table has the best filter.

-   The join order in each step means that the fewest number of rows are being returned to the next step (that is, the join order should reflect, where possible, going to the best not-yet-used filters).

-   The join method is appropriate for the number of rows being returned. For example, nested loop joins through indexes may not be optimal when many rows are being returned.

-   Views are used efficiently. Look at the `SELECT` list to see whether access to the view is necessary.

-   There are any unintentional Cartesian products (even with small tables).

-   Each table is being accessed efficiently:

    Consider the predicates in the SQL statement and the number of rows in the table. Look for suspicious activity, such as a full table scans on tables with large number of rows, which have predicates in the where clause. Determine why an index is not used for such a selective predicate.

    A full table scan does not mean inefficiency. It might be more efficient to perform a full table scan on a small table, or to perform a full table scan to leverage a better join method (for example, hash\_join) for the number of rows returned.

If any of these conditions are not optimal, then consider restructuring the SQL statement or the indexes available on the tables.

</div>

[](){#i28528}
<div class="sect2">

### <span class="secnum">11.5.3</span> Restructuring the SQL Statements {#restructuring-the-sql-statements .sect2}

Often, rewriting an inefficient SQL statement is easier than modifying it. If you understand the purpose of a given statement, then you might be able to quickly and easily write a new statement that meets the requirement.

<div class="sect3">

[](){#sthref844}
#### <span class="secnum">11.5.3.1</span> Compose Predicates Using AND and = {#compose-predicates-using-and-and .sect3}

To improve SQL efficiency, use [](){#sthref845}equijoins whenever possible. Statements that perform equijoins on untransformed column values are the easiest to tune.

</div>

[](){#i25024}
<div class="sect3">

#### <span class="secnum">11.5.3.2</span> Avoid Transformed Columns in the WHERE Clause {#avoid-transformed-columns-in-the-where-clause .sect3}

Use [](){#sthref846}untransformed column values. For example, use:

    WHERE a.order_no = b.order_no

rather than:

    WHERE TO_NUMBER (SUBSTR(a.order_no, INSTR(b.order_no, '.') - 1))
    = TO_NUMBER (SUBSTR(a.order_no, INSTR(b.order_no, '.') - 1))

Do not use SQL functions in predicate clauses or `WHERE` clauses. Any expression using a column, such as a function having the column as its argument, causes the optimizer to ignore the possibility of using an index on that column, even a unique index, unless there is a function-based index defined that can be used.

Avoid mixed-mode [](){#sthref847}expressions, and beware of implicit [](){#sthref848}type conversions. When you want to use an index on the `VARCHAR2` column `charcol`, but the `WHERE` clause looks like this:

    AND charcol = numexpr

where `numexpr` is an expression of number type (for example, 1, `USERENV`('`SESSIONID`'), `numcol`, `numcol`+0,...), Oracle translates that expression into:

    AND TO_NUMBER(charcol) = numexpr

Avoid the following kinds of complex expressions:

-   `col1` = `NVL` `(:b1`,`col1)`

-   `NVL` (`col1,-999`) = ….

-   `TO_DATE`(), `TO_NUMBER`(), and so on

These expressions prevent the optimizer from assigning valid cardinality or selectivity estimates and can in turn affect the overall plan and the join method.

Add the predicate versus using `NVL`() technique.

For example:

    SELECT employee_num, full_name Name, employee_id 
      FROM mtl_employees_current_view 
      WHERE (employee_num = NVL (:b1,employee_num)) AND (organization_id=:1) 
      ORDER BY employee_num;

Also:

    SELECT employee_num, full_name Name, employee_id 
      FROM mtl_employees_current_view 
      WHERE (employee_num = :b1) AND (organization_id=:1) 
      ORDER BY employee_num;

When you need to use SQL functions on filters or join predicates, do not use them on the columns on which you want to have an index; rather, use them on the opposite side of the predicate, as in the following statement:

    TO_CHAR(numcol) = varcol

rather than

    varcol = TO_CHAR(numcol)

<div class="infoboxnotealso">

See Also:

[Chapter 15, "Using Indexes and Clusters"](data_acc.htm#g27061) for more information on function-based indexes

</div>

</div>

[](){#i22179}
<div class="sect3">

#### <span class="secnum">11.5.3.3</span> Write Separate SQL Statements for Specific Tasks {#write-separate-sql-statements-for-specific-tasks .sect3}

SQL is not a procedural language. Using one piece of SQL to do many different things usually results in a less-than-optimal result for each task. If you want SQL to accomplish different things, then write various statements, rather than writing one statement to do different things depending on the parameters you give it.

<div class="infobox-note">

Note:

Oracle Forms and Reports are powerful development tools that allow application logic to be coded using PL/SQL (triggers or program units). This helps reduce the complexity of SQL by allowing complex logic to be handled in the Forms or Reports. You can also invoke a server side PL/SQL package that performs the few SQL statements in place of a single large complex SQL statement. Because the package is a server-side unit, there are no issues surrounding client to database round-trips and network traffic.

</div>

It is always better to write separate SQL statements for different tasks, but if you must use one SQL statement, then you can make a very complex statement slightly less complex by using the `UNION` `ALL` operator.

Optimization (determining the execution plan) takes place before the database knows what values will be substituted into the query. An execution plan cannot, therefore, depend on what those values are. For example:

    SELECT info 
    FROM tables
    WHERE ... 

    AND somecolumn BETWEEN DECODE(:loval, 'ALL', somecolumn, :loval)
    AND DECODE(:hival, 'ALL', somecolumn, :hival);

Written as shown, the database cannot use an index on the `somecolumn` column, because the expression involving that column uses the same column on both sides of the `BETWEEN`.

This is not a problem if there is some other highly selective, indexable condition you can use to access the driving table. Often, however, this is not the case. Frequently, you might want to use an index on a condition like that shown but need to know the values of :`loval`, and so on, in advance. With this information, you can rule out the `ALL` case, which should not use the index.

If you want to use the index whenever real values are given for :`loval` and :`hival` (if you expect narrow ranges, even ranges where :`loval` often equals :`hival`), then you can rewrite the example in the following logically equivalent form:

    SELECT /* change this half of UNION ALL if other half changes */ info
    FROM tables 
    WHERE ... 

    AND somecolumn BETWEEN :loval AND :hival
    AND (:hival != 'ALL' AND :loval != 'ALL') 

    UNION ALL 
    SELECT /* Change this half of UNION ALL if other half changes. */ info
    FROM tables
    WHERE ... 

    AND (:hival = 'ALL' OR :loval = 'ALL');

If you run `EXPLAIN` `PLAN` on the new query, then you seem to get both a desirable and an undesirable execution plan. However, the first condition the database evaluates for either half of the `UNION` `ALL` is the combined condition on whether `:hival` and `:loval` are `ALL`. The database evaluates this condition before actually getting any rows from the execution plan for that part of the query.

When the condition comes back false for one part of the `UNION` `ALL` query, that part is not evaluated further. Only the part of the execution plan that is optimum for the values provided is actually carried out. Because the final conditions on `:hival` and `:loval` are guaranteed to be mutually exclusive, only one half of the `UNION` `ALL` actually returns rows. (The `ALL` in `UNION` `ALL` is logically valid because of this exclusivity. It allows the plan to be carried out without an expensive sort to rule out duplicate rows for the two halves of the query.)

</div>

[](){#i36215}
<div class="sect3">

#### <span class="secnum">11.5.3.4</span> Use of EXISTS versus IN for Subqueries {#use-of-exists-versus-in-for-subqueries .sect3}

In certain circumstances, it is better to use `IN` rather than `EXISTS`. In general, if the selective predicate is in the subquery, then use `IN`. If the selective predicate is in the parent query, then use `EXISTS`.

<div class="infobox-note">

<span class="bold">Note</span>:

This discussion is most applicable in an OLTP environment, where the access paths either to the parent SQL or subquery are through indexed columns with high selectivity. In a DSS environment, there can be low selectivity in the parent SQL or subquery, and there might not be any indexes on the join columns. In a DSS environment, consider using semijoins for the `EXISTS` case.

</div>

<div class="infoboxnotealso">

See Also:

[<span class="italic">Oracle Database Data Warehousing Guide</span>](../b14223/toc.htm){.olink .DWHSG}

</div>

Sometimes, Oracle can rewrite a subquery when used with an `IN` clause to take advantage of selectivity specified in the subquery. This is most beneficial when the most selective filter appears in the subquery and there are indexes on the join columns. Conversely, using `EXISTS` is beneficial when the most selective filter is in the parent query. This allows the selective predicates in the parent query to be applied before filtering the rows against the `EXISTS` criteria.

<div class="infobox-note">

Note:

You should verify the optimizer cost of the statement with the actual number of resources used (`BUFFER_GETS`, `DISK_READS`, `CPU_TIME` from `V$SQL`STATS or `V$SQLAREA`). Situations such as data skew (without the use of histograms) can adversely affect the optimizer's estimated cost for an operation.

</div>

["Example 1: Using IN - Selective Filters in the Subquery"](#i36000) and ["Example 2: Using EXISTS - Selective Predicate in the Parent"](#i36004) are two examples that demonstrate the benefits of `IN` and `EXISTS`. Both examples use the same schema with the following characteristics:

-   There is a unique index on the `employees`.`employee_id` field.

-   There is an index on the `orders`.`customer_id` field.

-   There is an index on the `employees`.`department_id` field.

-   The `employees` table has 27,000 rows.

-   The `orders` table has 10,000 rows.

-   The `OE` and `HR` schemas, which own these segments, were both analyzed with `COMPUTE`.

[](){#i36000}
<div class="sect4">

##### <span class="secnum">11.5.3.4.1</span> Example 1: Using IN - Selective Filters in the Subquery {#example-1-using-in---selective-filters-in-the-subquery .sect4}

This example demonstrates how rewriting a query to use `IN` can improve performance. This query identifies all employees who have placed orders on behalf of customer 144.

The following SQL statement uses `EXISTS`:

    SELECT /* EXISTS example */
             e.employee_id, e.first_name, e.last_name, e.salary
      FROM employees e
     WHERE EXISTS (SELECT 1 FROM orders o                  /* Note 1 */
                      WHERE e.employee_id = o.sales_rep_id   /* Note 2 */
                        AND o.customer_id = 144);            /* Note 3 */

<div class="infobox-note">

Notes:

-   Note 1: This shows the line containing `EXISTS`.

-   Note 2: This shows the line that makes the subquery a correlated subquery.

-   Note 3: This shows the line where the correlated subqueries include the highly selective predicate `customer_id` = `number`.

</div>

The following plan output is the execution plan (from `V$SQL_PLAN`) for the preceding statement. The plan requires a full table scan of the `employees` table, returning many rows. Each of these rows is then filtered against the `orders` table (through an index).

      ID OPERATION            OPTIONS         OBJECT_NAME            OPT       COST
    ---- -------------------- --------------- ---------------------- --- ----------
       0 SELECT STATEMENT                                            CHO
       1  FILTER
       2   TABLE ACCESS       FULL            EMPLOYEES              ANA        155
       3   TABLE ACCESS       BY INDEX ROWID  ORDERS                 ANA          3
       4    INDEX             RANGE SCAN      ORD_CUSTOMER_IX        ANA          1

Rewriting the statement using `IN` results in significantly fewer resources used.

The SQL statement using `IN`:

      SELECT /* IN example */
             e.employee_id, e.first_name, e.last_name, e.salary
        FROM employees e
       WHERE e.employee_id IN (SELECT o.sales_rep_id         /* Note 4 */
                                 FROM orders o
                                WHERE o.customer_id = 144);  /* Note 3 */

<div class="infobox-note">

Note:

-   Note 3: This shows the line where the correlated subqueries include the highly selective predicate `customer_id` = `number`

-   Note 4: This indicates that an `IN` is being used. The subquery is no longer correlated, because the `IN` clause replaces the join in the subquery.

</div>

The following plan output is the execution plan (from `V$SQL_PLAN`) for the preceding statement. The optimizer rewrites the subquery into a view, which is then joined through a unique index to the `employees` table. This results in a significantly better plan, because the view (that is, subquery) has a selective predicate, thus returning only a few `employee_ids`. These `employee_ids` are then used to access the `employees` table through the unique index.

      ID OPERATION            OPTIONS         OBJECT_NAME            OPT       COST
    ---- -------------------- --------------- ---------------------- --- ----------
       0 SELECT STATEMENT                                            CHO
       1  NESTED LOOPS                                                            5
       2   VIEW                                                                   3
       3    SORT              UNIQUE                                              3
       4     TABLE ACCESS     FULL            ORDERS                 ANA          1
       5   TABLE ACCESS       BY INDEX ROWID  EMPLOYEES              ANA          1
       6    INDEX             UNIQUE SCAN     EMP_EMP_ID_PK          ANA

</div>

[](){#i36004}
<div class="sect4">

##### <span class="secnum">11.5.3.4.2</span> Example 2: Using EXISTS - Selective Predicate in the Parent {#example-2-using-exists---selective-predicate-in-the-parent .sect4}

This example demonstrates how rewriting a query to use `EXISTS` can improve performance. This query identifies all employees from department 80 who are sales reps who have placed orders.

The following SQL statement uses `IN`:

      SELECT /* IN example */
             e.employee_id, e.first_name, e.last_name, e.department_id, e.salary
        FROM employees e
       WHERE e.department_id = 80                                    /* Note 5 */
         AND e.job_id        = 'SA_REP'                              /* Note 6 */
         AND e.employee_id IN (SELECT o.sales_rep_id FROM orders o); /* Note 4 */

<div class="infobox-note">

Note:

-   Note 4: This indicates that an `IN` is being used. The subquery is no longer correlated, because the `IN` clause replaces the join in the subquery.

-   Note 5 and 6: These are the selective predicates in the parent SQL.

</div>

The following plan output is the execution plan (from `V$SQL_PLAN`) for the preceding statement. The SQL statement was rewritten by the optimizer to use a view on the `orders` table, which requires sorting the data to return all unique `employee_ids` existing in the `orders` table. Because there is no predicate, many `employee_ids` are returned. The large list of resulting `employee_ids` are then used to access the `employees` table through the unique index.

      ID OPERATION            OPTIONS         OBJECT_NAME            OPT       COST
    ---- -------------------- --------------- ---------------------- --- ----------
       0 SELECT STATEMENT                                            CHO
       1  NESTED LOOPS                                                          125
       2   VIEW                                                                 116
       3    SORT              UNIQUE                                            116
       4     TABLE ACCESS     FULL            ORDERS                 ANA         40
       5   TABLE ACCESS       BY INDEX ROWID  EMPLOYEES              ANA          1
       6    INDEX             UNIQUE SCAN     EMP_EMP_ID_PK          ANA

The following SQL statement uses `EXISTS`:

      SELECT /* EXISTS example */
             e.employee_id, e.first_name, e.last_name, e.salary
        FROM employees e
       WHERE e.department_id = 80                           /* Note 5 */
         AND e.job_id        = 'SA_REP'                     /* Note 6 */
         AND EXISTS (SELECT 1                               /* Note 1 */
                       FROM orders o
                      WHERE e.employee_id = o.sales_rep_id);  /* Note 2 */

<div class="infobox-note">

Note:

-   Note 1: This shows the line containing `EXISTS`.

-   Note 2: This shows the line that makes the subquery a correlated subquery.

-   Note 5 & 6:These are the selective predicates in the parent SQL.

</div>

The following plan output is the execution plan (from `V$SQL_PLAN`) for the preceding statement. The cost of the plan is reduced by rewriting the SQL statement to use an `EXISTS`. This plan is more effective, because two indexes are used to satisfy the predicates in the parent query, thus returning only a few `employee_ids`. The `employee_ids` are then used to access the `orders` table through an index.

      ID OPERATION            OPTIONS         OBJECT_NAME            OPT       COST
    ---- -------------------- --------------- ---------------------- --- ----------
       0 SELECT STATEMENT                                            CHO
       1  FILTER
       2   TABLE ACCESS       BY INDEX ROWID  EMPLOYEES              ANA         98
       3    AND-EQUAL
       4     INDEX            RANGE SCAN      EMP_JOB_IX             ANA
       5     INDEX            RANGE SCAN      EMP_DEPARTMENT_IX      ANA
       6   INDEX              RANGE SCAN      ORD_SALES_REP_IX       ANA          8

<div class="infobox-note">

Note:

An even more efficient approach is to have a concatenated index on `department_id` and `job_id`. This eliminates the need to access two indexes and reduces the resources used.

</div>

</div>

</div>

</div>

[](){#i22206}
<div class="sect2">

### <span class="secnum">11.5.4</span> Controlling the Access Path and Join Order with Hints {#controlling-the-access-path-and-join-order-with-hints .sect2}

You can influence the optimizer's choices by setting the optimizer approach and goal, and by gathering representative statistics for the query optimizer. Sometimes, the application designer, who has more information about a particular application's data than is available to the optimizer, can choose a more effective way to execute a SQL statement. You can use hints in SQL statements to instruct the optimizer about how the statement should be executed.

[](){#sthref849}Hints, such as /\*+`FULL` \*/ control access paths. For example:

    SELECT /*+ FULL(e) */ e.last_name
      FROM employees e
     WHERE e.job_id = 'CLERK';

<div class="infoboxnotealso">

<span class="bold">See Also</span>:

[Chapter 13, "The Query Optimizer"](optimops.htm#g92116) and [Chapter 16, "Using Optimizer Hints"](hintsref.htm#i8327)

</div>

[](){#sthref850}[](){#sthref851}Join order can have a significant effect on performance. The main objective of SQL tuning is to avoid performing unnecessary work to access rows that do not affect the result. This leads to three general rules:

-   Avoid a full-table scan if it is more efficient to get the required rows through an index.

-   Avoid using an index that fetches 10,000 rows from the driving table if you could instead use another index that fetches 100 rows.

-   Choose the join order so as to join fewer rows to tables later in the join order.

The following example shows how to tune join order effectively:

    SELECT info
    FROM taba a, tabb b, tabc c
    WHERE a.acol BETWEEN 100 AND 200

    AND b.bcol BETWEEN 10000 AND 20000
    AND c.ccol BETWEEN 10000 AND 20000
    AND a.key1 = b.key1
    AND a.key2 = c.key2;

1.  Choose the driving table and the driving index (if any).

    The first three conditions in the previous example are filter conditions applying to only a single table each. The last two conditions are join conditions.

    Filter conditions dominate the choice of driving table and index. In general, the driving table is the one containing the filter condition that eliminates the highest percentage of the table. Thus, because the range of 100 to 200 is narrow compared with the range of `acol`, but the ranges of 10000 and 20000 are relatively large, `taba` is the driving table, all else being equal.

    With nested loop joins, the joins all happen through the join indexes, the indexes on the primary or foreign keys used to connect that table to an earlier table in the join tree. Rarely do you use the indexes on the non-join conditions, except for the driving table. Thus, after `taba` is chosen as the driving table, use the indexes on `b`.`key1` and `c`.`key2` to drive into `tabb` and `tabc`, respectively.

2.  Choose the best [](){#sthref852}join order, driving to the best unused filters earliest.

    The work of the following join can be reduced by first joining to the table with the best still-unused filter. Thus, if "`bcol` `BETWEEN` ..." is more restrictive (rejects a higher percentage of the rows seen) than "`ccol` `BETWEEN` ...", the last join can be made easier (with fewer rows) if `tabb` is joined before `tabc`.

3.  You can use the `ORDERED` or `STAR` hint to force the join order.

    <div class="infoboxnotealso">

    See Also:

    ["Hints for Join Orders"](hintsref.htm#CHDGGCHC)

    </div>

<div class="sect3">

[](){#sthref853}
#### <span class="secnum">11.5.4.1</span> Use Caution When Managing Views {#use-caution-when-managing-views .sect3}

Be careful when joining views, when performing [](){#sthref854}outer joins to views, and when reusing an existing view for a new purpose.

[](){#i22260}
<div class="sect4">

##### <span class="secnum">11.5.4.1.1</span> Use Caution When Joining Complex Views {#use-caution-when-joining-complex-views .sect4}

Joins to complex views are not recommended, particularly joins from one complex view to another. Often this results in the entire view being instantiated, and then the query is run against the view data.

For example, the following statement creates a view that lists employees and departments:

    CREATE OR REPLACE VIEW emp_dept
    AS
    SELECT d.department_id, d.department_name, d.location_id,
         e.employee_id, e.last_name, e.first_name, e.salary, e.job_id
    FROM  departments d
         ,employees e
    WHERE e.department_id (+) = d.department_id;

The following query finds employees in a specified state:

    SELECT v.last_name, v.first_name, l.state_province
      FROM locations l, emp_dept v
     WHERE l.state_province = 'California'
      AND   v.location_id = l.location_id (+);

In the following plan table output, note that the `emp_dept` view is instantiated:

    --------------------------------------------------------------------------------
    | Operation                 |  Name    |  Rows | Bytes|  Cost  | Pstart| Pstop |
    --------------------------------------------------------------------------------
    | SELECT STATEMENT          |          |       |      |        |       |       |
    |  FILTER                   |          |       |      |        |       |       |
    |   NESTED LOOPS OUTER      |          |       |      |        |       |       |
    |    VIEW                   |EMP_DEPT  |       |      |        |       |       |
    |     NESTED LOOPS OUTER    |          |       |      |        |       |       |
    |      TABLE ACCESS FULL    |DEPARTMEN |       |      |        |       |       |
    |      TABLE ACCESS BY INDEX|EMPLOYEES |       |      |        |       |       |
    |       INDEX RANGE SCAN    |EMP_DEPAR |       |      |        |       |       |
    |    TABLE ACCESS BY INDEX R|LOCATIONS |       |      |        |       |       |
    |     INDEX UNIQUE SCAN     |LOC_ID_PK |       |      |        |       |       |
    --------------------------------------------------------------------------------

</div>

[](){#i24836}
<div class="sect4">

##### <span class="secnum">11.5.4.1.2</span> Do Not Recycle Views {#do-not-recycle-views .sect4}

Beware of writing a view for one purpose and then using it for other purposes to which it might be ill-suited. Querying from a view requires all tables from the view to be accessed for the data to be returned. Before reusing a view, determine whether all tables in the view need to be accessed to return the data. If not, then do not use the view. Instead, use the base table(s), or if necessary, define a new view. The goal is to refer to the minimum number of tables and views necessary to return the required data.

Consider the following example:

    SELECT department_name 
    FROM emp_dept
    WHERE department_id = 10;

The entire view is first instantiated by performing a join of the `employees` and `departments` tables and then aggregating the data. However, you can obtain `department_name` and `department_id` directly from the `departments` table. It is inefficient to obtain this information by querying the `emp_dept` view.

</div>

[](){#i22276}
<div class="sect4">

##### <span class="secnum">11.5.4.1.3</span> Use Caution When Unnesting Subque[](){#sthref855}ries {#use-caution-when-unnesting-subqueries .sect4}

Subquery unnesting merges the body of the subquery into the body of the statement that contains it, allowing the optimizer to consider them together when evaluating access paths and joins.

<div class="infoboxnotealso">

See Also:

[<span class="italic">Oracle Database Data Warehousing Guide</span>](../b14223/toc.htm){.olink .DWHSG} for an explanation of the dangers with subquery unnesting

</div>

</div>

[](){#i22299}
<div class="sect4">

##### <span class="secnum">11.5.4.1.4</span> Use Caution When Performing Outer Joins to Views {#use-caution-when-performing-outer-joins-to-views .sect4}

In the case of an outer join to a multi-table view, the query optimizer (in Release 8.1.6 and later) can drive from an outer join column, if an equality predicate is defined on it.

An outer join <span class="italic">within</span> a view is problematic because the performance implications of the outer join are not visible.

</div>

</div>

<div class="sect3">

[](){#sthref856}
#### <span class="secnum">11.5.4.2</span> Store Intermediate Results {#store-intermediate-results .sect3}

Intermediate, or staging, tables are quite common in relational database systems, because they temporarily store some intermediate results. In many applications they are useful, but Oracle requires additional resources to create them. Always consider whether the benefit they could bring is more than the cost to create them. Avoid staging tables when the information is not reused multiple times.

Some additional considerations:

-   Storing intermediate results in staging tables could improve application performance. In general, whenever an intermediate result is usable by multiple following queries, it is worthwhile to store it in a staging table. The benefit of not retrieving data multiple times with a complex statement already at the second usage of the intermediate result is better than the cost to materialize it.

-   Long and complex queries are hard to understand and optimize. Staging tables can break a complicated SQL statement into several smaller statements, and then store the result of each step.

-   Consider using materialized views. These are precomputed tables comprising aggregated or joined data from fact and possibly dimension tables.

    <div class="infoboxnotealso">

    See Also:

    [<span class="italic">Oracle Database Data Warehousing Guide</span>](../b14223/toc.htm){.olink .DWHSG} for detailed information on using materialized views

    </div>

</div>

</div>

[](){#i25277}
<div class="sect2">

### <span class="secnum">11.5.5</span> Restructuring the Indexes {#restructuring-the-indexes .sect2}

Often, there is a beneficial impact on performance by restructuring indexes. This can involve the following:

-   Remove nonselective indexes to speed the DML.

-   Index performance-critical access paths.

-   Consider reordering columns in existing concatenated indexes.

-   Add columns to the index to improve selectivity.

[](){#i25283}Do not use indexes as a panacea. Application developers sometimes think that performance will improve if they create more indexes. If a single programmer creates an appropriate index, then this might indeed improve the application's performance. However, if 50 programmers each create an index, then application performance will probably be hampered.

</div>

[](){#i22336}
<div class="sect2">

### <span class="secnum">11.5.6</span> Modifying or Disabling Triggers and Constraints {#modifying-or-disabling-triggers-and-constraints .sect2}

Using triggers consumes system resources. If you use too many triggers, then you can find that performance is adversely affected and you might need to modify or disable them.

</div>

[](){#i22339}
<div class="sect2">

### <span class="secnum">11.5.7</span> Restructuring the Data {#restructuring-the-data .sect2}

After restructuring the indexes and the statement, you can consider restructuring the data.

-   Introduce derived values. Avoid `GROUP` `BY` in response-critical code.

-   Review your data design. Change the design of your system if it can improve performance.

-   Consider partitioning, if appropriate.

</div>

[](){#i23988}
<div class="sect2">

### <span class="secnum">11.5.8</span> Maintaining Execution Plans Over Time {#maintaining-execution-plans-over-time .sect2}

You can maintain the existing execution plan of SQL statements over time either using stored statistics or stored SQL execution plans. Storing optimizer statistics for tables will apply to all SQL statements that refer to those tables. Storing an execution plan (that is, plan stability) maintains the plan for a single SQL statement. If both statistics and a stored plan are available for a SQL statement, then the optimizer uses the stored plan.

<div class="infoboxnotealso">

See Also:

-   [Chapter 14, "Managing Optimizer Statistics"](stats.htm#g49431)

-   [Chapter 18, "Using Plan Stability"](outlines.htm#g35579)

</div>

</div>

[](){#i25211}
<div class="sect2">

### <span class="secnum">11.5.9</span> Visiting Data as Few Times as Possible {#visiting-data-as-few-times-as-possible .sect2}

Applications should try to access each row only once. This reduces network traffic and reduces database load. Consider doing the following:

-   [Combine Multiples Scans with CASE Statements](#i26629)

-   [Use DML with RETURNING Clause](#i26634)

-   [Modify All the Data Needed in One Statement](#i25629)

[](){#i26629}
<div class="sect3">

#### <span class="secnum">11.5.9.1</span> Combine Multiples Scans with CASE Statements {#combine-multiples-scans-with-case-statements .sect3}

Often, it is necessary to calculate different aggregates on various sets of tables. Usually, this is done with multiple scans on the table, but it is easy to calculate all the aggregates with one single scan. Eliminating n-1 scans can greatly improve performance.

Combining multiple scans into one scan can be done by moving the `WHERE` condition of each scan into a `CASE` statement, which filters the data for the aggregation. For each aggregation, there could be another column that retrieves the data.

The following example asks for the count of all employees who earn less then 2000, between 2000 and 4000, and more than 4000 each month. This can be done with three separate queries:

    SELECT COUNT (*)
      FROM employees
      WHERE salary < 2000;

    SELECT COUNT (*)
      FROM employees
      WHERE salary BETWEEN 2000 AND 4000;

    SELECT COUNT (*)
      FROM employees
      WHERE salary>4000;

However, it is more efficient to run the entire query in a single statement. Each number is calculated as one column. The count uses a filter with the `CASE` statement to count only the rows where the condition is valid. For example:

    SELECT COUNT (CASE WHEN salary < 2000 
                       THEN 1 ELSE null END) count1, 
           COUNT (CASE WHEN salary BETWEEN 2001 AND 4000 
                       THEN 1 ELSE null END) count2, 
           COUNT (CASE WHEN salary > 4000 
                       THEN 1 ELSE null END) count3 
      FROM employees; 

This is a very simple example. The ranges could be overlapping, the functions for the aggregates could be different, and so on.

</div>

[](){#i26634}
<div class="sect3">

#### <span class="secnum">11.5.9.2</span> Use DML with RETURNING Clause {#use-dml-with-returning-clause .sect3}

When appropriate, use `INSERT`, `UPDATE`, or `DELETE`... `RETURNING` to select and modify data with a single call. This technique improves performance by reducing the number of calls to the database.

<div class="infoboxnotealso">

<span class="bold">See Also</span>:

[<span class="italic">Oracle Database SQL Language Reference</span>](../b14200/toc.htm){.olink .SQLRF} for syntax on the `INSERT`, `UPDATE`, and `DELETE` statements

</div>

</div>

[](){#i25629}
<div class="sect3">

#### <span class="secnum">11.5.9.3</span> Modify All the Data Needed in One Statement {#modify-all-the-data-needed-in-one-statement .sect3}

When possible, use array processing. This means that an array of bind variable values is passed to Oracle for repeated execution. This is appropriate for iterative processes in which multiple rows of a set are subject to the same operation.

For example:

    BEGIN
     FOR pos_rec IN (SELECT * 
       FROM order_positions 
       WHERE order_id = :id) LOOP
          DELETE FROM order_positions
          WHERE order_id = pos_rec.order_id AND
            order_position = pos_rec.order_position;
     END LOOP;
     DELETE FROM orders 
     WHERE order_id = :id;
    END;

Alternatively, you could define a cascading constraint on `orders`. In the previous example, one `SELECT` and <span class="italic">n</span> `DELETE`s are executed. When a user issues the `DELETE` on `orders` `DELETE` `FROM` `orders` `WHERE` `order_id` = `:id`, the database automatically deletes the positions with a single `DELETE` statement.

<div class="infoboxnotealso">

See Also:

[<span class="italic">Oracle Database Administrator's Guide</span>](../b14231/toc.htm){.olink .ADMIN} or [<span class="italic">Oracle Database Heterogeneous Connectivity User's Guide</span>](../b14232/toc.htm){.olink .HETER} for information on tuning distributed queries

</div>

</div>

</div>

</div>

<div id="bar3" class="border-top glyph" style="position: relative; text-align: center;">

<span style="position: absolute; left: 8px; top: 8px;">[<span class="JetFW-caret-w_16"></span><span class="hide-mobile-inline">Previous Page</span>](https://docs.oracle.com/cd/B19306_01/server.102/b14211/part4.htm "Go to previous page")</span>
<div>

Page 19 of 33

</div>

<span style="position: absolute; right: 8px; top: 8px;">[<span class="hide-mobile-inline">Next Page</span><span class="JetFW-caret-e_16"></span>](https://docs.oracle.com/cd/B19306_01/server.102/b14211/sql_tune.htm "Go to next page")</span>

</div>

</div>
