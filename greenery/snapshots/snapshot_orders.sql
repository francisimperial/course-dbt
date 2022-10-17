{% snapshot snapshot_orders %}

{{
    config(
        target_database = 'dev_db'
        , target_schema = 'dbt_franciswong17'
        , unique_key = 'order_id'
        , strategy = 'check'
        , check_cols = ['status']
    )
}}

select * from {{ source('src_greenery', 'orders') }}

{% endsnapshot %}