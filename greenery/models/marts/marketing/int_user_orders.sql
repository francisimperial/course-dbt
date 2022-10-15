{{
    config(
        materialized = 'view'
    )
}}

with orders as (
    select * from {{ ref(_stg__orders) }}
)

select
    user_guid,
    count(distinct order_guid) as num_of_orders,
    sum(case when promo_guid is not null then 1 else 0 end) as num_of_promos,
    sum(order_cost) as total_order_spend, 
    sum(shipping_cost) as total_shipping_spend,
    sum(order_total_cost) as total_spend,
    min(created_at_utc) as oldest_order,
    max(created_at_utc) as newest_order 
from 
    orders
group by 1