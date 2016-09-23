SELECT * FROM DBA_SQL_PROFILES WHERE UPPER (sql_text ) LIKE '%DBT_RESERVE%';


BEGIN
  DBMS_SQLTUNE.alter_sql_profile (NAME             => 'WSAS_ARC_DOC_2',
                                  attribute_name   => 'STATUS',
                                  VALUE            => 'ENABLED');
END;
/