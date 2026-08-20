-- Included only delivered orders 
-- Included only customers who have delivered orders ( at least one )
-- Grouped by purchase timestamp
-- AOV = average order value  

with order_metrics as (
SELECT 
      DATE(DATE_TRUNC(order_purchase_timestamp, Month)) as year_month,
      COUNT(DISTINCT o.order_id) as total_orders,
      ROUND(SUM(payment_value),2) as total_revenue,
      ROUND(SUM(payment_value) / COUNT(DISTINCT o.order_id),2) as AOV

FROM `ecommerce_analysis.order_payments` op
JOIN `ecommerce_analysis.orders`o
ON op.order_id = o.order_id
WHERE order_status = 'delivered'
GROUP BY 1 ),

customer_metrics as (
SELECT 
      DATE(DATE_TRUNC(o.order_purchase_timestamp, Month)) as year_month,
      COUNT(DISTINCT c.customer_unique_id) as unique_customers

FROM `ecommerce_analysis.customers` c
JOIN `ecommerce_analysis.orders` o 
ON c.customer_id = o.customer_id 
WHERE o.order_status = 'delivered'
GROUP by 1 )

SELECT 
      om.year_month,
      cm.unique_customers,
      om.total_revenue,
      om.total_orders,
      om.AOV

FROM order_metrics om 
JOIN customer_metrics cm 
ON om.year_month = cm.year_month
ORDER by 1;