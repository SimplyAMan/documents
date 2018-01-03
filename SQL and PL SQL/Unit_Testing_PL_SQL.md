# Вибір framework для unit testing

## Загальні дані

Автоматизавані тести надають нам почуття впевненості що наша розробка працює як і було заплановано. Автоматизація надає можливість запускати тести необхідну кількість раз, причому проходження unit тестів показує розробнику що його зміни не поламали нічого що він не планував змінювати.

Це також означає, що якщо розробник виконує зміни в коді, то це має відобразитись в не пройдених тестах. Очікування що тест не буде пройдено і порівняння наших очікувань з результатами тестів дає нам підказку де ми могли не зрозуміти існуючий код, чи вплив наших змін на існуючий код.

Unit тести виконуються для того, щоб перевірити, що код робить саме те що розробник планував.

Тобто те що unit тести проходять без помилок, це не означає код робить саме те що хотів замовник. Це тільки доводить, що код робить те що планував розробник.

### Як писати unit тести

Перед тим як писати код потрібно подумати як в подальшому планується його тестувати.

Більше того можна спочатку писати unit тести для ще не існуючого коду, а вже потім писати сам код (TDD)

### Відмазки для не напискання unit тестів

Завжди можна знайти "причини", чому не можна, або не потрібно писати unit тести.

#### Це займає дуже багато часу

Насправді це не відповідає дійсності. Але щоб в цьому переконатись ми маємо придивитись де ж найбільше тратиться часу при написанні коду.

Багато людей вважає, що тестування це щось таке що виконується в кінці проекту. І справді, якщо починати писати unit тести коли все буде реалізовано, то це займе багато часу.

Це можна порівняти з прибиранням. Можна прибирати в будинку/квартирі коли вже немає вільного від сміння місця, а можна постійно підтримувати порядок.

Отже якщо ви вважаєте що в вас немає часу на написання тестів, то дайте собі відповідь на наступні питання:

1. Як багато часу ви витрачаєте на дебаг коду, що ви, або ваші колеги написали? Особливо якщо код написаний досить давно.
2. Як багато часу ви витрачаєте на переробку коду, що на вашу думку працює, але насправді містить баги?
3. Як багато часу ви витрачаєте для відділення самого багу від даних які його викликають?

#### Виконання тестів займає дуже багато часу

Правильно написані unit тести мають виконуватись швидко, так щоб ви могли запускати їх стільки раз скільки потрібно.

#### Це не моя робота тестувати код

Робота кожного з розробників, це написання правильно працюючого коду. Якщо ви передаєте на тестування код який не працює, то ви насправді погано виконуєте свою роботу.

Розробникам платять за те, щоб код працював і unit тести це всього лише інструмент для цього. Такий самий як IDE, або дебагер.

#### Я пережаваю за те, що залишу без роботи тестувальників

Unit тести пишуться не для ПМ, чи Product Owner-a, вони пишуться програмістами для програмістів.

На підставі проходження unit тестів не можна робити висновок що код працює так як хоче цього замовник. Саме для цього і потрібні тестувальники, які виконають і функціональне тестування, і інтеграційні, і можливо навантажувальне.

### Фази написання unit тестів

Unit тест має виконувати наступні речі:

- Настроїти всі умови, які потрібні для тестування (створення необхідних даних...)
- Викликати процедуру/функцію, що буде тестуватись
- Перевірити що отриманий результат відповідає очікуваному
- Відмінити все після закінчення тесту

### TDD

Unit тести використовуються в розробці при Test Driven Development (TDD).

Використовуючи TDD спочатку потрібно написати unit тести для перевірки функціоналу який ви реалізуєте. Спочатку всі ці тести мають не працювати і тоді потрібно написати код що буде проходити тести.

Ключовим в TDD є те, що ви маєте написати рівно стільки коду, щоб пройти тести. Не має бути іншого, зайвого коду. Коли всі тести пройдено, потрібно зробити рефакторінг коду для оптимізації його і почати цикл знову з написання нового тесту.

[Зачем нужны юнит-тесты](https://tproger.ru/translations/unit-tests-purposes/) - це переклад статті [Purposes of Unit Tests](http://arne-mertz.de/2015/05/purposes-of-unit-tests/) (сайт містить кілька статтей по юніт тестуванню і інших технологіях)

## Побажання

## utPLSQL

Сайт: [utPLSQL](https://utplsql.github.io/)

## ruby-plsql-spec

"Сайт": [ruby-plsql-spec](https://github.com/rsim/ruby-plsql-spec)
[Блог Raimonds Simanovskis (засновник)](http://blog.rayapps.com/2009/11/27/oracle-plsql-unit-testing-with-ruby/)

[UTPLSQL vs. ruby-plsql](http://www.oraclethoughts.com/category/ruby-plsql/)
[Статті на тому ж сайті про тестування PL/SQL](http://www.oraclethoughts.com/category/testing/)

[Test Drive your Oracle database. Yes, it’s doable. And it’s fun!](http://www.oraclethoughts.com/testing/test-drive-your-oracle-database-yes-its-doable-and-its-fun/)

[Testing Times – using ruby-plsql-spec for testing PL/SQL](https://mikesmithers.wordpress.com/2016/11/13/testing-times-using-ruby-plsql-spec-for-testing-plsql/)

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
- тяжко вияснити причину чому тест не проходить (не можна добавити відладочну інформацію)
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

## Додаткова документація

- [that JEFF SMITH. Optimizing your Oracle Database experience, mostly](http://www.thatjeffsmith.com/)
- [Unit Testing Stored Procedures](http://brainbaking.com/unit-testing-stored-procedures/)
- [SQL Test Driven Development with Oracle RDBMS](http://engineering.pivotal.io/post/oracle-sql-tdd/)
- [Automated Testing Frameworks and General Rule-Breaking in PL/SQL](https://mikesmithers.wordpress.com/2017/01/07/automated-testing-frameworks-and-general-rule-breaking-in-plsql)