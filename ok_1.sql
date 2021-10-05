--(a)	Для каждого сотрудника найти его департамент, включая тех, у кого департамента нет

select e.id   as id,
       e.name as name,
       (case
            when d.name is not null
                then d.name
            else 'None'
           end)
              as department
from employees e
         left join departments d on e.dep_id = d.id
order by e.id;



--(b)  Найти наибольшую зарплату по департаментам и отсортировать департаменты по убыванию максимальной зарплаты

select (case
            when d.name is not null
                then d.name
            else 'None'
           end)
              as department,
       maxes.max_salary
from
    (select distinct dep_id,
           max(salary) over (partition by dep_id) as max_salary
    from employees) as maxes
left join departments d on maxes.dep_id = d.id
order by max_salary desc
