{{
  config(
    materialized = 'view'
    , unique_key = 'order_guid'
  )
}}

with order_items_source as (
  select * from {{ source('src_greenery', 'order_items') }}
)

, renamed_casted as (
  select 
    order_id as order_guid
    , product_id as product_guid
    , quantity
  from order_items_source
)

select * from renamed_casted