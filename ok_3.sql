--(a)	Выведи для каждого пользователя первое наименование, которое он заказал (первое по времени транзакции)
select user_id,
       item
from (
         select user_id,
                item,
                row_number() over (partition by user_id order by transaction_ts) as seq
         from transactions
     ) as sorted_aquisitions
where seq = 1;



--(b)	Посчитай сколько транзакций в среднем делает каждый пользователь в течении 72х часов с момента первой транзакции
--explain analyse verbose
with earliest as (
    select user_id,
           min(transaction_ts) as earliest_order
    from transactions
    group by user_id)
select sum(orders_3_days) / count(user_id) as average_per_user_3_days
from (
         select t.user_id,
                count(transaction_id) as orders_3_days
         from transactions t
                  left join earliest e on t.user_id = e.user_id
         where date_part('day', t.transaction_ts - e.earliest_order) * 24 +
               DATE_PART('hour', t.transaction_ts - e.earliest_order) < 72
         group by t.user_id) no_of_orders;      
