-- raw_orders 테이블 생성
create table raw_orders(
	order_no text primary key,
	order_date text,
	buyer text,
	ship_city text,
	ship_state text,
	sku text,
	description text,
	quantity text,
	shipping_fee text,
	item_total text,
	order_status text,
	cod text
)

-- clean_orders 테이블 생성
create table clean_orders(
	order_no text primary key,
	buyer text,
	order_date timestamp,
	item_total numeric(10,2),
	order_status text,
	cod text
)