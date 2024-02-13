select 
    person.businessentityid id,
    person.persontype type,
    upper(trim(type.description)),
    concat(person.firstname, ' ', person.lastname) name,
    phone.phonenumber phone_number,
    email.emailaddress email,

    address.addressid address_id, 
    address.addressline1 adress,
    address.city city,
    address.stateprovinceid state_province_id,
    address.postalcode postal_code,

    {# array_agg(address.addressid) address_id, 
    array_agg(address.addressline1) adress,
    array_agg(address.city) city,
    array_agg(address.stateprovinceid) state_province_id,
    array_agg(address.postalcode) postal_code, #}

    person.modifieddate last_update
from {{ ref('stg_person') }} person
left join {{ ref("stg_person_phone") }} phone on
    person.businessentityid = phone.businessentityid
left join {{ ref("stg_person_email") }} email on
    person.businessentityid = email.businessentityid
left join {{ ref("stg_person_address") }} address on
    person.businessentityid = address.businessentityid
left join {{ ref("type_of_person") }} type on
    upper(trim(person.persontype)) = upper(trim(type.persontype))
--group by 1,2,3,4,5,6,12
