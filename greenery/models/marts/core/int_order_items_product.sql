{{
    config(
        materialized = 'view'
    )
}}

with order_items as (
    select * from {{ ref('_stg__order_items') }}
)

select 
    order_guid,
    count(distinct product_guid) as num_of_products,
    sum(quantity) as total_quantity_ordered
from 
    order_items
group by 1