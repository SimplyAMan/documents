# Призначення

Потрібна інформація про тривалість виконання АРІ, яке написано в відділі.

Дана інформація допоможе:
- швидше ідентифікувати проблему зниження продуктивності АРІ;
- ідентифікувати вх.параметри при яких відбувається зниження продуктивності АРІ;
- аналізувати зміни в продуктивності АРІ після встановлення в продуктив доробок.

# Таблиця
| Поле          | Призначення   |  Принцип отримання |
| ------------- | ------------- | ------------------------- |
| Id            | Код           | Має генеруватись sequence |
| Object        | Яка процедура викликалась | Потрібно передавати процедурі (неможливо отримати вибіркою) |
| Parametrs     | Вхідні параметри | Потрібно передавати процедурі |
| UserName      | Користувач під яким викликалось (User) | Результат функції User |
| B2UserName    | Користувач під яким викликалось (pkg_common.UserRec.UserName) | pkg_common.UserRec.UserName |
| OsUser        | | |
| OsMachine     | Комп'ютер з якого викликалось | Контекст |
| StartTime     | Час виклику | |
| FinishTime    | Час закінчення виконання | |
| Differences (?)  | Скільки виконувалось (час закінчення виконання - час виклику) ms | |
| SubTypeId     | Підсистема (1 - контрагенти, 2 - кредити, 3 - CSense, ..., 99 - інше (по замовчуванню))| | 
| message       |  | |
| err_message   | Повідомлення про помилку | Має сенс тільки в блоці exception |
| RowType       | Тип запису (0 - все ОК, 1 - помилка) | if err_message is not null then 1 else 0 |

# Використання

``` sql
create or replace procedure test(
    pParametr1  varchar,
    pParametr2  number)
is
  lId         pls_integer;
  lParametrs  varchar2(4000);
  lMessage    varchar2(4000);
begin
  lId := pkg_Alfa_Log.Init(
            pObject     => 'test',
            pParametrs  => 'pParametr1 => ' || pParametr1 || chr(10) ||
                           'pParametr2 => ' || pParametr2 || chr(10));

  // some code
  lMessage := lMessage || 'after some code we have some status' || chr(10);

  // some code
  lMessage := lMessage || 'after another some code we have something else' || chr(10);

  pkg_Alfa_Log.Finish(
    pId        => lId
    pMessage   => lMessage);
exception
  when others then
    pkg_Alfa_Log.Finish(
      pId        => lId
      pMessage     => lMessage,
      pErr_Message => SQLCODE || SQLERRM || chr(10) || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      raise;
end;
```

# Обмеження

- Неможна використовувати в масових операціях, наприклад on-line створення документів в Б-2.