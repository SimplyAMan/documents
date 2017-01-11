# Мета розробки

Потрібна можливість збору інформації про тривалість виконання АРІ, яке написано в відділі.

Дана інформація допоможе:
- швидше ідентифікувати проблему зниження продуктивності АРІ;
- ідентифікувати, що проблема справді на стороні Б-2, а не на стороні шини;
- ідентифікувати вх.параметри при яких відбувається зниження продуктивності АРІ;
- аналізувати зміни в продуктивності АРІ після встановлення в продуктив доробок (потрібно буде додатково писати код для аналізу)

# Обмеження

В принципі логування має відпрацьовувати за час співрозмірний з виконанням EprSyslog_Insert2, але все ж не бажано використовувати в масових операціях, так як це потенційно може знизити час виконання операції.

# Опис

# Таблиця

**Alfa_syslog** (???):

| Поле          | Призначення   |  Принцип отримання |
| ------------- | ------------- | ------------------------- |
| Id            | Код           | Має генеруватись sequence |
| Object        | Яка процедура викликалась | Потрібно передавати процедурі (неможливо отримати вибіркою) |
| Parametrs     | Вхідні параметри | Потрібно передавати процедурі |
| UserName      | Користувач під яким викликалось (User) | Результат функції User |
| B2UserName    | Користувач під яким викликалось (pkg_common.UserRec.UserName) | pkg_common.UserRec.UserName |
| OsUser        | | |
| COMPUTERNAME     | Комп'ютер з якого викликалось | Контекст |
| SessionId     | | |
| StartTime     | Час виклику | |
| FinishTime    | Час закінчення виконання | |
| Elapsed       | Скільки виконувалось (час закінчення виконання - час виклику) ms | |
| SubTypeId     | Підсистема (1 - контрагенти, 2 - кредити, 3 - CSense, ..., 99 - інше (по замовчуванню))| | 
| err_message   | Повідомлення про помилку | Має сенс тільки в блоці exception |
| RowType       | Тип запису (0 - все ОК, 1 - помилка) | if err_message is not null then 1 else 0 |

# Використання

``` sql
create or replace procedure test_ws(
    pParametr1  varchar,
    pParametr2  number)
is
  lId         pls_integer;
  lParametrs  varchar2(4000);
  lMessage    varchar2(4000);

  -- exception user requested cancel of current operation
  e_cancelled EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_cancelled, -1013);  
begin
  -- функція повертає код який згенерований sequence
  -- дані про об'єкт, параметри, користувачів, час запуску... має зберігатись в колекцію
  -- Alfa_syslog%rowtype
  -- запис в таблиці не має виконуватись!!!
  lId := pkg_Alfa_Log.Init(
            pObject     => 'test',
            pParametrs  => 'pParametr1 => ' || pParametr1 || chr(10) ||
                           'pParametr2 => ' || pParametr2 || chr(10));

  -- виклик внутрішнього АРІ, яке є або в цьому пакеті, або в іншому

  -- шукаємо по коду запис в колекції, добавляємо в нього FinishTime і решту даних
  -- зберігаємо запис в Alfa_syslog і видаляємо його з колекції
  -- всі операції, крім запису в Alfa_syslog, мають відбуватись в пам'яті. 
  -- тобто потенційно це не має тормозити функціонал.
  pkg_Alfa_Log.Finish(
    pId        => lId);
exception
  -- видно треба
  when e_cancelled then
    -- в даному випадку RowType це 1
    pkg_Alfa_Log.Finish(
      pId          => lId,
      pErr_Message => 'catched exception ''user requested cancel of current operation''' || chr(10) 
                   || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      raise;
  when others then
    -- в даному випадку RowType це 1
    pkg_Alfa_Log.Finish(
      pId          => lId,
      pErr_Message => SQLCODE || SQLERRM || chr(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      raise;
end;
```

