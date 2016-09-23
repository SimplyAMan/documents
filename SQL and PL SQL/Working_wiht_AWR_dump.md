# Робота з AWR дампами

Для експорту дампу AWR використовується скрипт awrextr.sql.

> Якщо на комп'ютері встановлено повну версію клієнта Oracle, то існує каталог <ORACLE_HOME>\RDBMS\ADMIN\ в якому є різні цікаві скрипти.
Щоб кожен раз при виклику скрипта не вказувати повний шлях можна прописати змінну оточення SQLPATH. 
> Наприклад в мене ця змінна виглядає наступним чином:
> SQLPATH=c:\Oracle\product\11.2.0\client_1\RDBMS\ADMIN\

1. Підключаємось до бази даних:
```
sqlplus creator@b2testt.world
```

2. Запускаємо скрипт:
```
SQL> @awrextr.sql
```
Результат:
```
SQL> @awrextr.sql
~~~~~~~~~~~~~
AWR EXTRACT
~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~  This script will extract the AWR data for a range of snapshots  ~
~  into a dump file.  The script will prompt users for the         ~
~  following information:                                          ~
~     (1) database id                                              ~
~     (2) snapshot range to extract                                ~
~     (3) name of directory object                                 ~
~     (4) name of dump file                                        ~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Databases in this Workload Repository schema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   DB Id     DB Name      Host
------------ ------------ ------------
* 1322604750 WORKT        elara
* 1322604750 WORKT        db2tstdbu03

The default database id is the local one: '1322604750'.  To use this
database id, press <return> to continue, otherwise enter an alternative.

Enter value for dbid:
```
3. Нажимаємо "Enter"
Результат:
```
Using 1322604750 for Database ID


Specify the number of days of snapshots to choose from
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Entering the number of days (n) will result in the most recent
(n) days of snapshots being listed.  Pressing <return> without
specifying a number lists all completed snapshots.


Enter value for num_days:
```

4. Вводимо число за скільки днів нас цікавлять дані. Наприклад, за один день.
5. Отримуємо перелік доступних snapshot-ів і "пропозицію" ввести код snapshot з якого буде починатись вигрузка:
```
DB Name        Snap Id    Snap Started
------------ --------- ------------------
WORKT           117993 13 Тра 2016 05:30
                117994 13 Тра 2016 05:40
                117995 13 Тра 2016 05:50
                117996 13 Тра 2016 06:00
                117997 13 Тра 2016 06:10
                117998 13 Тра 2016 06:20
                117999 13 Тра 2016 06:30
                118000 13 Тра 2016 06:40
                118001 13 Тра 2016 06:50
                118002 13 Тра 2016 07:00
                118003 13 Тра 2016 07:10

DB Name        Snap Id    Snap Started
------------ --------- ------------------
WORKT           118004 13 Тра 2016 07:20
                118005 13 Тра 2016 07:30
                118006 13 Тра 2016 07:40
                118007 13 Тра 2016 07:50
                118008 13 Тра 2016 08:00
                118009 13 Тра 2016 08:10
                118010 13 Тра 2016 08:20
                118011 13 Тра 2016 08:30
                118012 13 Тра 2016 08:40
                118013 13 Тра 2016 08:50
                118014 13 Тра 2016 09:00

DB Name        Snap Id    Snap Started
------------ --------- ------------------
WORKT           118015 13 Тра 2016 09:10
                118016 13 Тра 2016 09:20


Specify the Begin and End Snapshot Ids
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Enter value for begin_snap:
```
6. Наприклад, нам потрібно зробити AWR дамп за 2 години: з 7:00 по 9:00:
```
Specify the Begin and End Snapshot Ids
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Enter value for begin_snap: 118002
Begin Snapshot Id specified: 118002

Enter value for end_snap: 118014
End   Snapshot Id specified: 118014
```
7. Також відобразиться перелік Oracle Directories:
```
Specify the Directory Name
~~~~~~~~~~~~~~~~~~~~~~~~~~

Directory Name                 Directory Path
------------------------------ -------------------------------------------------
ALFA_COLLECTION                /oracle/b2
ARC_CRITICALNBUFILES           /app/u01/oradata/dir/nbu_a
CAPDIR                         /app/u01/oradata/dir/capture
CAPDIR2                        /app/u01/oradata/dir/capture2
CRITICALNBUFILES               /app/u01/oradata/workt_t/dir/nbu
C_TEMP                         /app/u01/oradata/workt_t/dir/oshad
DATA_PUMP_DIR                  /app/u01/oradata/data_pump
DATAPUMP_DIR                   +elara_data/dmp
DBSTAT_DIR                     /home/oracle/scripts/dbstat
DIR_DP                         /app/u01/dmp
GOLDTEL                        /app/u01/oradata/dir/goldtel

Directory Name                 Directory Path
------------------------------ -------------------------------------------------
KDGSM                          /app/u01/oradata/workt_t/dir/kdgsm
KSGSM                          /app/u01/oradata/workt_t/dir/ksgsm
ORACLE_OCM_CONFIG_DIR          /app/oracle/11.2.0.4/ccr/state
ORACLE_OCM_CONFIG_DIR2         /app/oracle/11.2.0.4/ccr/state
OSHAD                          /app/u01/oradata/workt_t/dir/oshad
QUEST_SOO_ADUMP_DIR            /app/u01/oracle/admin/workt/adump/
QUEST_SOO_BDUMP_DIR            /app/u01/oracle/diag/rdbms/workt_center/workt/tra
                               ce/

QUEST_SOO_CDUMP_DIR            /app/u01/oracle/diag/rdbms/workt_center/workt/cdu
                               mp/

Directory Name                 Directory Path
------------------------------ -------------------------------------------------

QUEST_SOO_UDUMP_DIR            /app/u01/oracle/diag/rdbms/workt_center/workt/tra
                               ce/

TEMP_DIR                       /app/u01/tmp
T24                            /app/u01/oradata/dir/t24
WRR_TMP4874                    /app/u01/oradata/dir/capture/pp11.2.0.4.0

Choose a Directory Name from the above list (case-sensitive).

Enter value for directory_name:
```

8. По усній домовленості з DBA ми використовуємо каталог DIR_DP:
```
Enter value for directory_name: DIR_DP

Using the dump directory: DIR_DP

Specify the Name of the Extract Dump File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The prefix for the default dump file name is awrdat_118002_118014.
To use this name, press <return> to continue, otherwise enter
an alternative.

Enter value for file_name:
```

9. Вказуємо ім'я файла, або просто нажимаємо "Enter":
```
Enter value for file_name:

Using the dump file prefix: awrdat_118002_118014
|
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|  The AWR extract dump file will be located
|  in the following directory/file:
|   /app/u01/dmp
|   awrdat_118002_118014.dmp
| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|
|  *** AWR Extract Started ...
|
|  This operation will take a few moments. The
|  progress of the AWR extract operation can be
|  monitored in the following directory/file:
|   /app/u01/dmp
|   awrdat_118002_118014.log
|

End of AWR Extract
SQL>
```

10. Чекаємо деякий час поки скрипт на сервері надасть нам доступ на читання до файлу і копіюємо його собі на диск.
