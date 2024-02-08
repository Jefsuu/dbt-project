select 
    to_char(dim_time.date_day, 'YYYYMMdd') id,
    dim_time.*
from {{ ref("stg_dim_time") }} dim_time