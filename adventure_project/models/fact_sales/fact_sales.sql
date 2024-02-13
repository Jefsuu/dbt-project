with cte_product_cost AS (
    select distinct
        productid id,
        standardcost standard_cost
    from {{ source('product', 'product') }}
)
select
	soh.salesorderid sales_order_id,
	soh.purchaseordernumber purchase_order_number,
	soh.accountnumber account_number,
	soh.customerid customer_id,
	soh.salespersonid sales_person_id,
	soh.territoryid territory_id,
	soh.shipmethodid ship_method_id,
	soh.currencyrateid currency_rate_id,
	sod.productid product_id,
	sod.orderqty quantity,
	sod.unitprice unit_price,
	sod.orderqty * sod.unitprice subtotal, 
	cast(
        ((sod.orderqty * sod.unitprice) * (sm.shiprate / 100)) 
        + 
        sm.shipbase 
    as decimal(38,2)) freight,
	cpc.standard_cost * sod.orderqty estimated_cost,
    ((sod.orderqty * sod.unitprice)
        +
    cast(
        ((sod.orderqty * sod.unitprice) * (sm.shiprate / 100)) 
        + 
        sm.shipbase 
    as decimal(38,2))) revenue,
    (((sod.orderqty * sod.unitprice)
        +
    cast(
        ((sod.orderqty * sod.unitprice) * (sm.shiprate / 100)) 
        + 
        sm.shipbase 
        as decimal(38,2)))
        -
        (cpc.standard_cost * sod.orderqty)
    ) estimated_profit,
    soh.orderdate order_date,
    soh.duedate due_date,
    soh.shipdate ship_date,
    soh.modifieddate last_update,
    cast(to_char(soh.orderdate, 'YYYYMMdd') as int) date_id
from sales.salesorderheader soh
left join sales.salesorderdetail sod on
	soh.salesorderid = sod.salesorderid
left join purchasing.shipmethod sm on
	soh.shipmethodid = sm.shipmethodid
left join cte_product_cost cpc on
    sod.productid = cpc.id
