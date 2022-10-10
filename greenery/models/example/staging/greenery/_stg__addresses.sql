{{
  config(
    materialized = 'view'
    , unique_key = 'address_guid'
  )
}}

with addresses_source as (
  select * from {{ source('src_greenery', 'addresses') }}
)

, renamed_casted as (
  select 
    address_id as address_guid
    , address
    , zipcode
    , state
    , country
  from addresses_source
)

select * from renamed_casted