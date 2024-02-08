select 
    person.businessentityid id,
    person.persontype type,
    concat(person.firstname, ' ', person.lastname) name,
    phone.phonenumber,
    email.emailaddress email,
    address.addressid,
    address.addressline1 adress,
    address.city,
    address.stateprovinceid,
    address.postalcode,
    person.modifieddate last_update
from {{ ref('stg_person') }} person
left join {{ ref("stg_person_phone") }} phone on
    person.businessentityid = phone.businessentityid
left join {{ ref("stg_person_email") }} email on
    person.businessentityid = email.businessentityid
left join {{ ref("stg_person_address") }} address on
    person.businessentityid = address.businessentityid
