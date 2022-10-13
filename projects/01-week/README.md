# Week 1 Project 

### 1) How many users do we have?

#### Answer: 130

```
select count(distinct user_guid) from _stg__users
```

### 2) On average, how many orders do we receive per hour?
#### Answer: 7.52

```
with hourly_orders as (
    select 
        count(order_guid) as num_orders,
        date_trunc('hour', created_at_utc) as hour
    from 
        _stg__orders
    group by hour
)
select  
    avg(num_orders)
from hourly_orders 
```

### 3) On average, how long does an order take from being placed to being delivered?
#### Answer: 3.89 days

```
Query:
select 
    avg(datediff('day', created_at_utc, delivered_at_utc))
from 
    _stg__orders
```

### 4) How many users have only made one purchase? Two purchases? Three+ purchases?
#### Answer: 25 users only made one purchase, 28 users made two purchases exactly, and 71 users made three or more purchases

```
with one_order as (
    select user_guid
    from _stg__orders
    group by 1
    having count(user_guid) = 1
),
two_orders as (
    select user_guid
    from _stg__orders
    group by 1
    having count(user_guid) = 2
),
more_orders as (
    select user_guid
    from _stg__orders
    group by 1
    having count(user_guid) > 2
)
select
    'one_order' as num_orders,
    count(*) as count
from one_order
union
select
    'two_orders' as num_orders,
    count(*) as count
from two_orders
union
select
    'more_orders' as num_orders,
    count(*) as count
from more_orders
```

### 5) On average, how many unique sessions do we have per hour?
#### Answer: 16.32

```
with hourly_sessions as (
    select 
        count(distinct session_id) as count,
        date_trunc('hour', created_at) as hour
    from
        _stg__events
    group by hour 
)
select
    avg(count)
from hourly_sessions