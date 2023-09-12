# Write your MySQL query statement below
# select s.user_id, c.action, count(*) as confirmations from Signups s 
#   join Confirmations c 
#   on s.user_id = c.user_id 
# group by s.user_id, c.action 
# having c.action = "confirmed"


# select s.user_id, c.action, grouped.confirmations / count(*) from Confirmations c 
# right join Signups s 
# on c.user_id = s.user_id 
# left join (
#   select s.user_id, c.action, count(*) as confirmations from Signups s 
#   join Confirmations c 
#   on s.user_id = c.user_id 
# group by s.user_id, c.action 
# having c.action = "confirmed"
# ) grouped 
# on grouped.user_id = c.user_id 
# group by c.user_id, c.action;

# select s.user_id, count(*) as confirmation_count 
# from Confirmations c 
# right join Signups s 
# on c.user_id = s.user_id 
# group by s.user_id, c.action 
# having c.action = "confirmed";


# select s.user_id, count(*) from Signups s 
# left join Confirmations c 
# on s.user_id = c.user_id 
# group by c.user_id;

select total_group.user_id, ifnull(round(confirmed_group.confirmation_count / total_group.total, 2), 0) as confirmation_rate 
from (
  select s.user_id, count(*) as confirmation_count 
  from Confirmations c 
  right join Signups s 
  on c.user_id = s.user_id 
  group by s.user_id, c.action 
  having c.action = "confirmed"
) as confirmed_group 
right join (
  select s.user_id, count(*) as total 
  from Signups s 
  left join Confirmations c 
  on s.user_id = c.user_id 
  group by s.user_id
) as total_group 
on confirmed_group.user_id = total_group.user_id;
