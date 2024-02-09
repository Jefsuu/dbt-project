with 
cte_product AS (
    select * from {{ source('product', 'product') }}
)
,cte_category AS (
    select * from {{ source('product', 'category') }}
)
,cte_subcategory AS (
    select * from {{ source('product', 'subcategory') }}
)
,cte_unitmeasure AS (
    select * from {{ source('product', 'unitmeasure') }}
)

select
    product.productid id,
    product.productnumber product_number,
    product.name product_name,
    category.productcategoryid category_id,
    category.name category,
    subcategory.productsubcategoryid subcategory_id,
    subcategory.name subcategory,
    unitmeasure.unitmeasurecode unit_measure_code,
    unitmeasure.name unit_measure,
    product.standardcost standard_cost,
    product.modifieddate last_update
from cte_product product
left join cte_subcategory subcategory on
    product.productsubcategoryid =  subcategory.productsubcategoryid
left join cte_category category on
    subcategory.productsubcategoryid = category.productcategoryid 
left join cte_unitmeasure unitmeasure on
    product.weightunitmeasurecode = unitmeasure.unitmeasurecode
