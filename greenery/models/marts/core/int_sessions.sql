{{
    config(
        materialized = 'view'
    )
}}

with events as (
    select * from {{ ref(_stg__events) }}
)

select 
    session_guid,
    user_guid,
    min(created_at_utc) as session_start,
    max(case when event_type != 'package_shipped' then created_at_utc else null end) as session_end,
    timediff(day, min(created_at_utc), max(case when event_type != 'package_shipped' then created_at_utc else null end)) as session_duration,
    count(*) as total_events, 
    count(distinct product_guid) as total_products,
    sum(case when event_type = 'page_view' then 1 else 0 end) as page_views,
    sum(case when event_type = 'add_to_cart' then 1 else 0 end) as adds_to_cart,
    sum(case when event_type = 'checkout' then 1 else 0 end) as checkouts,
    sum(case when event_type = 'package_shipped' then 1 else 0 end) as packages_shipped
from 
    events
group by 1,2