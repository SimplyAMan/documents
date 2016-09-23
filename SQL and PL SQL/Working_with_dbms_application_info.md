# Working with dbms_application_info

From [here](http://www.dba-oracle.com/job_scheduling/killing_sessions.htm)

[Додаткова інформація](http://torofimofu.blogspot.com/2014/05/oracle.html)

The package allows programs to add information to the v$session and v$session_longops views to make tracking of session activities more simple and more accurate.

When a program initiates, it should register itself using the set_module procedure to indicate that it is currently using the session.

``` sql
PROCEDURE set_module (
  module_name  IN  VARCHAR2,
  action_name  IN  VARCHAR2)
```

The module_name parameter is used to specify the program name; while the action_name parameter is used to indicate what the program is currently doing. 

As programs progress, the set_action procedure can be used to alter the value of the action column of the v$session view.

``` sql
PROCEDURE set_action (
  action_name  IN  VARCHAR2)
```

Assuming there was a procedure called add_order, which adds an order into an application schema, the following dbms_application_info package might be used.

``` sql
BEGIN
  DBMS_APPLICATION_INFO.set_module(
    module_name => 'add_order',
    action_name => 'insert into orders'); 

  -- Do insert into ORDERS table.

  DBMS_APPLICATION_INFO.set_action(
    action_name => 'insert into order_lines');

  -- Do insert into ORDER_LINESS table.

  DBMS_APPLICATION_INFO.set_action(
    action_name => 'complete');
END;
/
```

In the above example, the set_module procedure sets the value of the module column in the v$session view to add_order, while the ACTION column is set to the value insert into orders.

The action is regularly amended using the set_action procedure to make sure the ACTION column of the v$session view stays accurate.

The set_client_info procedure allows information to be stored in the CLIENT_INFO column of the v$session view.

``` sql
PROCEDURE set_client_info (
  client_info  IN  VARCHAR2)

The following example may be executed to indicate that the procedure is being run as a job.

BEGIN
  DBMS_APPLICATION_INFO.set_client_info(
    client_info => 'job');
END;
/
```

The following query shows that the values in the v$session view are being set correctly.

``` sql
select 
   module,
   action,
   client_info
from
   v$session
where
   username = 'JOB_USER'
;
```

```
MODULE             ACTION           CLIENT_INFO
------------------ ---------------- -------------------------
add_order          complete         job

1 row selected.
```

The set_session_longops procedure can be used to publish information about the progress of long operations by inserting and updating rows in the v$session_longops view.

``` sql
PROCEDURE set_session_longops (
  rindex       IN OUT  PLS_INTEGER,
  slno         IN OUT  PLS_INTEGER,
  op_name      IN      VARCHAR2    DEFAULT NULL,
  target       IN      PLS_INTEGER DEFAULT 0,
  context      IN      PLS_INTEGER DEFAULT 0,
  sofar        IN      NUMBER      DEFAULT 0,
  totalwork    IN      NUMBER      DEFAULT 0,
  target_desc  IN      VARCHAR2    DEFAULT 'unknown target',
  units        IN      VARCHAR2    DEFAULT NULL)
```

This procedure is especially useful when operations contain long running loops such as in the example below.

``` sql
DECLARE
  l_rindex     PLS_INTEGER;
  l_slno       PLS_INTEGER;
  l_totalwork  NUMBER;
  l_sofar      NUMBER;
  l_obj        PLS_INTEGER;
BEGIN
  l_rindex    := DBMS_APPLICATION_INFO.set_session_longops_nohint;
  l_sofar     := 0;
  l_totalwork := 10;

  WHILE l_sofar < 10 LOOP
    -- Do some work
    DBMS_LOCK.sleep(5);
    l_sofar := l_sofar + 1;

    DBMS_APPLICATION_INFO.set_session_longops(
      rindex      => l_rindex, 
      slno        => l_slno,
      op_name     => 'BATCH_LOAD', 
      target      => l_obj, 
      context     => 0, 
      sofar       => l_sofar, 
      totalwork   => l_totalwork, 
      target_desc => 'BATCH_LOAD_TABLE', 
      units       => 'rows');
  END LOOP;
END;
/
```

While the above code is running, the contents of the v$session_longops view can be queried as follows.

``` sql
column opname format A20
column target_desc format A20
column units format A10

select
   opname,
   target_desc,
   sofar,
   totalwork,
   units
from
   v$session_longops
where
   opname = 'BATCH_LOAD';
```

The resulting output looks something like the one listed below.

```
OPNAME               TARGET_DESC           SOFAR  TOTALWORK UNITS
-------------------- -------------------- ------ ---------- --------
BATCH_LOAD           BATCH_LOAD_TABLE          3         10 rows

1 row selected.
```

The my_job_proc procedure that is used throughout this book utilizes the dbms_application_info package.

In Oracle10g, the dbms_monitor package can be used to initiate SQL tracing for sessions based on their service, module and action attributes, making the use of the dbms_application_info package even more valuable.  A complete introduction to these SQL tracing enhancements is beyond the scope of this book, but the following example shows how the dbms_monitor package is used in this context.

``` sql
BEGIN
  DBMS_MONITOR.serv_mod_act_trace_enable (
    service_name  => 'my_service',
    module_name   => 'add_order',
    action_name   => 'insert into order_lines');

  DBMS_MONITOR.serv_mod_act_trace_disable (
    service_name  => 'my_service',
    module_name   => 'add_order',
    action_name   => 'insert into order_lines');
END;
/
```

The same attributes can be used by the new trcsess utility to consolidate information from several trace files into a single file, which can then be processed by the TKPROF utility.  The following example searches all files with a file extension of ?.trc? for trace information related to the specified service, module and action.  The resulting information is written to the ?client.trc? file.

trcsess output=client.trc service=my_service module=add_order action=?insert into order_lines? *.trc

This section showed how the dbms_application_info package offers valuable tools for identifying and monitoring the progress of any sessions that support scheduled jobs.  The next section will present how the dbms_system package can be used to write text directly to trace files and alert logs.