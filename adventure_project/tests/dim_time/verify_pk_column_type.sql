select id
from {{ ref('dim_time') }}
where pg_typeof(id) != pg_typeof(1)

