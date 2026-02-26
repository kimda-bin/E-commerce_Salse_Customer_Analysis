-- 데이터베이스 체크
-- 행 갯수 확인
select count(*) from clean_orders

-- 주문비용 범위 확인
select min(item_total), max(item_total) from clean_orders

-- 총 주문비용 확인
select sum(item_total) from clean_orders

-- 주문단위 확인
select count(distinct order_no) from clean_orders
-- => 행 갯수 == 주문단위

-- distinct 고객이름
select count(distinct buyer) from clean_orders

-- 월별 매출
select date_trunc('month',order_date) as month, sum(item_total) as total_sales
from clean_orders
group by month
order by month