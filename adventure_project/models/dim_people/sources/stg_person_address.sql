{{
  config(
    materialized = 'ephemeral',
    )
}}
with address as (
      select * from {{ source('person', 'person_adress') }}
)
, businessentityadess as (
    select * from {{ source('person', 'address') }}
)
select 
    businessentityadess.businessentityid,
    address.addressid,
    address.addressline1,
    address.stateprovinceid,
    address.city,
    address.postalcode
from businessentityadess
left join address ON
businessentityadess.addressid = address.addressid
  