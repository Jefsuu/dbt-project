{# {{
  config(
    materialized = 'ephemeral',
    )
}} #}
with source as (
      select * from {{ source('person', 'email') }}
)
select * from source
  