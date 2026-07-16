{{config(materialized='table')}}

{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with 

payments as (
select * from {{ref('stg_payments')}}

),

final as (
select 

payment_method,
sum(amount) as total_revenue,
count(order_id) as number_of_orders,
sum(amount)/count(order_id) as average_payment_value
from payments
group by 1
order by 1
)

select * from final