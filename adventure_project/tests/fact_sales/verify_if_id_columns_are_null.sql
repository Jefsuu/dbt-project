-- verify if id columns in fact_sales are null, the objetive of this test is only warn
{{
  config(
    error_if=">100000",
    warn_if=">0",
    )
}}

{% set columns_list = ["sales_order_id", "customer_id", 
                        "sales_person_id", "territory_id", 
                        "product_id", "date_id"] %}
select 
    {%- for column in columns_list %}
    {{column}} {%- if not loop.last -%},{%- endif %}
    {%- endfor %}
from {{ ref("fact_sales") }}
where
{%- for column in columns_list %}
  {{column}} {%- if not loop.last %} is null or {% else %} is null {%- endif %}
{%- endfor -%}
