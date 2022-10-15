{{
    config(
        materialized = 'view'
    )
}}

with int_users as (
    select * from {{ ref('int_users') }}
),
user_orders as (
    select * from {{ref('int_user_orders')}}
)

select 
    iu.user_guid,
    iu.first_name,
    iu.last_name,
    iu.email,
    iu.phone_number,
    iu.address,
    iu.state,
    iu.country,
    iu.zipcode,
    iu.created_at_utc,
    iu.updated_at_utc,
    uo.num_of_orders,
    uo.num_of_promos,
    uo.total_order_spend, 
    uo.total_shipping_spend,
    uo.total_spend,
    uo.oldest_order,
    uo.newest_order 
from 
    int_users iu
left join user_orders uo
    on iu.user_guid = uo.user_guid