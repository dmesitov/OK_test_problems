--Посчитать по-дневное количество просмотров видео, аудиторию сервиса и количество различных видео-роликов, просмотренных в этот день.

select  date,
        count(user_id) as daily_views,
	      count(distinct user_id) as daily_uniq,
	      count(distinct video_id) as videos_viewed
from video
group by date


--Найти всех пользователей, смотревших видео все дни в январе 2021

select user_id
from videos
where date_trunc('month', date) = '2021-01-01'
group by user_id
having count(distinct date) = 31



--Найти всех пользователей, смотревших video_id 1 и 3, но не смотревших video_id 2

select user_id

from video
group by user_id
having max(case
               when video_id = 1
                   then 1
               else 0
    end) = 1
   and max(case
               when video_id = 2
                   then 1
               else 0
    end) = 0
   and max(case
               when video_id = 3
                   then 1
               else 0
    end) = 1
