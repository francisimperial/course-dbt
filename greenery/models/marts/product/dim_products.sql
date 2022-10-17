{{
    config(
        materialized = 'view'
    )
}}

with products as (
    select * from {{ ref('_stg__products') }}
),
orders_product as (
    select * from {{ ref('int_orders_product') }}
)

select 
    p.product_guid,
    p.name,
    p.price,
    coalesce(p.inventory, 0) as product_inventory,
    coalesce(count(distinct(op.order_guid)), 0) as distinct_orders,
    coalesce(sum(op.quantity), 0) as quantity_sold,
    coalesce(sum(op.product_subtotal), 0) as product_revenue
from
    products p
left join orders_product op
    on p.product_guid = op.product_guid
group by 1,2,3,4