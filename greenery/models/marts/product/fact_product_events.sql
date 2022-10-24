{{ 
    config(
        materialized = 'view'
    )
}}

with events as (
    select * from {{ ref('_stg__events') }}
), 
products as (
    select * from {{ ref('_stg__products') }}
)
select 
    e.session_guid,
    e.event_type,
    e.product_guid,
    p.name as product_name
from
    events e
left join products p
    on e.product_guid = p.product_guid
where 
    e.product_guid is not null