<div class="header">

<div class="zz-skip-header">

[[#BEGIN|Skip Headers]]

</div>
{|
|width="50%"| '''Oracle® Database Performance Tuning Guide<br />
11''g'' Release 2 (11.2)'''<br />
Part Number E16638-05
|width="50%"|
{|
| [[../../index.htm|[[File:../../dcommon/gifs/doclib.gif|24x24px|Go to Documentation Home]]<br />
<span class="icon">Home</span>]]
| [[../../nav/portal_booklist.htm|[[File:../../dcommon/gifs/booklist.gif|24x24px|Go to Book List]]<br />
<span class="icon">Book List</span>]]
| [[toc.htm|[[File:../../dcommon/gifs/toc.gif|24x24px|Go to Table of Contents]]<br />
<span class="icon">Contents</span>]]
| [[index.htm|[[File:../../dcommon/gifs/index.gif|24x24px|Go to Index]]<br />
<span class="icon">Index</span>]]
| [[../../dcommon/html/feedback.htm|[[File:../../dcommon/gifs/feedbck2.gif|24x24px|Go to Feedback page]]<br />
<span class="icon">Contact Us</span>]]
|}
|}


-----

{|
|width="50%"|
{|
| [[optplanmgmt.htm|[[File:../../dcommon/gifs/leftnav.gif|24x24px|Go to previous page]]<br />
<span class="icon">Previous</span>]]
| [[sql_tune.htm|[[File:../../dcommon/gifs/rightnav.gif|24x24px|Go to next page]]<br />
<span class="icon">Next</span>]]
|}
|width="50%"| [[../e16638.pdf|PDF]] · [[../E16638-05.mobi|Mobi]] · [[../E16638-05.epub|ePub]]
|}

[[|]]

</div>
<div class="IND">

[[|]][[|]]
= <span class="secnum">16</span> SQL Tuning Overview =

This chapter discusses goals for tuning, how to identify high-resource SQL statements, explains what should be collected, provides tuning suggestions, and discusses how to create SQL test cases to troubleshoot problems in SQL.

This chapter contains the following sections:

* [[#i35699|Introduction to SQL Tuning]]
* [[#i22038|Goals for Tuning]]
* [[#i26072|Identifying High-Load SQL]]
* [[#i35740|Automatic SQL Tuning Features]]
* [[#i30971|Developing Efficient SQL Statements]]
* [[#CEGFAHGI|Building SQL Test Cases]]

<div class="infoboxnotealso">

See Also:

* [http://www.oracle.com/pls/topic/lookup?ctx=E25178-01&id=CNCPT015 <span class="italic">Oracle Database Concepts</span>] for an overview of SQL
* [[../../server.1111/e10897/montune.htm#ADMQS010|<span class="italic">Oracle Database 2 Day DBA</span>]] to learn how to monitor the database


</div>
[[|]][[|]]
<div class="sect1">

== <span class="secnum">16.1</span> Introduction to SQL Tuning ==

SQL tuning involves the following basic steps:

* Identifying high load or top SQL statements that are responsible for a large share of the application workload and system resources, by reviewing past SQL execution history available in the system
* Verifying that the execution plans produced by the query optimizer for these statements perform reasonably
* Implementing corrective actions to generate better execution plans for poorly performing SQL statements

The previous steps are repeated until the system performance reaches a satisfactory level or no more statements can be tuned.


</div>
[[|]][[|]]
<div class="sect1">

== <span class="secnum">16.2</span> Goals for Tuning ==

The objective of tuning a system is either to reduce the response time for end users of the system, or to reduce the resources used to process the same work. You can accomplish both of these objectives in several ways:

* [[#i26861|Reduce the Workload]]
* [[#i26857|Balance the Workload]]
* [[#i26853|Parallelize the Workload]]

[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.2.1</span> Reduce the Workload ===

SQL tuning commonly involves finding more efficient ways to process the same workload. It is possible to change the execution plan of the statement without altering the functionality to reduce the resource consumption.

Two examples of how you can resource usage are as follows:

# If a commonly executed query must access a small percentage of data in the table, then the database can execute it more efficiently by using an index. By creating such an index, you reduce the amount of resources used.
# If a user is looking at the first twenty rows of the 10,000 rows returned in a specific sort order, and if the query (and sort order) can be satisfied by an index, then the user does not need to access and sort the 10,000 rows to see the first 20 rows.


</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.2.2</span> Balance the Workload ===

Systems often tend to have peak usage in the daytime when real users are connected to the system, and low usage in the nighttime. If you can schedule noncritical reports and batch jobs to run in the nighttime and reduce their concurrency during day time, then the database frees up resources for the more critical programs in the day.


</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.2.3</span> Parallelize the Workload ===

Queries that access large amounts of data (typical data warehouse queries) can often run in parallel. Parallelism is extremely useful for reducing response time in a low concurrency data warehouse. However, for OLTP environments, which tend to be high concurrency, parallelism can adversely impact other users by increasing the overall resource usage of the program.


</div>

</div>
[[|]][[|]]
<div class="sect1">

== <span class="secnum">16.3</span> Identifying High-Load SQL ==

This section describes the steps involved in identifying and gathering data on high-load SQL statements. High-load SQL are poorly-performing, resource-intensive SQL statements that impact the performance of an Oracle database. The following tools can identify high-load SQL statements:

* Automatic Database Diagnostic Monitor
* Automatic SQL tuning
* Automatic Workload Repository
* <code>V$SQL</code> view
* Custom Workload
* SQL Trace

[[|]]
<div class="sect2">

[[|]]
=== <span class="secnum">16.3.1</span> Identifying Resource-Intensive SQL ===

The first step in identifying resource-intensive SQL is to categorize the problem you are attempting to fix:

* Is the problem specific to a single program (or small number of programs)?
* Is the problem generic over the application?

[[|]]
<div class="sect3">

[[|]]
==== <span class="secnum">16.3.1.1</span> Tuning a Specific Program ====

If you are tuning a specific program (GUI or 3GL), then identifying the SQL to examine is a simple matter of looking at the SQL executed within the program. Oracle Enterprise Manager provides tools for identifying resource intensive SQL statements, generating explain plans, and evaluating SQL performance.

If it is not possible to identify the SQL (for example, the SQL is generated dynamically), then use <code>SQL_TRACE</code> to generate a trace file that contains the SQL executed, then use <code>TKPROF</code> to generate an output file.

The SQL statements in the <code>TKPROF</code> output file can be ordered by various parameters, such as the execution elapsed time (<code>exeela</code>), which usually assists in the identification by ordering the SQL statements by elapsed time (with highest elapsed time SQL statements at the top of the file). This makes the job of identifying the poorly performing SQL easier if there are many SQL statements in the file.

<div class="infoboxnotealso">

See Also:

* [[sqltrace.htm#g33356|Chapter 21, &quot;Using Application Tracing Tools&quot;]]
* [[sql_tune.htm#g42443|Chapter 17, &quot;Automatic SQL Tuning&quot;]]


</div>

</div>
[[|]]
<div class="sect3">

[[|]]
==== <span class="secnum">16.3.1.2</span> Tuning an Application / Reducing Load ====

If the whole application is performing poorly, or if you are attempting to reduce the overall CPU or I/O load on the database server, then identifying resource-intensive SQL involves the following steps:

<ol>
<li><p>Determine which period in the day you would like to examine; typically this is the application's peak processing time.</p></li>
<li><p>Gather operating system and Oracle Database statistics at the beginning and end of that period. The minimum of Oracle Database statistics gathered should be file I/O (<code>V$FILESTAT</code>), system statistics (<code>V$SYSSTAT</code>), and SQL statistics (<code>V$SQLAREA</code>, <code>V$SQL</code>, or <code>V$SQLSTATS</code>, <code>V$SQLTEXT</code>, <code>V$SQL_PLAN</code>, and <code>V$SQL_PLAN_STATISTICS</code>).</p>
<div class="infoboxnotealso">

<p>See Also:</p>
<ul>
<li><p>[[diag.htm#g41683|Chapter 6, &quot;Automatic Performance Diagnostics&quot;]] to learn how to gather Oracle database instance performance data</p></li>
<li><p>[[instance_tune.htm#CACGEEIF|&quot;Real-Time SQL Monitoring&quot;]] for information about the <code>V$SQL_PLAN_MONITOR</code> view</p></li></ul>


</div></li>
<li><p>Using the data collected in step two, identify the SQL statements using the most resources. A good way to identify candidate SQL statements is to query <code>V$SQLSTATS</code>. <code>V$SQLSTATS</code> contains resource usage information for all SQL statements in the shared pool. The data in <code>V$SQLSTATS</code> should be ordered by resource usage. The most common resources are:</p>
<ul>
<li><p>Buffer gets (<code>V$SQLSTATS</code>.<code>BUFFER_GETS</code>, for high CPU using statements)</p></li>
<li><p>Disk reads (<code>V$SQLSTATS</code>.<code>DISK_READS</code>, for high I/O statements)</p></li>
<li><p>Sorts (<code>V$SQLSTATS</code>.<code>SORTS</code>, for many sorts)</p></li></ul>
</li></ol>

One method to identify which SQL statements are creating the highest load is to compare the resources used by a SQL statement to the total amount of that resource used in the period. For <code>BUFFER_GETS</code>, divide each SQL statement's <code>BUFFER_GETS</code> by the total number of buffer gets during the period. The total number of buffer gets in the system is available in the <code>V$SYSSTAT</code> table, for the statistic session logical reads.

Similarly, it is possible to apportion the percentage of disk reads a statement performs out of the total disk reads performed by the system by dividing <code>V$SQL_STATS.DISK_READS</code> by the value for the <code>V$SYSSTAT</code> statistic physical reads. The SQL sections of the Automatic Workload Repository report include this data, so you do not need to perform the percentage calculations manually.

<div class="infoboxnotealso">

See Also:

[http://www.oracle.com/pls/topic/lookup?ctx=E25178-01&id=REFRN003 <span class="italic">Oracle Database Reference</span>] for information about dynamic performance views

</div>
After you have identified the candidate SQL statements, the next stage is to gather information that is necessary to examine the statements and tune them.


</div>

</div>
[[|]]
<div class="sect2">

[[|]]
=== <span class="secnum">16.3.2</span> Gathering Data on the SQL Identified ===

If you are most concerned with CPU, then examine the top SQL statements that performed the most <code>BUFFER_GETS</code> during that interval. Otherwise, start with the SQL statement that performed the most <code>DISK_READS</code>.

[[|]]
<div class="sect3">

[[|]]
==== <span class="secnum">16.3.2.1</span> Information to Gather During Tuning ====

The tuning process begins by determining the structure of the underlying tables and indexes. The information gathered includes the following:

<ol>
<li><p>Complete SQL text from <code>V$SQLTEXT</code></p></li>
<li><p>Structure of the tables referenced in the SQL statement, usually by describing the table in SQL*Plus</p></li>
<li><p>Definitions of any indexes (columns, column orders), and whether the indexes are unique or non-unique</p></li>
<li><p>Optimizer statistics for the segments (including the number of rows each table, selectivity of the index columns), including the date when the segments were last analyzed</p></li>
<li><p>Definitions of any views referred to in the SQL statement</p></li>
<li><p>Repeat steps two, three, and four for any tables referenced in the view definitions found in step five</p></li>
<li><p>Optimizer plan for the SQL statement (either from <code>EXPLAIN</code> <code>PLAN</code>, <code>V$SQL_PLAN</code>, or the <code>TKPROF</code> output)</p></li>
<li><p>Any previous optimizer plans for that SQL statement</p>
<div class="infoboxnote">

<p>Note:</p>
It is important to generate and review execution plans for all of the key SQL statements in your application. Doing so lets you compare the optimizer execution plans of a SQL statement when the statement performed well to the plan when that the statement is not performing well. Having the comparison, along with information such as changes in data volumes, can assist in identifying the cause of performance degradation.

</div></li></ol>


</div>

</div>

</div>
[[|]][[|]]
<div class="sect1">

== <span class="secnum">16.4</span> Automatic SQL Tuning Features ==

Because the manual SQL tuning process poses many challenges to the application developer, the SQL tuning process has been automated by the automatic SQL tuning features of Oracle Database. These features are designed to work equally well for OLTP and Data Warehouse type applications:

* [[#BABBJGEI|ADDM]]
* [[#BABGAEBA|SQL Tuning Advisor]]
* [[#BABFIHEF|SQL Tuning Sets]]
* [[#BABBAEJD|SQL Access Advisor]]

<div class="infoboxnotealso">

See Also:

[[sql_tune.htm#g42443|Chapter 17, &quot;Automatic SQL Tuning&quot;]].

</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.4.1</span> ADDM ===

The [[|]][[|]][[|]][[|]]Automatic Database Diagnostic Monitor (ADDM) analyzes the information collected by the AWR for possible performance problems with Oracle Database, including high-load SQL statements. See [[diag.htm#i37241|&quot;Overview of the Automatic Database Diagnostic Monitor&quot;]].


</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.4.2</span> SQL Tuning Advisor ===

[[|]][[|]]SQL Tuning Advisor optimizes SQL statements that have been identified as high-load SQL statements. By default, Oracle Database automatically identifies problematic SQL statements and implements tuning recommendations using SQL Tuning Advisor during system maintenance windows as an automated maintenance task, searching for ways to improve the execution plans of the high-load SQL statements. You can also choose to run SQL Tuning Advisor at any time on any given SQL workload to improve performance. See [[sql_tune.htm#i34782|&quot;Tuning Reactively with SQL Tuning Advisor&quot;]].


</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.4.3</span> SQL Tuning Sets ===

When multiple SQL statements serve as input to ADDM, SQL Tuning Advisor, or SQL Access Advisor, the database constructs and stores a [[|]]SQL tuning set (STS). The STS includes the set of SQL statements along with their associated execution context and basic execution statistics. See [[sql_tune.htm#i34915|&quot;Managing SQL Tuning Sets&quot;]].


</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.4.4</span> SQL Access Advisor ===

In addition to SQL Tuning Advisor, [[|]]SQL Access Advisor provides advice on materialized views, indexes, and materialized view logs. SQL Access Advisor helps you achieve performance goals by recommending the proper set of materialized views, materialized view logs, and indexes for a given workload. In general, as the number of materialized views and indexes and the space allocated to them is increased, query performance improves. SQL Access Advisor considers the trade-offs between space usage and query performance, and recommends the most cost-effective configuration of new and existing materialized views and indexes. See [[advisor.htm#i1026391|&quot;Using SQL Access Advisor&quot;]].


</div>

</div>
[[|]][[|]]
<div class="sect1">

== <span class="secnum">16.5</span> Developing Efficient SQL Statements ==

This section describes ways you can improve SQL statement efficiency:

<ul>
<li><p>[[#i28375|Verifying Optimizer Statistics]]</p></li>
<li><p>[[#i28403|Reviewing the Execution Plan]]</p></li>
<li><p>[[#i28528|Restructuring the SQL Statements]]</p></li>
<li><p>[[#i25277|Restructuring the Indexes]]</p></li>
<li><p>[[#i22336|Modifying or Disabling Triggers and Constraints]]</p></li>
<li><p>[[#i22339|Restructuring the Data]]</p></li>
<li><p>[[#i23988|Maintaining Execution Plans Over Time]]</p></li>
<li><p>[[#i25211|Visiting Data as Few Times as Possible]]</p>
<div class="infoboxnote">

<p><span class="bold">Note</span>:</p>
The guidelines described in this section are oriented to production of frequently executed SQL. Most techniques that are discouraged here can legitimately be employed in ad hoc statements or in applications run infrequently where performance is not critical.

</div></li></ul>

[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.5.1</span> Verifying Optimizer Statistics ===

The query optimizer uses statistics gathered on tables and indexes when determining the optimal execution plan. If these statistics have not been gathered, or if the statistics are no longer representative of the data stored within the database, then the optimizer does not have sufficient information to generate the best plan.

Things to check:

* If you gather statistics for some tables in your database, then it is probably best to gather statistics for all tables. This is especially true if your application includes SQL statements that perform joins.
* If the optimizer statistics in the data dictionary are no longer representative of the data in the tables and indexes, then gather new statistics. One way to check whether the dictionary statistics are stale is to compare the real cardinality (row count) of a table to the value of <code>DBA_TABLES.NUM_ROWS</code>. Additionally, if there is significant data skew on predicate columns, then consider using histograms.


</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.5.2</span> Reviewing the Execution Plan ===

When tuning (or writing) a SQL statement in an OLTP environment, the goal is to drive from the table that has the most selective filter. This means that there are fewer rows passed to the next step. If the next step is a join, then this means that fewer rows are joined. Check to see whether the access paths are optimal.

When examining the optimizer execution plan, look for the following:

<ul>
<li><p>The driving table has the best filter.</p></li>
<li><p>The join order in each step returns the fewest number of rows to the next step (that is, the join order should reflect, where possible, going to the best not-yet-used filters).</p></li>
<li><p>The join method is appropriate for the number of rows being returned. For example, nested loop joins through indexes may not be optimal when the statement returns many rows.</p></li>
<li><p>The database uses views efficiently. Look at the <code>SELECT</code> list to see whether access to the view is necessary.</p></li>
<li><p>There are any unintentional Cartesian products (even with small tables).</p></li>
<li><p>Each table is being accessed efficiently:</p>
<p>Consider the predicates in the SQL statement and the number of rows in the table. Look for suspicious activity, such as a full table scans on tables with large number of rows, which have predicates in the where clause. Determine why an index is not used for such a selective predicate.</p>
<p>A full table scan does not mean inefficiency. It might be more efficient to perform a full table scan on a small table, or to perform a full table scan to leverage a better join method (for example, hash_join) for the number of rows returned.</p></li></ul>

If any of these conditions are not optimal, then consider restructuring the SQL statement or the indexes available on the tables.


</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.5.3</span> Restructuring the SQL Statements ===

Often, rewriting an inefficient SQL statement is easier than modifying it. If you understand the purpose of a given statement, then you might be able to quickly and easily write a new statement that meets the requirement.

[[|]]
<div class="sect3">

[[|]]
==== <span class="secnum">16.5.3.1</span> Compose Predicates Using AND and = ====

To improve SQL efficiency, use [[|]]equijoins whenever possible. Statements that perform equijoins on untransformed column values are the easiest to tune.


</div>
[[|]][[|]]
<div class="sect3">

==== <span class="secnum">16.5.3.2</span> Avoid Transformed Columns in the WHERE Clause ====

Use [[|]]untransformed column values. For example, use:

<pre class="oac_no_warn">WHERE a.order_no = b.order_no</pre>
rather than:

<pre class="oac_no_warn">WHERE TO_NUMBER (SUBSTR(a.order_no, INSTR(b.order_no, '.') - 1))
= TO_NUMBER (SUBSTR(a.order_no, INSTR(b.order_no, '.') - 1))</pre>
Do not use SQL functions in predicate clauses or <code>WHERE</code> clauses. Any expression using a column, such as a function having the column as its argument, causes the optimizer to ignore the possibility of using an index on that column, even a unique index, unless there is a function-based index defined that the database can use.

Avoid mixed-mode [[|]]expressions, and beware of implicit [[|]]type conversions. When you want to use an index on the <code>VARCHAR2</code> column <code>charcol</code>, but the <code>WHERE</code> clause looks like this:

<pre class="oac_no_warn">AND charcol = numexpr</pre>
where <code>numexpr</code> is an expression of number type (for example, 1, <code>USERENV</code>('<code>SESSIONID</code>'), <code>numcol</code>, <code>numcol</code>+0,...), Oracle Database translates that expression into:

<pre class="oac_no_warn">AND TO_NUMBER(charcol) = numexpr</pre>
Avoid the following kinds of complex expressions:

* <code>col1</code> = <code>NVL</code> <code>(:b1</code>,<code>col1)</code>
* <code>NVL</code> (<code>col1,-999</code>) = ….
* <code>TO_DATE</code>(), <code>TO_NUMBER</code>(), and so on

These expressions prevent the optimizer from assigning valid cardinality or selectivity estimates and can in turn affect the overall plan and the join method.

Add the predicate versus using <code>NVL</code>() technique.

For example:

<pre class="oac_no_warn">SELECT employee_num, full_name Name, employee_id 
  FROM mtl_employees_current_view 
  WHERE (employee_num = NVL (:b1,employee_num)) AND (organization_id=:1) 
  ORDER BY employee_num;</pre>
Also:

<pre class="oac_no_warn">SELECT employee_num, full_name Name, employee_id 
  FROM mtl_employees_current_view 
  WHERE (employee_num = :b1) AND (organization_id=:1) 
  ORDER BY employee_num;</pre>
When you need to use SQL functions on filters or join predicates, do not use them on the columns on which you want to have an index, as in the following statement:

<pre class="oac_no_warn">varcol = TO_CHAR(numcol)</pre>
Instead, use them on the opposite side of the predicate, as in the following statement:

<pre class="oac_no_warn">TO_CHAR(numcol) = varcol</pre>
<div class="infoboxnotealso">

See Also:

[[data_acc.htm#g27061|Chapter 14, &quot;Using Indexes and Clusters&quot;]] for more information on function-based indexes

</div>

</div>
[[|]][[|]]
<div class="sect3">

==== <span class="secnum">16.5.3.3</span> Write Separate SQL Statements for Specific Tasks ====

SQL is not a procedural language. Using one piece of SQL to do many different things usually results in a less-than-optimal result for each task. If you want SQL to accomplish different things, then write various statements, rather than writing one statement to do different things depending on the parameters you give it.

<div class="infoboxnote">

Note:

Oracle Forms and Reports are powerful development tools that allow application logic to be coded using PL/SQL (triggers or program units). This helps reduce the complexity of SQL by allowing complex logic to be handled in the Forms or Reports. You can also invoke a server side PL/SQL package that performs the few SQL statements in place of a single large complex SQL statement. Because the package is a server-side unit, there are no issues surrounding client to database round-trips and network traffic.

</div>
It is always better to write separate SQL statements for different tasks, but if you must use one SQL statement, then you can make a very complex statement slightly less complex by using the <code>UNION</code> <code>ALL</code> operator.

Optimization (determining the execution plan) takes place before the database knows the values substituted in the query. An execution plan cannot, therefore, depend on what those values are. For example:

<pre class="oac_no_warn">SELECT info 
FROM tables
WHERE ... </pre>
<pre class="oac_no_warn">AND somecolumn BETWEEN DECODE(:loval, 'ALL', somecolumn, :loval)
AND DECODE(:hival, 'ALL', somecolumn, :hival);</pre>
<pre class="oac_no_warn"></pre>
Written as shown, the database cannot use an index on the <code>somecolumn</code> column, because the expression involving that column uses the same column on both sides of the <code>BETWEEN</code>.

This is not a problem if there is some other highly selective, indexable condition you can use to access the driving table. Often, however, this is not the case. Frequently, you might want to use an index on a condition like that shown but need to know the values of :<code>loval</code>, and so on, in advance. With this information, you can rule out the <code>ALL</code> case, which should not use the index.

To use the index whenever real values are given for :<code>loval</code> and :<code>hival</code> (if you expect narrow ranges, even ranges where :<code>loval</code> often equals :<code>hival</code>), you can rewrite the example in the following logically equivalent form:

<pre class="oac_no_warn">SELECT /* change this half of UNION ALL if other half changes */ info
FROM   tables 
WHERE  ... </pre>
<pre class="oac_no_warn">AND    somecolumn BETWEEN :loval AND :hival
AND   (:hival != 'ALL' AND :loval != 'ALL') </pre>
<pre class="oac_no_warn">UNION ALL 
SELECT /* Change this half of UNION ALL if other half changes. */ info
FROM   tables
WHERE  ... </pre>
<pre class="oac_no_warn">AND (:hival = 'ALL' OR :loval = 'ALL');</pre>
<pre class="oac_no_warn"></pre>
If you run <code>EXPLAIN</code> <code>PLAN</code> on the new query, then you seem to get both a desirable and an undesirable execution plan. However, the first condition the database evaluates for either half of the <code>UNION</code> <code>ALL</code> is the combined condition on whether <code>:hival</code> and <code>:loval</code> are <code>ALL</code>. The database evaluates this condition before actually getting any rows from the execution plan for that part of the query.

When the condition comes back false for one part of the <code>UNION</code> <code>ALL</code> query, that part is not evaluated further. Only the part of the execution plan that is optimum for the values provided is actually carried out. Because the final conditions on <code>:hival</code> and <code>:loval</code> are guaranteed to be mutually exclusive, only one half of the <code>UNION</code> <code>ALL</code> actually returns rows. (The <code>ALL</code> in <code>UNION</code> <code>ALL</code> is logically valid because of this exclusivity. It allows the plan to be carried out without an expensive sort to rule out duplicate rows for the two halves of the query.)


</div>

</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.5.4</span> Controlling the Access Path and Join Order with Hints ===

You can influence the optimizer's choices by setting the optimizer approach and goal, and by gathering representative statistics for the query optimizer. Sometimes, the application designer, who has more information about a particular application's data than is available to the optimizer, can choose a more effective way to execute a SQL statement. You can use hints in SQL statements to instruct the optimizer about how the statement should be executed.

[[|]]Hints, such as /*+<code>FULL</code> */ control access paths. For example:

<pre class="oac_no_warn">SELECT /*+ FULL(e) */ e.last_name
  FROM employees e
 WHERE e.job_id = 'CLERK';</pre>
<div class="infoboxnotealso">

<span class="bold">See Also</span>:

[[optimops.htm#g92116|Chapter 11, &quot;The Query Optimizer&quot;]] and [[hintsref.htm#i8327|Chapter 19, &quot;Using Optimizer Hints&quot;]]

</div>
[[|]][[|]]Join order can have a significant effect on performance. The main objective of SQL tuning is to avoid performing unnecessary work to access rows that do not affect the result. This leads to three general rules:

* Avoid a full-table scan if it is more efficient to get the required rows through an index.
* Avoid using an index that fetches 10,000 rows from the driving table if you could instead use another index that fetches 100 rows.
* Choose the join order so as to join fewer rows to tables later in the join order.

The following example shows how to tune join order effectively:

<pre class="oac_no_warn">SELECT info
FROM taba a, tabb b, tabc c
WHERE a.acol BETWEEN 100 AND 200</pre>
<pre class="oac_no_warn">AND b.bcol BETWEEN 10000 AND 20000
AND c.ccol BETWEEN 10000 AND 20000
AND a.key1 = b.key1
AND a.key2 = c.key2;</pre>
<pre class="oac_no_warn"></pre>
<ol>
<li><p>Choose the driving table and the driving index (if any).</p>
<p>The first three conditions in the previous example are filter conditions applying to only a single table each. The last two conditions are join conditions.</p>
<p>Filter conditions dominate the choice of driving table and index. In general, the driving table is the one containing the filter condition that eliminates the highest percentage of the table. Thus, because the range of 100 to 200 is narrow compared with the range of <code>acol</code>, but the ranges of 10000 and 20000 are relatively large, <code>taba</code> is the driving table, all else being equal.</p>
<p>With nested loop joins, the joins all happen through the join indexes, the indexes on the primary or foreign keys used to connect that table to an earlier table in the join tree. Rarely do you use the indexes on the non-join conditions, except for the driving table. Thus, after <code>taba</code> is chosen as the driving table, use the indexes on <code>b</code>.<code>key1</code> and <code>c</code>.<code>key2</code> to drive into <code>tabb</code> and <code>tabc</code>, respectively.</p></li>
<li><p>Choose the best [[|]]join order, driving to the best unused filters earliest.</p>
<p>You can reduce the work of the following join by first joining to the table with the best still-unused filter. Thus, if &quot;<code>bcol</code> <code>BETWEEN</code> ...&quot; is more restrictive (rejects a higher percentage of the rows seen) than &quot;<code>ccol</code> <code>BETWEEN</code> ...&quot;, then the last join becomes easier (with fewer rows) if <code>tabb</code> is joined before <code>tabc</code>.</p></li>
<li><p>You can use the <code>ORDERED</code> or <code>STAR</code> hint to force the join order.</p>
<div class="infoboxnotealso">

<p>See Also:</p>
[[hintsref.htm#CHDGGCHC|&quot;Hints for Join Orders&quot;]]

</div></li></ol>

[[|]]
<div class="sect3">

[[|]]
==== <span class="secnum">16.5.4.1</span> Use Caution When Managing Views ====

Be careful when joining views, when performing [[|]]outer joins to views, and when reusing an existing view for a new purpose.

[[|]][[|]]
<div class="sect4">

===== <span class="secnum">16.5.4.1.1</span> Use Caution When Joining Complex Views =====

Joins to complex views are not recommended, particularly joins from one complex view to another. Often this results in the entire view being instantiated, and then the query is run against the view data.

For example, the following statement creates a view that lists employees and departments:

<pre class="oac_no_warn">CREATE OR REPLACE VIEW emp_dept
AS
SELECT d.department_id, d.department_name, d.location_id,
     e.employee_id, e.last_name, e.first_name, e.salary, e.job_id
FROM  departments d
     ,employees e
WHERE e.department_id (+) = d.department_id;</pre>
The following query finds employees in a specified state:

<pre class="oac_no_warn">SELECT v.last_name, v.first_name, l.state_province
  FROM locations l, emp_dept v
 WHERE l.state_province = 'California'
  AND   v.location_id = l.location_id (+);</pre>
In the following plan table output, note that the <code>emp_dept</code> view is instantiated:

<pre class="oac_no_warn">--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------</pre>

</div>
[[|]][[|]]
<div class="sect4">

===== <span class="secnum">16.5.4.1.2</span> Do Not Recycle Views =====

Beware of writing a view for one purpose and then using it for other purposes to which it might be ill-suited. Querying from a view requires all tables from the view to be accessed for the data to be returned. Before reusing a view, determine whether all tables in the view need to be accessed to return the data. If not, then do not use the view. Instead, use the base table(s), or if necessary, define a new view. The goal is to refer to the minimum number of tables and views necessary to return the required data.

Consider the following example:

<pre class="oac_no_warn">SELECT department_name 
FROM emp_dept
WHERE department_id = 10;</pre>
The entire view is first instantiated by performing a join of the <code>employees</code> and <code>departments</code> tables and then aggregating the data. However, you can obtain <code>department_name</code> and <code>department_id</code> directly from the <code>departments</code> table. It is inefficient to obtain this information by querying the <code>emp_dept</code> view.


</div>
[[|]][[|]]
<div class="sect4">

===== <span class="secnum">16.5.4.1.3</span> Use Caution When Unnesting Subque[[|]]ries =====

Subquery unnesting merges the body of the subquery into the body of the statement that contains it, allowing the optimizer to consider them together when evaluating access paths and joins.

<div class="infoboxnotealso">

See Also:

[http://www.oracle.com/pls/topic/lookup?ctx=E25178-01&id=DWHSG <span class="italic">Oracle Database Data Warehousing Guide</span>] for an explanation of the dangers with subquery unnesting

</div>

</div>
[[|]][[|]]
<div class="sect4">

===== <span class="secnum">16.5.4.1.4</span> Use Caution When Performing Outer Joins to Views =====

In the case of an outer join to a multi-table view, the query optimizer (in Release 8.1.6 and later) can drive from an outer join column, if an equality predicate is defined on it.

An outer join <span class="italic">within</span> a view is problematic because the performance implications of the outer join are not visible.


</div>

</div>
[[|]]
<div class="sect3">

[[|]]
==== <span class="secnum">16.5.4.2</span> Store Intermediate Results ====

Intermediate, or staging, tables are quite common in relational database systems, because they temporarily store some intermediate results. In many applications they are useful, but Oracle Database requires additional resources to create them. Always consider whether the benefit they could bring is more than the cost to create them. Avoid staging tables when the information is not reused multiple times.

Some additional considerations:

<ul>
<li><p>Storing intermediate results in staging tables could improve application performance. In general, whenever an intermediate result is usable by multiple following queries, it is worthwhile to store it in a staging table. The benefit of not retrieving data multiple times with a complex statement at the second usage of the intermediate result is better than the cost to materialize it.</p></li>
<li><p>Long and complex queries are hard to understand and optimize. Staging tables can break a complicated SQL statement into several smaller statements, and then store the result of each step.</p></li>
<li><p>Consider using materialized views. These are precomputed tables comprising aggregated or joined data from fact and possibly dimension tables.</p>
<div class="infoboxnotealso">

<p>See Also:</p>
[http://www.oracle.com/pls/topic/lookup?ctx=E25178-01&id=DWHSG <span class="italic">Oracle Database Data Warehousing Guide</span>] for detailed information on using materialized views

</div></li></ul>


</div>

</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.5.5</span> Restructuring the Indexes ===

Often, there is a beneficial impact on performance by restructuring indexes. This can involve the following:

* Remove nonselective indexes to speed the DML.
* Index performance-critical access paths.
* Consider reordering columns in existing concatenated indexes.
* Add columns to the index to improve selectivity.

[[|]]
Do not use indexes as a panacea. Application developers sometimes think that performance improves when they create more indexes. If a single programmer creates an appropriate index, then this index may improve the application's performance. However, if 50 developers each create an index, then application performance will probably be hampered.


</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.5.6</span> Modifying or Disabling Triggers and Constraints ===

Using triggers consumes system resources. If you use too many triggers, then performance may be adversely affected. In this case, you might need to modify or disable the triggers.


</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.5.7</span> Restructuring the Data ===

After restructuring the indexes and the statement, consider restructuring the data:

* Introduce derived values. Avoid <code>GROUP</code> <code>BY</code> in response-critical code.
* Review your data design. Change the design of your system if it can improve performance.
* Consider partitioning, if appropriate.


</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.5.8</span> Maintaining Execution Plans Over Time ===

You can maintain the existing execution plan of SQL statements over time either using stored statistics or SQL plan baselines. Storing optimizer statistics for tables will apply to all SQL statements that refer to those tables. Storing an execution plan as a SQL plan baseline maintains the plan for set of SQL statements. If both statistics and a SQL plan baseline are available for a SQL statement, then the optimizer first uses a cost-based search method to build a best-cost plan, and then tries to find a matching plan in the SQL plan baseline. If a match is found, then the optimizer proceeds using this plan. Otherwise, it evaluates the cost of each of the accepted plans in the SQL plan baseline and selects the plan with the lowest cost.

<div class="infoboxnotealso">

See Also:

* [[optplanmgmt.htm#BABEAFGG|Chapter 15, &quot;Using SQL Plan Management&quot;]]
* [[stats.htm#g49431|Chapter 13, &quot;Managing Optimizer Statistics&quot;]]


</div>

</div>
[[|]][[|]]
<div class="sect2">

=== <span class="secnum">16.5.9</span> Visiting Data as Few Times as Possible ===

Applications should try to access each row only once. This reduces network traffic and reduces database load. Consider doing the following:

* [[#i26629|Combine Multiples Scans Using CASE Expressions]]
* [[#i26634|Use DML with RETURNING Clause]]
* [[#i25629|Modify All the Data Needed in One Statement]]

[[|]][[|]]
<div class="sect3">

==== <span class="secnum">16.5.9.1</span> Combine Multiples Scans Using CASE Expressions ====

Often, it is necessary to calculate different aggregates on various sets of tables. Usually, you achieve this goal with multiple scans on the table, but it is easy to calculate all the aggregates with a single scan. Eliminating <span class="italic">n</span>-1 scans can greatly improve performance.

You can combine multiple scans into one scan by moving the <code>WHERE</code> condition of each scan into a <code>CASE</code> expression, which filters the data for the aggregation. For each aggregation, there could be another column that retrieves the data.

The following example asks for the count of all employees who earn less then 2000, between 2000 and 4000, and more than 4000 each month. You can obtain this result by executing three separate queries:

<pre class="oac_no_warn">SELECT COUNT (*)
  FROM employees
  WHERE salary &lt; 2000;

SELECT COUNT (*)
  FROM employees
  WHERE salary BETWEEN 2000 AND 4000;

SELECT COUNT (*)
  FROM employees
  WHERE salary&gt;4000;</pre>
However, it is more efficient to run the entire query in a single statement. Each number is calculated as one column. The count uses a filter with the <code>CASE</code> expression to count only the rows where the condition is valid. For example:

<pre class="oac_no_warn">SELECT COUNT (CASE WHEN salary &lt; 2000 
                   THEN 1 ELSE null END) count1, 
       COUNT (CASE WHEN salary BETWEEN 2001 AND 4000 
                   THEN 1 ELSE null END) count2, 
       COUNT (CASE WHEN salary &gt; 4000 
                   THEN 1 ELSE null END) count3 
  FROM employees; </pre>
This is a very simple example. The ranges could be overlapping, the functions for the aggregates could be different, and so on.


</div>
[[|]][[|]]
<div class="sect3">

==== <span class="secnum">16.5.9.2</span> Use DML with RETURNING Clause ====

When appropriate, use <code>INSERT</code>, <code>UPDATE</code>, or <code>DELETE</code>... <code>RETURNING</code> to select and modify data with a single call. This technique improves performance by reducing the number of calls to the database.

<div class="infoboxnotealso">

<span class="bold">See Also</span>:

[http://www.oracle.com/pls/topic/lookup?ctx=E25178-01&id=SQLRF <span class="italic">Oracle Database SQL Language Reference</span>] for syntax on the <code>INSERT</code>, <code>UPDATE</code>, and <code>DELETE</code> statements

</div>

</div>
[[|]][[|]]
<div class="sect3">

==== <span class="secnum">16.5.9.3</span> Modify All the Data Needed in One Statement ====

When possible, use array processing. This means that an array of bind variable values is passed to Oracle Database for repeated execution. This is appropriate for iterative processes in which multiple rows of a set are subject to the same operation.

For example:

<pre class="oac_no_warn">BEGIN
 FOR pos_rec IN (SELECT * 
   FROM order_positions 
   WHERE order_id = :id) LOOP
      DELETE FROM order_positions
      WHERE order_id = pos_rec.order_id AND
        order_position = pos_rec.order_position;
 END LOOP;
 DELETE FROM orders 
 WHERE order_id = :id;
END;</pre>
Alternatively, you could define a cascading constraint on <code>orders</code>. In the previous example, one <code>SELECT</code> and <span class="italic">n</span> <code>DELETE</code>s are executed. When a user issues the <code>DELETE</code> on <code>orders</code> <code>DELETE</code> <code>FROM</code> <code>orders</code> <code>WHERE</code> <code>order_id</code> = <code>:id</code>, the database automatically deletes the positions with a single <code>DELETE</code> statement.

<div class="infoboxnotealso">

See Also:

[http://www.oracle.com/pls/topic/lookup?ctx=E25178-01&id=ADMIN <span class="italic">Oracle Database Administrator's Guide</span>] or [http://www.oracle.com/pls/topic/lookup?ctx=E25178-01&id=HETER <span class="italic">Oracle Database Heterogeneous Connectivity User's Guide</span>] to learn how to tune distributed queries

</div>

</div>

</div>

</div>
[[|]][[|]]
<div class="sect1">

== <span class="secnum">16.6</span> Building SQL Test Cases ==

For many SQL-related problems, obtaining a reproducible test case makes it easier to resolve the problem. Starting with the 11<span class="italic">g</span> Release 2 (11.2), Oracle Database contains the [[|]]SQL Test Case Builder, which automates the somewhat difficult and time-consuming process of gathering and reproducing as much information as possible about a problem and the environment in which it occurred.

The objective of a SQL Test Case Builder is to capture the information pertaining to a SQL-related problem, along with the exact environment under which the problem occurred, so that you can reproduce and test the problem on a separate Oracle database. After the test case is ready, you can upload the problem to Oracle Support to enable support personnel to reproduce and troubleshoot the problem.

The information gathered by SQL Test Case Builder includes the query being executed, table and index definitions (but not the actual data), PL/SQL functions, procedures, and packages, optimizer statistics, and initialization parameter settings.

[[|]]
<div class="sect2">

[[|]]
=== <span class="secnum">16.6.1</span> Creating a Test Case ===

You can access the SQL Test Case Builder from Enterprise Manager and manually using the <code>DBMS_SQLDIAG</code> package.

[[|]]
<div class="sect3">

[[|]]
==== <span class="secnum">16.6.1.1</span> Accessing SQL Test Case Builder from the Enterprise Manager ====

From Enterprise Manager, the SQL Test Case Builder is accessible only when a SQL incident occurs. A SQL-related problem is referred to as a SQL incident, and each SQL incident is identified by an incident number. You can access the SQL Test Case Builder from the <code>Support Workbench</code> page in Enterprise Manager.

You can access the <code>Support Workbench</code> page in either of the following ways:

* In the Database Home page of Enterprise Manager, under <code>Diagnostic Summary</code>, click the link to <code>Active Incidents</code> (indicating the number of active incidents). This opens the <code>Support Workbench</code> page, with the incidents listed in a table.
* Click <span class="bold">Advisor Central</span> under <code>Related Links</code> to open the <code>Advisor Central</code> page. Next, click <span class="bold">SQL Advisors</span> and then <span class="bold">Click here to go to Support Workbench</span> to open the <code>Support Workbench</code> page.

From the <code>Support Workbench</code> page, to access the SQL Test Case Builder:

<ol>
<li><p>Click an incident ID to open the problem details for the particular incident.</p></li>
<li><p>Next, click <span class="bold">Oracle Support</span> in the <code>Investigate and Resolve</code> section.</p></li>
<li><p>Click <span class="bold">Generate Additional Dumps and Test Cases</span>.</p></li>
<li><p>For a particular incident, click the icon in the <code>Go To Task</code> column to run the SQL Test Case Builder.</p>
<p>Provide a location to store the test case, and also provide a name for the output.</p></li></ol>

The output of the SQL Test Case Builder is a SQL script that contains the commands required to re-create all the necessary objects and the environment.


</div>
[[|]]
<div class="sect3">

[[|]]
==== <span class="secnum">16.6.1.2</span> Accessing SQL Test Case Builder Using [[|]]DBMS_SQLDIAG ====

You can also invoke the SQL Test Case Builder manually, using the <code>DBMS_SQLDIAG</code> package. This package consists of various subprograms for the SQL Test Case Builder, some of which are listed in [[#CEGHEBIC|Table 16-1]].

<div class="tblformal">

[[|]][[|]][[|]]
Table 16-1 SQL Test Case Builder Procedures in DBMS_SQLDIAG

{|
!width="46%"| Procedure Name
! Function
|-
| EXPORT_SQL_TESTCASE
| Generate a SQL test case.
|-
| EXPORT_SQL_TESTCASE_DIR_BY_INC
| Generates a SQL test case corresponding to the incident ID passed as an argument.
|-
| EXPORT_SQL_TESTCASE_DIR_BY_TXT
| Generates a SQL test case corresponding to the SQL text passed as an argument.
|}

<br />


</div>
For more information on this package and all of its procedures and parameters, see [http://www.oracle.com/pls/topic/lookup?ctx=E25178-01&id=ARPLS <span class="italic">Oracle Database PL/SQL Packages and Types Reference</span>].


</div>

</div>

</div>

</div>
<div class="footer">


-----

{|
|width="33%"|
{|
| [[optplanmgmt.htm|[[File:../../dcommon/gifs/leftnav.gif|24x24px|Go to previous page]]<br />
<span class="icon">Previous</span>]]
| [[sql_tune.htm|[[File:../../dcommon/gifs/rightnav.gif|24x24px|Go to next page]]<br />
<span class="icon">Next</span>]]
|}
| [[File:../../dcommon/gifs/oracle.gif|144x18px|Oracle]]<br />
Copyright © 2000, 2011, Oracle and/or its affiliates. All rights reserved.<br />
[[../../dcommon/html/cpyr.htm|Legal Notices]]
|width="33%"|
{|
| [[../../index.htm|[[File:../../dcommon/gifs/doclib.gif|24x24px|Go to Documentation Home]]<br />
<span class="icon">Home</span>]]
| [[../../nav/portal_booklist.htm|[[File:../../dcommon/gifs/booklist.gif|24x24px|Go to Book List]]<br />
<span class="icon">Book List</span>]]
| [[toc.htm|[[File:../../dcommon/gifs/toc.gif|24x24px|Go to Table of Contents]]<br />
<span class="icon">Contents</span>]]
| [[index.htm|[[File:../../dcommon/gifs/index.gif|24x24px|Go to Index]]<br />
<span class="icon">Index</span>]]
| [[../../dcommon/html/feedback.htm|[[File:../../dcommon/gifs/feedbck2.gif|24x24px|Go to Feedback page]]<br />
<span class="icon">Contact Us</span>]]
|}
|}


</div>
Scripting on this page enhances content navigation, but does not change the content in any way.
