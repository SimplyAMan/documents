--
-- List Distinct SQL ID's for a Given Session
--
 
SET PAUSE ON
SET PAUSE 'Press Return to Continue'
SET PAGESIZE 60
SET LINESIZE 300
 
SELECT
   snap_id,
   sample_id,
   dbid,
   instance_number,
   sql_id,
   sql_plan_hash_value
FROM dba_hist_active_sess_history 
WHERE session_id=&Enter_Session_ID
AND sql_plan_hash_value IS NOT NULL
ORDER BY sql_id,sql_plan_hash_value
/