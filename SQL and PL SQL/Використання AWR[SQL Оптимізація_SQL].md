## Формування звітів з AWR

﻿Для отримання топ DML які створюють максимальне навантаження на базу даних можна використати скрипт awrrpt.sql.

Для докладнішого аналізу проблемного "sql_id" можна скористатись скриптом awrsqrpt.sql.


## Отримання SQL_ID з AWR
``` sql
SELECT sql_text,
       parsing_schema_name AS parsed,
       elapsed_time_delta / 1000 / 1000 AS elapsed_sec,
       stat.snap_id,
       TO_CHAR (snap.end_interval_time, 'dd.mm hh24:mi:ss') AS snaptime,
       txt.sql_id
  FROM dba_hist_sqlstat stat, dba_hist_sqltext txt, dba_hist_snapshot snap
 WHERE stat.sql_id = txt.sql_id
   AND stat.snap_id = snap.snap_id
   AND snap.begin_interval_time >= SYSDATE - 1
   AND UPPER (sql_text) LIKE UPPER('%&t%')
   AND parsing_schema_name IN ('CREATOR')
ORDER BY elapsed_time_delta desc;
```
SYSDATE - 1 означає, що шукаємо з передвчора до теперішнього часу
&t - частина рядка SQL запиту

## Отримання плану з AWR для SQL_ID

``` sql
select plan_table_output from table (dbms_xplan.display_awr('&sqlid'));
```

## Отримання значень bind змінних з AWR по SQL_ID і snap_id

``` sql
SELECT sb.NAME, sb.Value_String, sb.DataType_String
  FROM dba_hist_sqlbind sb, dba_hist_snapshot snap
 WHERE sb.sql_id = '&sqlid'
   AND sb.was_captured = 'YES'
   AND snap.snap_id = sb.snap_id
   AND snap.snap_id = 111426 -- з попередньої таблиці
ORDER BY sb.snap_id, sb.NAME;
```

## Блокування з AWR

``` sql
  SELECT sql_id ,
         SUM ( wait_time + time_waited ) t_w ,
         (SELECT object_name
            FROM dba_objects
           WHERE object_id = A. CURRENT_OBJ#)
            object_name ,
         (SELECT DISTINCT sql_text
            FROM v$sql
           WHERE sql_id = A. sql_id)
            sql_text
    FROM dba_hist_active_sess_history A
   WHERE event LIKE 'enq: TX%'
     AND snap_id IN
            (SELECT snap_id
               FROM dba_hist_snapshot
              WHERE end_interval_time BETWEEN TO_TIMESTAMP (
                                                 '27.03.2013 09:00:00',
                                                 'DD.MM.YYYY HH24:MI:SS')
                                          AND TO_TIMESTAMP (
                                                 '30.03.2013 16:00:00',
                                                 'DD.MM.YYYY HH24:MI:SS'))
GROUP BY sql_id,
         "CURRENT_OBJ#",
         "CURRENT_FILE#",
         "CURRENT_BLOCK#",
         "CURRENT_ROW#"
ORDER BY t_w DESC;
```

## Настройки AWR

``` sql
SELECT *
  FROM dba_hist_wr_control;
```

## Настройки

``` sql
SELECT *
  FROM dba_hist_snapshot snap
 WHERE Begin_Interval_Time > TO_DATE('17.05.2017','dd.mm.yyyy')
 ORDER BY Snap_Id DESC
 ```

## Змінити настройки

 ``` sql
 BEGIN
  DBMS_WORKLOAD_REPOSITORY.modify_snapshot_settings (
    INTERVAL    => 10, -- що 10 хв
    RETENTION   => 11520); -- скільки часу зберігати дані - 8 днів = 8 днів * 24 години * 60 хв.
END;
/
```

## Створити снапшот

[Manual Automatic Workload Repository AWR snapshot collection and retention](http://www.dba-oracle.com/t_awr_snapshot_definition.htm)

``` sql
EXEC dbms_workload_repository.create_snapshot;
```