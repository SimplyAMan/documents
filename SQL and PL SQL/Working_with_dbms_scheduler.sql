-- запущені джоби через dbms_scheduler
SELECT
   rj.job_name,
   s.username,
   s.SID,
   s.serial#,
   P.spid,
   s.lockwait,
   s.logon_time
FROM 
   dba_scheduler_running_jobs rj,
   v$session s,
   v$process P
WHERE
   rj.session_id = s.SID
AND
   s.paddr = P.addr
ORDER BY
   rj.job_name;
   
SELECT Job_Name, State, Next_Start_Date
  FROM user_SCHEDULER_JOB_DESTS
 WHERE Job_Name = 'OFFLINE_FMA_CREATE';   
   
-- зупинка 
BEGIN
  DBMS_SCHEDULER.STOP_JOB('OFFLINE_FMA_CREATE');
END;
/   

-- запуск
BEGIN
  DBMS_SCHEDULER.run_JOB('OFFLINE_FMA_CREATE',
                          use_current_session => FALSE);
END;
/ 
   