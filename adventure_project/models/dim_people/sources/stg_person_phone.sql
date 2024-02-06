{{
  config(
    materialized = 'ephemeral',
    )
}}
with source as (
      select * from {{ source('person', 'phone') }}
)
select * from source
  