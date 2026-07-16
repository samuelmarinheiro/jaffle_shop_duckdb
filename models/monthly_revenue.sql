{{config(materialized='table')}}

with orders as (
select *
from {{ ref('orders') }}
)

, final as (

select
date_trunc('month', order_date) as order_month
, sum(amount) as total_revenue
from orders
group by 1
order by 1
)

select * from final