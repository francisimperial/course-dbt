{{ 
    config(
        materialied = 'view'
    )
}}

with orders as (
    select * from {{ ref('_stg__orders') }}
),
users as (
    select * from {{ ref('_stg__users') }}
), 
addresses as (
    select * from {{ ref('_stg__addresses') }}
),
promos as (
    select * from {{ ref('_stg__promos') }}
),
order_items_prod as (
    select * from {{ ref('int_order_items_product') }}
)

select
    o.order_guid,
    o.user_guid,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.address,
    u.state,
    u.country,
    u.zipcode,
    p.promo_guid as promo_type,
    p.discount,
    o.created_at_utc,
    o.estimated_delivery_at_utc,
    o.delivered_at_utc,
    case when o.status = 'delivered' then datediff(hour, o.created_at_utc, o.delivered_at_utc) 
        else null end as delivery_time_days,
    o.order_cost,
    o.shipping_cost,
    o.order_total_cost,
    o.order_status,
    oip.num_of_products,
    oip.total_quantity_ordered
from
    orders o
    left join users u 
        on o.user_guid = u.user_guid
    left join addresses a
        on u.address_guid = a.address_guid
    left join promos p
        on o.promo_desc = p.promo_guid
    left join order_items_prod oip
        on o.order_guid = oip.order_guid