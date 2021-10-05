--(a)	Посчитай доход с женской аудитории (доход = сумма price * items)

select sum(items * price) as income
from purchases
where left(user_gender, 1) = 'f';


--(b)	Сравни доход по группе мужчин и женщин

select left(user_gender, 1) as gender,
       sum(items * price) as income
from purchases
group by left(user_gender, 1);


--(c)	Посчитай кол-во уникальных пользователей-мужчин, заказавших  более чем три айтема  (суммарно за все заказы)

select count(user_id) as answer
from (
         select user_id,
                sum(items) as amount
         from purchases
         where left(user_gender, 1) = 'm'
         group by user_id
     ) as amounts
where amount > 3
