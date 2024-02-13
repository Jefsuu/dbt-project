select 
    cast(to_char(dim_time.date_day, 'YYYYMMdd') as int) id,
    dim_time.*
from {{ ref("stg_dim_time") }} dim_time