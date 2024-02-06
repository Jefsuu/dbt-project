with source as (
      select * from {{ source('person', 'person') }}
),
renamed as (
    select
        distinct persontype
    from source
)
select * from renamed
  