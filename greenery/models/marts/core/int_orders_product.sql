{{ 
    config(
        materialied = 'view'
    )
}}

with orders as (
    select * from {{ ref('_stg__orders') }}
),
order_items as (
    select * from {{ ref('_stg__order_items') }}
), 
products as (
    select * from {{ ref('_stg__products') }}
)

select 
    o.order_guid,
    oi.product_guid,
    oi.quantity,
    p.name as product_name,
    p.price,
    oi.quantity * p.price as product_subtotal
from
    orders o
left join order_items oi
    on o.order_guid = oi.order_guid
left join products p
    on oi.product_guid = p.product_guid