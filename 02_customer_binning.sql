-- metrics at order level | order + order_payments join ( only delivered orders )

with order_level as (
SELECT 
      o.order_id,
      customer_id,
      SUM(payment_value) as revenue

FROM `ecommerce_analysis.order_payments` op 
JOIN `ecommerce_analysis.orders` o 
ON op.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.order_id, customer_id ),

-- metrics at customer level before segmentation | customers + orders join

customer_level as (
SELECT
      c.customer_unique_id, 
      COUNT(DISTINCT ol.order_id) as total_orders,
      SUM(ol.revenue) as revenue

FROM `ecommerce_analysis.customers` c
JOIN order_level ol
ON c.customer_id = ol.customer_id
GROUP BY 1 )

SELECT
      CASE WHEN total_orders = 1 THEN 'New_customers' 
      WHEN total_orders > 1 AND total_orders < 4 THEN 'Returning_customers'
      WHEN total_orders >= 4 AND total_orders < 10 THEN 'Loyal_customers' 
      WHEN total_orders >= 10 THEN 'VIP customers' END AS segment,
      SUM(total_orders) as total_orders,
      COUNT(customer_unique_id) as total_customers,
      ROUND(SUM(revenue),2) as revenue, 
      ROUND(SUM(revenue) / COUNT(customer_unique_id),2) as avg_revenue_per_user
      
FROM customer_level 
GROUP BY 1;