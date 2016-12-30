# Стандарт кодирования отдела развития АБС "Б-2" Альфа Банк (Украина) для Oracle на SQL и PL\SQL

При написании стандарта кодирования как основа использовался стандарт кодирования для Oracle на SQL и PL\SQL компании CS Integra.

## Цели и область действия

Настоящий стандарт кодирования предназначен для внутреннего использования разработчиками отдела развития АБС "Б-2" для повышения читабельности исходного кода и облегчения его сопровождения.

Стандарт распространяется на все объекты базы данных, созданные сотрудниками отдела.

## Общие правила оформления кода

В наименовании процедур, функций, переменных, констант и т.д. необходимо использовать [CamelCase](https://ru.wikipedia.org/wiki/CamelCase).

После ключевого слова END, окончание пакета, процедуры или функции, необходимо прописывать наименование пакета/процедуры/функции.

В коде необходимо избегать использования [магических чисел](https://ru.wikipedia.org/wiki/%D0%9C%D0%B0%D0%B3%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%BE%D0%B5_%D1%87%D0%B8%D1%81%D0%BB%D0%BE_(%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5)) заменяя их на константы. При этом крайне желательно чтобы по наименованию константы можно было узнать её предназначение.

Например, код:
``` sql
SELECT d.Id
  FROM Deal d
 WHERE d.DealTypeId = 356
   AND d.DealState in (0,1)
   AND d.ContragentId = lContragentId;
```

необходимо заменять на
``` sql
SELECT d.Id
  FROM Deal d
 WHERE d.DealTypeId = pkc_Deal.ldtLoanOnTime
   AND d.DealState IN (pkc_Deal.DS_NotStarted,pkc_Deal.DS_Active)
   AND d.ContragentId = lContragentId;
```

Если в процесе работы над заявкой изменяется объект форматирование которого не соответсвует требованиям этого документа необходимо привести форматирование изменяемого объекта к актуальным требованиям по форматированию. При этом если изменяется только одна, или несколько функций/процедур пакета, то корректируется только их форматирование.

Например:
``` sql
  FUNCTION uses_summa_ondealtranche(
    in_dealid     NUMBER,
    in_account    VARCHAR2,
    in_date       DATE,
    in_currencyid NUMBER DEFAULT NULL)
  RETURN NUMBER
    IS
    result NUMBER;
  BEGIN

    BEGIN
      SELECT  NVL(SUM (incsumma - decsumma),0)
        INTO result
        FROM (SELECT ddt.dealid, ddt.valuedate,
                   DECODE (ddt.otbs, 0, ddt.usesumma, 0) incsumma,
                   DECODE (ddt.otbs, 1, ddt.usesumma, 0) decsumma, ddt.otbs
              FROM deal td, dealdoctransaction ddt, aaccount A,dealcommercialtranche dct
             WHERE td.ID = ddt.dealid
               AND td.valuedate <= in_date
               AND ddt.valuedate <= in_date
               AND ddt.accountid = A.ID
               AND A.accountno = in_account
               AND A.currencyid = NVL(in_currencyid,dct.currencyid)
               AND dct.dealid = in_dealid
               AND td.ID=dct.dealid
               );
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
         result:=0;
    END;

    RETURN result;

  END;
```

Переформатированный код:

- все наименования переменных преведены к одному виду
- если известен тип поля из которого извлекаются данные, то этот тип используется для переменной
- код и комментарий выровнены по блоках

``` sql
  FUNCTION Uses_Summa_OnDealTranche (
    in_DealId        NUMBER,
    in_Account       VARCHAR2,
    in_Date          DATE,
    in_CurrencyId    NUMBER DEFAULT NULL)
  RETURN NUMBER
  IS
    lResult   NUMBER;
  BEGIN
    IF in_Account IS NOT NULL THEN
      BEGIN
        SELECT NVL (SUM (IncSumma - DecSumma), 0)
          INTO lResult
          FROM (SELECT ddt.DealId,
                       ddt.ValueDate,
                       DECODE (ddt.OTBS, 0, ddt.UseSumma, 0) IncSumma,
                       DECODE (ddt.OTBS, 1, ddt.UseSumma, 0) DecSumma,
                       ddt.OTBS
                  FROM Deal td,
                       DealDocTransaction ddt,
                       Aaccount a,
                       DealCommercialTranche dct
                 WHERE td.ID = ddt.DealId
                   AND td.ValueDate <= in_Date
                   AND ddt.ValueDate <= in_Date
                   AND ddt.AccountId = a.ID
                   AND a.AccountNo = in_Account
                   AND a.CurrencyId = NVL (in_CurrencyId, dct.CurrencyId)
                   AND dct.DealId = in_DealId
                   AND td.Id = dct.DealId);
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          lResult := 0;
      END;
    ELSE
      lResult := 0;
    END IF;

    RETURN lResult;
  END Uses_Summa_OnDealTranche;
```

### Отступы, выравнивание, границы строки, переносы

Размер одного отступа по горизонтали – 2 пробела.

**Не разрешается использовать символы табуляции** (всегда отключайте соответствующую опцию в настройках редактора).

Максимальная длина строки – 80 символов. Если строка кода выходит за границу справа, желательно перенести ее часть на следующую строку и выдержать соответствующие отступы.

``` sql
PROCEDURE eprdocument_update_ex(rec IN OUT NOCOPY document%ROWTYPE)
AS
BEGIN
  pkg_document.eprdocument_update(rec.ID,
                                   rec.documentno,
                                   rec.documentdate,
                                   rec.bankdate,
                                   rec.documenttypeid,
                .....   
                                   rec.userkey
                                 );
END;
```

При переносе операторов необходимо делать отступы таким образом, чтобы логически связные группы, элементы перечисления размещались на одной вертикали в соответствии со своим уровнем вложенности в конструкции.

Старайтесь делать переносы только тогда, когда логически связная подстрока кода не умещается на одной строке текста:

``` sql  
     SELECT NVL(TRIM(SUBSTR (a.description, 1, 38)), c.sname),
            DECODE(c.countryid,
                   pkg_common.defcountrycode, NULL,
                   c.countryid
                  )
       FROM aaccount a, contragent c
      WHERE a.accountno LIKE TO_CHAR (ftransbaccid) || '_' || faccmask
        AND a.currencyid = acurrencyid
        AND a.contragentid =
               DECODE(ftransacccommon,
                       '1', a.contragentid,
                       acontragentid
                      )
        AND a.baccountid = ftransbaccid
        AND a.accountstateid NOT IN
            (pkg_common.accsreserv, pkg_common.accsclosed)
```

### Расстановка отступов, скобок, операторов, комментариев

Арифметические операторы, операторы сравнения рекомендуется всегда выделять пробелами с обеих сторон. Оператор присвоения выделяется обязательно.

``` sql
a + b * c – 5.01 / 6

(b + a) * d
```

После каждой запятой при перечислении параметров, элементов массива и др. необходимо ставить пробел.

Точка с запятой, круглые и квадратные скобки не выделяются пробелами.

Двоеточие (не в операторе присвоения) не отрывается от текста слева, после двоеточия делается пробел.

Желательно при переносе закрывающей скобки (круглой или квадратной) в отрыве от содержания выражения устанавливать отступ, выровненный по открывающей скобке.

``` sql
TheProc(param1, param2, param3,
        param4, param5);

TheProc(param1, 
        param2, 
        param3,
       );
```

При записи длинных констант-строк оператор конкатенации появляется только в том случае, если строка выходит за границу сраницы справа (80 символов от левого края). Желательно переносить оператор конкатенации на новую строку, а не оставлять на предыдущей. Такой код проще читать и комментировать.

``` sql
dmbs_output.put_line(
     'текст в скрипте который очень важен и очень длинный, ну очень длинный,' 
  || ' больше 80 символов и использует конкатенцию чтобы вместится в 80'
  || ' символов')
```

Для одно- и двухстрочных комментариев рекомендуется всегда использовать сокращенную нотацию:

-- это комментарий
-- это вторая строка комментария

При создании коментариев используються те же принципы форматирования что и для блока кода к которому они относятся.

*Пример не соблюдения отступа для блока кода в коментариях*
``` sql
    BEGIN
-- ищем код счета - так нельзя, коментарий должен иметь тот же отступ что и SELECT
      SELECT aa.Id
        INTO lId
        FROM Aaccount aa
       WHERE aa.AccountNo = pAccountNo
         AND aa.CurrencyId = pCurrencyId;
    EXCEPTION    
      WHEN NO_DATA_FOUND THEN
        lId := NULL;
    END;
```

*Пример не соблюдения ограничения длины строки*
``` sql
    BEGIN   
      SELECT aa.BAccountId
        INTO lBAccountId
        FROM Aaccount aa
       WHERE aa.Id = 123456;
      IF lBAccountId = 2620 THEN
        lMessage := 'Same message for BAccount 2620'; -- требования заявки CR-123456 после пользовательского тестирования
      ELSE
        lMessage := 'Same message for another BAccount';
      END IF;
    EXCEPTION    
      WHEN NO_DATA_FOUND THEN
        lBAccountId := NULL;
    END;
```

Не засоряйте модули закомментированным старым кодом. Это ухудшает читабельность кода.

В банке используется система контроля версий с помощью которой, при необходимости, можно получить предыдущую версию файла. 

## Наименование елементов кода

При наименовании переменных, констант или объектов базы данных должен использоваться Camel Case.

***Чи потрібно узгоджувати як мають називатись:

1. змінні (l_variable, lVariable, aVariable), чи просто "в рамках одной процедуры/функции в наименовании переменных должен использоваться одинаковый принцип."
2. параметри процедур і функцій (p_Parameter, pParameter, Parameter)
2. константи
3. явні курсори
4. типи даних (окремі і всередині пакетів)***

При наименовании переменных, констант, явных курсоров и типов данных внутри пакета, в уже существующих пакетах, процедурах и функциях, необходимо придерживатся того же принципа которых был использован изначально.

Например, если в процедуре наименование переменных начинается с символов 'l_', то и новосозданные переменные должны начинаться с этих же символов.

## Наименование объектов

Для возможности простой идентификации объектов созданных в банке эти объекты должны содержать слово **Alfa**.

При этом если создается функция, или процедура внутри пакета, то слово **Alfa** должно быть только в наименовании пакета. Даже если функция/процедура была создана перенесением отдельного объекта в пакет.

### Таблицы, ключи, прочие поля

### Типы данных

### Ограничения, Constraints

### Обзоры

### Процедуры и функции

### Пакеты

## Последовательности (Sequences)


## Структура SVN отдела развития АБС Б2

### Общие требования к работе с SVN

Разработка DDL и DML скриптов должна вестись в файлах и сохранятся в SVN. Это существенно уменьшает возникновление конфликтов при пересоздании тестовых баз данных, установки завки в продуктив, а также позволяет вести анализ изменения объектов разными разработчиками и по разных заявках.

При выполнении commit'ов в SVN комментарий необходимо начинать с указания кода заявки CR, и кода BUG, если изменения относятся к исправлению, (для подтягивания в раздел Subversion Commits в заявке JIRA), а также короткое описание доработки/изменения.

**Не допускаются комментарии которые содержат только номер заявки.**

**Переименование и перемещение** уже существующих объектов необходимо делать средствами Tourtoise SVN, а не средствами ОС (желательно предварительно проверить на тестовом SVN).

В каждом создаваемом SQL скрипте должна присутствовать **"шапка"** вида: 

``` sql
/********************************************************************************
Название:   ...
Назначение: .....
Версия:     $Rev$

История изменений:
Дата        Автор                 Описание
----------  --------------------  ---------------------------------------------

********************************************************************************/
```

Чтобы "шапка" сохранилась в объекте базы данных, а не только в SVN необходимо указывать "шапку" после строки с `create or replace`.

В свойствах SQL-файлов необходимо **добавлять ключевое слово "Rev"**, иначе макрос $Rev$ работать не будет.

Поскольку ключевые слова можно добавлять только для файлов находящихся в репозитарии, то, чтобы избежать излишнего выполнения Commit, нужно сразу после создания файла, **до commit'а в репозиторий**, выбрать в контекстном меню файла пункт "TortoiseSVN"->"Add..." (это добавит созданный файл в репозиторий), а потом уже зайти в свойства файла и добавить ключевое слово "Rev"как описано в [SVN Quick Start User Guide](http://confluence.forum.kiev.ua.alfabank/display/systems/SVN+Quick+Start+User+Guide)

### Структура SVN

Структура каталогов SVN содержит два каталога:

- **trunc** - основная ветка каталога
- **branch** - ветка для изменения существующих объектов базы даных

### Ветка trunc

Ветка содержит следующие каталоги

: Структура ветки **trunc**

| Каталог    | Предназначение                                      |
| :--------- | :-------------------------------------------------- |
| **CR**         | Содержит подкаталоги по номерах заявок типа CR. В подкаталогах размещаются разовые патчи, которые не создают объекты, а также скрипты для создания объектов вендора которые войдут в последующие ХФ/релизы.  |
| **OBJ**        | Каталог объектов (процедуры, функции, пакеты, таблицы, представления и т.д.) |
| **Operations** | Дампы операций                                      |
| **PBM**        | Скрипты разработанные в рамках PBM                  |
| **Releases**   | Каталог содержит подкаталоги номеров версий релизов/ХФ от вендора. Служит для патчей которые исправляют баги обнаруженные во время установки, или тестирования релиза/ХФ.                       |
| **Reports**    | Внутрибанковские отчеты                             |
| **SD**         | Содержит скрипты исправлений инцедентов             |
| **Tools**      | Содержит скрипты для загрузки дампов, создания простых задач, и т.д. |



#### Общие требования к DDL объектов (trunc/OBJ)

Имя файла содержащего DDL объекта Oracle должно совпадать с именем этого объекта. При этом в наименовании файла необходимо использовать [CamelCase](https://ru.wikipedia.org/wiki/CamelCase)

Если объект создается не в схеме CREATOR, то в имя файла добавляется соответствующий префикс с точкой.

**Subversion различает названия файлов в разном регистре! Хотя в локальной копии под Windows файлы с наименованиями в разном регистре не различимы, при выполнении commit файлы *pkg_alfa_over.sql* и *PKG_ALFA_OVER.sql* считаются разными!**

DDL для разработанных банком таблиц и индексов для промышленной эксплуатации необходимо создавать с указанием табличного пространства B2_ALFA_DAT.

DDL таблиц и индексов для временного использования необходимо создавать с указанием табличного пространства B2_TMP_DAT (названия таблиц начинаются со слова ALFA_TMP*...)

<!-- 
* Желательны также комментарии входных/выходных параметров в процедурах и функциях (по крайней мере тех, чье название не очевидно отображает смысл).
* В таблице, представлении - общий комментарий и комментарии для полей.
 -->

#### "Нумерация" разработчиков
<a name="developer_code"></a>
Для избежания конфликтов при установке в продуктив в файлах отчетов, операций и простых задач используется "личная цифра" разработчика:

- 00 - Усенко;
- 01 - Новоставский;
- 02 - Булавинов;
- 03 - Гурын;
- 07 - Гаюк;
- 08 - Наумяк;
- 09 - Лишнянский;
- 10 - Емельянов;
- 11 - Громов (отдел интеграционных решений); 
- 12 - Животовский (отдел интеграционных решений);
- 14 - Гребень 
- 15 - сотрудники управления операционного дня банка;
- 20 - Булавинов;

#### Отчеты

Отчеты хранятся в файлах с указанием альтернативного ключа в имени файла с префиксом 'R_'. 

Альтернативный ключ формируется в виде `3XXNNNN`, где

- '3' - фиксированная часть ключа для отчетов отдела развития АБС
- 'XX' - ["личная цифра" разработчика](#developer_code)
- 'NNNN' - номер заявки CR в рамках которой был создан отчет. Если в рамках заявки было создано несколько отчетов, то к имени файла добавляется символ подчеркивания и порядковый номер отчета в заявке. При последующих доработках в рамках других заявок номер отчета менять не нужно. Если дорабатывается существующий отчет, у которого альтернативный код не удовлетворяет вышеописанным требованиям - возможно изменение альтернативного кода (и имени файла в SVN), так как при импорте отчета в продуктиве все равно потребуется удалить старую версию (отчеты, не имеющие внутреннего кода, Б2 обновлять не умеет).

В поле "История" отчета в Б2 - обязательно указание разработчика и, желательно, номера заявок, по которым он дорабатывался.

Если отчет при вызове использует шаблон из сетевого каталога, то в нем нужно использовать константу банка **AlfaReportPath** - для продуктива там будет храниться значение каталога **O:\ODBShablon**, для тестовой системы - **O:\ODBShablonTest**. В SVN шаблоны для таких отчетов хранятся в каталоге [/Reports/ODBShablon](http://flink.forum.kiev.ua.alfabank/svn/common/projects/B2/trunk/Reports/ODBShablon).

#### Операции

**Нумерация операций** осуществляется следующим способом:

- для ручных операций берется минимальное свободное значение поля ID из таблицы "operation";
- номера операций, которые будут использоваться в батчах нумеруются согласно маске **8XXNN** где XX - ["личный код" разработчика](#developer_code), NN - порядковый номер;
- номера технологических операций формируются согласно маске **9XXNN** где XX - "личный код" разработчика (тот же что и для отчетов), NN - порядковый номер.

**Дампы операций** хранятся в отдельном каталоге с именем равным номеру операции. Актуальные скрипты для импорта/экспорта операций хранятся в единичном экземпляре в каталоге [SVN /Tools/ExchOper](http://flink.forum.kiev.ua.alfabank/svn/common/projects/B2/trunk/Tools/ExchOper). 

Рядом с дампом операции, при необходимости, сохраняем скрипт наполнения ALPHA_OPERCHECK, который должен быть кумулятивным (т.е. сначала очищать все проверки по операции а потом наполнять заново). Наименование скрипта должно совпадать с кодом операции. (Об использовании таблицы ALPHA_OPERCHECK можно почитать в [Confluence](http://confluence.forum.kiev.ua.alfabank/display/systems/Alpha_OpCheck+Procedure))

Для поиска свободных номеров операций можно использовать скрипт:

``` sql
SELECT *
  FROM (    SELECT LEVEL + 99000 r1
              FROM DUAL
        CONNECT BY LEVEL < 1000) A
 WHERE NOT EXISTS
          (SELECT 1
             FROM operation o
            WHERE A.r1 = o.ID) {code} или {code:sql}WITH tmp AS ( SELECT LEVEL AS ID
                FROM dual
             CONNECT BY LEVEL <= 99999)
SELECT *
  FROM tmp             
 WHERE tmp.ID BETWEEN 99000 AND 99999
   AND tmp.ID NOT IN (SELECT o.ID FROM Operation o)
```

#### Простые задачи

**Простые задачи** Б2 нумеруются согласно маске  *5XXNNN* где XX - "личный код" разработчика, NNN - порядковый номер (тот же что и для отчетов). Допускается группировать связанные задачи на усмотрение разработчика. 

При разработке простых задач рекомендуется создать простую задачу на тестовой схеме, и с помощью скрипта [MakeTaskInstall](http://flink.forum.kiev.ua.alfabank/svn/common/projects/B2/trunk/Tools/TaskExport) создать установочный патч, который будет содержать все необходимые команды для создания простой задачи, ее полей, системных фильтров, операций и связей. Также, опционально, патч может содержать выдачу прав на задачу группе CREATOR. 

Известные ограничения **MakeTaskInstall.sql**:
- Не экспортируются настройки колонок системных фильтров (т.к. хранятся в CLOB), а также не создаются никакие объекты Oracle (скрипт генерит только DML-код).
- Если две создаваемые простые задачи имеют перекрестные связи, придется выделять содание связей в отдельные скрипты.
- Если вы изменяете существующую задачу, то результирующий патч нужно корректировать вручную. **Не рекомендуется удалять задачу т.к. на нее могут быть выданы права пользователям.**

**Иногда обнаруживается отставание sequence *GenEntityLink_Usr* от *EntityLink.Id* - вероятно "происки CS", т.к. задачи с EntityLink.Id > GenEntityLink_Usr явно "не наши". Для исправления такой проблемы нужно единоразово "докрутить" sequence (нужный для этого код закомментирован в скрипте)**

<!-- {info:title=.
{info}
 -->
<!-- ## Предполагаемая структура каталогов
{flowchart}
rankdir=LR
trunk
Obj
Reports
Operations
CR
trunk -> CR
trunk -> Operations
trunk -> Reports
trunk -> Obj
trunk -> Tools
trunk -> Releases
Reports -> ODBShablon
Obj -> Tables
Obj -> Views
Obj -> Triggers
Obj -> Functions
Obj -> Procedures
Obj -> Packages
Obj -> Sequences
Obj -> Links
Obj -> Type
CR -> "CR-1"
CR -> "CR-2"
CR -> "CR-..."
Operations -> "101.dmp"
Operations -> "102.dmp"
Operations -> "..."

{flowchart} -->

### Ветка branch
<a name="branch"></a>
В случае, если в рамках заявки требуется изменение существующего объекта, то для поддержания стабильности ветки **trunc** необходимо делать ответвление файла который содержит код создания объекта в ветку SVN **branch**.

Для этого перед началом изменения объекта разработчик делает ответвление файла из ветки **trunc** с помощью команды [Branch/Tag](https://tortoisesvn.net/docs/release/TortoiseSVN_ru/tsvn-dug-branchtag.html). URL ответвления должен иметь следующий вид - branch/\<номер заявки\>, где номер заявки это номер заявки по которой делается изменение объекта.

Именно этот файл прописывается в документации и отдается в ИТ-тестирование. В этом же файле фиксируются исправления ошибок по заявке. 

После окончания пользовательского тестирования разработчик делает слияние изменений из файла ответвления в файл ветки **trunc** (делает **merge**). 

Необходимо иметь ввиду, что команда SVN **merge** очень часто завершается с конфликтами, которые требуют принятия ручного решения. В большинстве случаев проще сравнить два файла и по разнице сделать ручной "merge".

> Если за время которое заявка по которой делался branch тестировалась были изменения этого объекта в trunc, то желательно перед выполнением тестирования внести изменения которые делались в ветке **trunc** в файл в ветке **branch**.

После окончания выполнения **merge** новая ревизия прописывается в документации и о необходимости проведения smoke тестирования уведомляется тестировщик заявки.

После успешного выполнения smoke тестирования тестировщик должен отписаться в заявке о результатах smoke тестирования с указанием какие ревизии были перетестированны.


## Использование типовых шаблонов в коде SQL и PL\SQL

### Использование SQL в коде

Советы Steven Feuerstein:

> Перестаньте писать много SQL! Каждое SQL выражение это хард код существующей структуры данных. 
> Не повторяйте то же SQL выращение.
> Держите SQL полностью отдельно от кода приложения.
> Вместо этого создавайте и используйте API функции и процедуры в которых спрятаны SQL выражения.

Большим плюсом вынесения работы с SQL в отдельные "API" процедуры/функции является то, что увеличивается количество одинаковых DML конструкций, что в итоге уменьшает количество «hard parse», а значит уменьшит загрузку CPU и памяти (SGA). 

Необходимо иметь ввиду, что hard parse будет выполнятся даже если DML визуально похожи и это может существенно влиять на производительность:

``` sql
SELECT a.Id INTO lId FROM Aaccount a WHERE a.AccountNo = lAccountNo AND a.CurrencyId = lCurrencyId;
select a.id into lId from aaccount a where a.AccountNo = lAccountNo and a.currencyid = lCurrencyId;
Select a.id into lId From aaccount a Where a.AccountNo = lAccountNo and a.currencyid = lCurrencyId;
```

Это не значит что все SQL выражения должны быть вынесены в отдельные процедуры и функции. 

Но если необходимо вставлять/обновлять/удалять данные в таблице, то почему это нельзя вынести в отдельную процедуру?
Если необходимо получать данные о контрагенте, то почему не использовать универсальную функцию?

### Поиск и работа с отдельными записями в таблице

При выборке единичной записи с помощью SELECT INTO не забывайте о возможности возникновения ошибок NO_DATA_FOUND и TOO_MANY_ROWS. 

Если необходимо в коде PL\SQL просто проверить наличие значения в таблице, используйте такой шаблон:

``` sql
select count(1) 
  into lRes 
  from aaccount 
 where AccountNo like lID || '%' 
   and RowNum = 1; -- ограничение по количеству получаемых данных
```

Если нужно извлечь некоторый идентификатор сущности из таблицы, а при его отсутствии создать новую сущность, то есть два варианта:

1. если все данные для вставки уже готовы, просто выполните INSERT и пусть, если заданное значение уже существует, возникнет исключение (primary key violated и т.п.); 
2. если подготовка данных для вставки занимает много времени, лучше сделать предварительный запрос UPDATE ... RETURNING или SELECT INTO с учетом возможного NO_DATA_FOUND. 


## Думки

- Add labels to the END statements of all your packages, procedures, functions, etc. It is a small thing that greatly aids in readability.
- Rely on a single, generic error manager utility to raise, handle and log errors.
Individual developers should never waste their time calling DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (though you should definitely know what that is!) or writing inserts into log tables. You end with total chaos and inconsistent information for both users and support. The best way to avoid this is to rely on a single utility.
- Stop writing so much SQL! Every SQL statement is a hard-coding of the current data structures. Don't repeat the same logical SQL statement. Keep SQL out of application-level code entirely. Instead, generate/build and rely on APIs (tablelevel, transaction-level) that hide SQL statements behind procedures and functions.
- Write tiny, little chunks of code (J). Use top-down design, combined with reusable code and local subprograms (procedures and functions declared within another procedure or function), to make sure that your executable sections have no more than 50 lines of code in them. Define your subprograms at the package level if they need to be used by more than one program in that package or outside of that package.
-  I also recommend that you avoid any OUT or IN OUT parameters for a function – it should return information only through the RETURN clause. If the function needs to return multiple values, group those values together as a record type and return a record based on that type. If such a transformation seems unnatural then maybe you should be writing a procedure.

- не допускается использование нескольких возвращаемых значений в функциях. Для таких случаев необходимо использовать процедуры
- в функциях точка возврата значения должна быть одна

## Литература

[Стандарт кодирования для Oracle на SQL и PL\SQL. Компания CS](http://confluence.forum.kiev.ua.alfabank/download/attachments/28118385/%D0%A1%D1%82%D0%B0%D0%BD%D0%B4%D0%B0%D1%80%D1%82+%D0%BA%D0%BE%D0%B4%D0%B0+SQL.doc)

[PL/SQL Naming Conventions and Coding Standards - Steven Feuerstein 2009](https://community.oracle.com/docs/DOC-1007838)

[Coding Standards for SQL and PL/SQL - William Robertson](https://oracle-base.com/articles/misc/naming-conventions)

[ORACLE-BASE / Tim Hall / Oracle Naming Conventions](https://oracle-base.com/articles/misc/naming-conventions)

[Trivadis PL/SQL and SQL Coding Guidelines Version 2.0](http://www.trivadis.com/sites/default/files/downloads/PLSQL_and_SQL_Coding_Guidelines_2_0_HiRes.pdf)

[Ask Tom on Naming Conventions](https://asktom.oracle.com/pls/apex/f?p=100:11:0::::P11_QUESTION_ID:6729304326802)

[PL/SQL and SQL naming conventions](http://www.oraclethoughts.com/sql/plsql-and-sql-naming-conventions/)

[Oracle SQL and PL/SQL Coding Standards – Cat Herding for Dummies](https://mikesmithers.wordpress.com/2011/10/22/oracle-sql-and-plsql-coding-standards-%E2%80%93-cat-herding-for-dummies/)

[Slideshare Presentation on PL/SQL Coding Conventions](http://www.slideshare.net/little.frank.yu/plsql-coding-conventions-6726050)