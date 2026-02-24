-- raw_orders -> clean_orders 데이터 적재
insert into clean_orders (
	order_no,
	buyer,
	order_date,
	item_total,
	order_status,
	cod
)select 
    order_no, 
    buyer, 
    order_date::timestamp, 
    regexp_replace(item_total, '[^0-9.]','','g')::numeric(10,2), 
    order_status,
    cod
from raw_orders