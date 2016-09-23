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

