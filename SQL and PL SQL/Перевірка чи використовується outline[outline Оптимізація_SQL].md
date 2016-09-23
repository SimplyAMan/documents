Вчора, 17.12.2015, стикнулись з проблемою, що:
``` sql
SELECT *  FROM vDBT_RESERVE  WHERE ARCDATE =  :VAR0
```
довго працює. 
Причому cost для селекта дорівнював 158, оптимізатор використовував *FIRST_ROWS*. 
Якщо ж глянути в настройки оптимізатора в таблиці users для користувача, який запустив відкриття форми для розрахунку резервів по 23 постанові, то там стоїть *ALL_ROWS*
Прописали в vDBT_RESERVE примусово хінт для *ALL_ROWS* - не допомогло. План далі був по *FIRST_ROWS*.
Крім того cost в 158 для таблиці в якій 739 194 029 записів, по не РК був дуже підозрілий.

Як виявилось супроводом був створений outline для цього селекта.
І саме головне, що може пригодитись кожному, **як це знайшли**.

Шукаємо sql_id для цього селекта:
``` sql
SELECT Sql_Id, Sql_Text
  FROM v$sql
 WHERE sql_text LIKE '%vDBT_RESERVE%';
 ```
 
 Дивимось один з планів:
 ```
 SELECT * 
  FROM TABLE(dbms_xplan.display_cursor(sql_id => '1d7fzubcatk68'));
```

В низу плану можна побачити фразу:
 ```- outline "RES_FORM" used for this statement```
   
Перевіряємо що outline є
``` sql
SELECT CATEGORY,
       ol_name NAME,
       DECODE (BITAND (flags, 1),  0, 'UNUSED',  1, 'USED') used,
       DECODE (BITAND (flags, 4),  0, 'ENABLED',  4, 'DISABLED') enabled,
       hintcount hints,
       sql_text
  FROM outln.ol$
 WHERE ol_name = 'RES_FORM';
```

тоді 
```
ALTER OUTLINE RES_FORM DISABLE; 
-- або
DROP OUTLINE RES_FORM;
```
І можна переконатись, що при наступному запуску план буде "трошки" інший :-)

Повну переписку можна глянути в [B2.ALPHA-223840](https://www.csltd.com.ua/bt/?bug=B2-223840)