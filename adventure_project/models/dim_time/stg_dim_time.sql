{{
  config(
    materialized = 'table',
    schema = 'stg_analytics'
    )
}}
{% set start_date = '2000-01-01' %}
{% set end_date = '2023-12-31' %}

{{ dbt_date.get_date_dimension(start_date, end_date) }}