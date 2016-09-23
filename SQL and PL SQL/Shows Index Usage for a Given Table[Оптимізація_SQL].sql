--
-- Shows Index Usage for a given table.  (All Indexes if 'ALL' is entered for Index_Name).
--
 
SET PAUSE ON
SET PAUSE 'Press Return to Continue'
SET PAGESIZE 60
SET LINESIZE 300
SET VERIFY OFF
 
SELECT table_name,
       index_name,
       used,
       start_monitoring,
       end_monitoring
FROM   v$object_usage
WHERE  table_name = UPPER('&Table_Name')
AND    index_name = DECODE(UPPER('&&Index_Name'), 'ALL', index_name, UPPER('&&Index_Name'))
/