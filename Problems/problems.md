# Задачі

## Задача про акции Apple
[Оригінал](https://tproger.ru/problems/stock-apple/)

Задача, которую давали на собеседованиях в Apple. От вас требуется написать функцию, которая возвращает максимальную прибыль от одной сделки с одной акцией (сначала покупка, потом продажа). Исходные данные — массив вчерашних котировок stock_prices_yesterday с ценами акций Apple. 

Информация о массиве:
- Индекс равен количеству минут с начала торговой сессии (9:30 утра).
- Значение в массиве равно стоимости акции в это время.
Например: если акция в 10:00 утра стоила 20 долларов, то
stock_prices_yesterday[30] = 20.

Допустим, имеем некоторые условия:
```
stock_prices_yesterday = [10, 7, 5, 8, 11, 9]
 
profit = get_max_profit(stock_prices_yesterday)
#вернет 6 (купили за 5, продали за 11)
```

Массив может быть любым, хоть за весь день. Нужно написать функцию get_max_profit как можно эффективнее — с наименьшими затратами времени выполнения и памяти.

__Решение__
Для решения задачи недостаточно просто взять максимальную и минимальную цены, так как вы сначала должны купить по самой низкой цене, а затем продать по самой высокой, которая будет после цены покупки. Кроме того, если цена акции падает весь день, то лучшим ответом будет отрицательное число.

Для каждой цены будем проверять:
- возможность получить большую прибыль при покупке по min_price и продаже по current_price.
- обновилась ли min_price новым значением после итерации.

Инициализация:
- min_price равняется первой цене дня.
- max_profit равна первой прибыли, что мы получим.

Код решения (на Python):

``` python
def get_max_profit(stock_prices_yesterday):
 
    # убедимся, что количество цен в массиве превышает 2
    if len(stock_prices_yesterday) < 2:
        raise IndexError('Получение прибыли требует как минимум двух цен в массиве')
 
    # инициализируем min_price и max_profit
    min_price = stock_prices_yesterday[0]
    max_profit = stock_prices_yesterday[1] - stock_prices_yesterday[0]
 
    for index, current_price in enumerate(stock_prices_yesterday):
 
        # пропустим 0-ой элемент массива, так как min_price инициализирован.
        # Также продавать в 0-й позиции нельзя
        if index == 0:
            continue
 
        # вычисляем потенциальную прибыль
        potential_profit = current_price - min_price
 
        # обновляем максимальную прибыль
        max_profit = max(max_profit, potential_profit)
 
        # обновляем минимальную цену
        min_price  = min(min_price, current_price)
 
    return max_profit
```

Эффективность полученного алгоритма — O(n) по времени и O(1) по памяти. Цикл проходит по массиву только один раз.

# Напишите программу, проверяющую число на четность, используя только битовые операции

В этой задаче вам необходимо реализовать функцию, которая бы проверяла число на четность, используя только битовые операции AND, OR, NOT.

## Решение

Заметим, что число x нечетно только тогда, когда самый младший (то есть первый справа) бит в его двоичной записи равен 1. Докажем это. Вспомним знакомый со школьной статьи алгоритм перевода числа из двоичной системы в десятеричную. Он показан на следующей картинке:

![](images/B2d.gif)

Мы можем вынести два за скобку из всех слагаемых, кроме последнего, которое может принимать значение либо 1, либо 0. Таким образом, если оно равно нулю, то сумма будет иметь вид 2(…) = x, то есть будет делиться на два, а если оно будет равно единице, то сумма будет иметь вид 2(…)+1 = x, то есть не будет делиться на два. Это является критерием четности. Ч.т.д.

Итак, мы доказали факт того, что число нечетно, когда его младший бит равен 1, и четно, когда младший бит равен 0. Остался вопрос: как получить последний бит числа. Утверждение: последний бит числа x равен x&1, где & — побитовое И. Почему это так? И равно 1 только когда оба его аргумента равны 1. Число 1 в двоичной системе счисления имеет следующий вид: …000001 (в зависимости от того, скольки битными числами мы оперируем). А значит, при побитовом И единицы с числом х у результата все биты, кроме последнего, будут равны нулю, а последний бит будет равен 1, если в числе x он был равен 1 (1&1 = 1), и 0, если в числе x он был 0 (0&1 = 0).

Таким образом, значение выражения x&1 равно 1, если число x нечетное, и 0, если x четное.