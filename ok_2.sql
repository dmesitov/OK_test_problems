select sum(items * price) as income
from purchases
where left(user_gender, 1) = 'f';



select left(user_gender, 1) as gender,
       sum(items * price) as income
from purchases
group by left(user_gender, 1);

-- select gender,
--        sum(income)
-- from (
--          select user_id,
--                 left(user_gender, 1) as gender,
--                 items * price        as income
--          from purchases
--      ) as incomes
-- group by gender;


select count(user_id) as answer
from (
         select user_id,
                sum(items) as amount
         from purchases
         where left(user_gender, 1) = 'm'
         group by user_id
     ) as amounts
where amount > 3
