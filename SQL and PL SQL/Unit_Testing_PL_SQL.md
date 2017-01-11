# Вибір framework для unit testing

## Побажання

## utPLSQL

Сайт: [utPLSQL](https://utplsql.github.io/)

## ruby-plsql-spec

"Сайт": [ruby-plsql-spec](https://github.com/rsim/ruby-plsql-spec)
[Блог Raimonds Simanovskis (засновник)](http://blog.rayapps.com/2009/11/27/oracle-plsql-unit-testing-with-ruby/)

[UTPLSQL vs. ruby-plsql](http://www.oraclethoughts.com/category/ruby-plsql/)
[Статті на тому ж сайті про тестування PL/SQL](http://www.oraclethoughts.com/category/testing/)

[Test Drive your Oracle database. Yes, it’s doable. And it’s fun!](http://www.oraclethoughts.com/testing/test-drive-your-oracle-database-yes-its-doable-and-its-fun/)

Pros:
- максимальна гнучкість
- скрипти можна зберігати в VCS (SVN, Git)

Conts:
- вимагає деяких знань в мові програмування Ruby

Проблеми (для подальшого аналізу):
``` ruby
# encoding: utf-8

require 'rspec'
require 'rubygems'
require 'ruby-plsql'
require './spec/fma_utils'

plsql.connection = OCI8.new('creator/f77f@b2testf.world')
plsql.eprlogin_second

puts plsql.pkc_fm.fma_dateoffirstacctclient
puts plsql.pkg_common.getsystemparamdef('FMA_DATEOFFIRSTACCTCLIENT', '0')
```

framework свариться на **plsql.pkc_fm.fma_dateoffirstacctclient**:
```
C:/Ruby22/lib/ruby/gems/2.2.0/gems/ruby-plsql-0.6.0/lib/plsql/package.rb:84:in `method_missing': No PL/SQL procedure or variable 'FMA_DATEOFFIRSTACCTCLIENT' found (ArgumentError)
```

а **plsql.pkg_common.getsystemparamdef('FMA_DATEOFFIRSTACCTCLIENT', '0')** проходить без проблем.

## Code Tester for Oracle

[Code Tester for Oracle – a component of the Toad Development Suite for Oracle](http://www.toadworld.com/products/code-tester)

Conts:
- треба ліцензію

## Oracle SQL Developer

[SQL Developer Documentation. Release 4.1](http://docs.oracle.com/cd/E55747_01/index.htm)

[SQL Developer: Unit Testing](http://docs.oracle.com/cd/E55747_01/appdev.41/e55591/sql-developer-unit-testing.htm#f1_unittesting_html)

Old:
- [Create a Unit Test Repositor](http://www.oracle.com/webfolder/technetwork/tutorials/obe/db/sqldev/r40/mod2_sqldev_v4/mod2_sqldev_v4.html#section6)
- [Create and Running a Unit Test](http://www.oracle.com/webfolder/technetwork/tutorials/obe/db/sqldev/r40/mod2_sqldev_v4/mod2_sqldev_v4.html#section7)

- The unit test repository is a set of tables, views, indexes, and other schema objects that SQL Developer maintains to manage the use of the unit testing feature.
- Кожен користувач може створювати репозиторій в своїй схемі

Pros:

Conts:
- повільно працює відображення об'єктів при створенні теста
- тяжко вияснити причину чому тест не проходить (не можна добавити відладочнку інформацію)
Наприклад, виникає помилка:

```
The following procedure was run.

Execution Call
BEGIN
 "CREATOR"."AWARD_BONUS"(EMP_ID=>:1,
  SALES_AMT=>:2);
END;

Bind variables used
:1              NUMBER          IN     (null)                                  
:2              NUMBER          IN     (null)                                  

Execution Results
ERROR
Expected exception: [NONE], Received: [1403: ORA-01403: данные не найдены
ORA-06512: на  "CREATOR.AWARD_BONUS", line 6
ORA-06512: на  line 2
]
```

рядок 6:
``` sql
  SELECT commission_pct -- line 6
    INTO commission
    FROM employees
   WHERE employee_id = emp_id;
```

Дані для теста формуються динамічно з таблиці і не зрозуміло через які дані виникло виключення.

Додаткова документація:
- [that JEFF SMITH. Optimizing your Oracle Database experience, mostly](http://www.thatjeffsmith.com/)
- [Unit Testing Stored Procedures](http://brainbaking.com/unit-testing-stored-procedures/)
- [SQL Test Driven Development with Oracle RDBMS](http://engineering.pivotal.io/post/oracle-sql-tdd/)