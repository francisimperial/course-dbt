{{ 
    config(
        materialied = 'table'
    )
}}

with users as (
    select * from {{ ref('_stg__users') }}
),
addresses as (
    select * from {{ ref('_stg__addresses') }}
)

select 
    u.user_guid,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    a.address,
    a.state,
    a.country,
    a.zipcode,
    u.created_at_utc,
    u.updated_at_utc
from
    users u
    left join addresses a
        on u.address_guid = a.address_guid