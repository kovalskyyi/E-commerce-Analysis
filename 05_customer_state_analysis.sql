-- Key metrics aggregated on order-level data 
-- Only delivered orders are included 
-- Inner join order payments because all orders have payments ( even if 0 )

with key_metrics as (
SELECT
      customer_id,
      SUM(op.payment_value) as revenue, 
      COUNT(DISTINCT o.order_id) as orders_count

FROM `ecommerce_analysis.orders` o 
JOIN `ecommerce_analysis.order_payments` op 
ON o.order_id = op.order_id 
WHERE order_status = 'delivered'
GROUP BY 1 )

-- Transition into customer_state level and final aggregations
SELECT 
      c.customer_state,
      COUNT(DISTINCT customer_unique_id) as total_customers,
      SUM(km.orders_count) as orders_count,
      ROUND(SUM(km.revenue),2) as revenue, 
      ROUND(SUM(km.revenue) / SUM(km.orders_count),2) as AOV

FROM key_metrics km 
JOIN `ecommerce_analysis.customers` c 
ON km.customer_id = c.customer_id
GROUP BY 1; 