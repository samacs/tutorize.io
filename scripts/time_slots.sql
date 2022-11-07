-- explain analyze
with date_series as (
  select
    extract(
      dow
      from
        series
    ) as weekday,
    date_trunc('day', series):: date as date
  from
    generate_series(
      '2022-10-31T00:00:00+00:00' :: timestamp,
      '2022-12-04T00:00:00+00:00' :: timestamp,
      '1 day' :: interval
    ) as series
)
select
  date_series.date as date_group,
  numrange(a.from, a.to) - numrange(coalesce(na.from, 0.0), coalesce(na.to, 0.0)) as time_slot
from
  availabilities as a
  inner join date_series on (
    date_series.weekday = a.weekday
    or date_series.date = a.date
  )
  left join availabilities as na on (
    a.teacher_id = na.teacher_id
    and na.available = false
    and (
      date_series.weekday = na.weekday
      or date_series.date = na.date
    )
  )
where
  a.teacher_id = 1
  and a.available = true
group by
  date_group,
  time_slot
order by
  date_group;
