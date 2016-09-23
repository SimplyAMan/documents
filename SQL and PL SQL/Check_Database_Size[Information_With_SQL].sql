-- get Oracle database size from dba_data_files:
SELECT "Reserved_Space(GB)",
       "Reserved_Space(GB)" - "Free_Space(GB)" "Used_Space(GB)",
       "Free_Space(GB)"
  FROM (SELECT (SELECT SUM (bytes / (1014 * 1024 * 1024)) FROM dba_data_files)
                  "Reserved_Space(GB)",
               (SELECT SUM (bytes / (1024 * 1024 * 1024)) FROM dba_free_space)
                  "Free_Space(GB)"
          FROM DUAL);