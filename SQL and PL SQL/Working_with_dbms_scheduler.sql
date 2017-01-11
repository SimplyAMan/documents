-- запущені джоби через dbms_scheduler, які виконуються
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
   
-- Перевірка, що таск створився
SELECT * 
  FROM dba_parallel_execute_tasks
 WHERE Task_Name = 'OFFLINE_FMA_CREATE'
/
-- Не оброблені чанки
SELECT Status, COUNT(*)
  FROM dba_parallel_execute_chunks ch WHERE ch.status <> 'PROCESSED'
  AND ch.TASK_NAME = 'OFFLINE_FMA_CREATE'
 GROUP BY Status
/

-- інформація по джобах таска
SELECT *
  FROM dba_scheduler_job_run_details
 WHERE job_name LIKE (SELECT job_prefix || '%'
                      FROM   dba_parallel_execute_tasks
                      WHERE  task_name = 'REBUILDDICTIONARIESBYADDRESS2')
/                      

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
  

--Убивает таск.
BEGIN
  DBMS_PARALLEL_EXECUTE.DROP_TASK(task_name => 'OFFLINE_FMA_CREATE');
END;
/  