-- Only delivered orders are included 
-- Coded this query with a CTE (not single query) just for a cleaner logic
with agg_metrics as (
SELECT 
      c.customer_state,
      COUNT(*) as total_orders,
      COUNTIF(o.order_estimated_delivery_date < o.order_delivered_customer_date) as delayed_orders,
      COUNTIF(o.order_estimated_delivery_date >= o.order_delivered_customer_date) as ontime_orders,
      ROUND(AVG(DATE_DIFF(
      o.order_delivered_customer_date,o.order_purchase_timestamp, Day)),2) as avg_delivery_days,
      ROUND(AVG(CASE WHEN o.order_estimated_delivery_date < o.order_delivered_customer_date THEN 
      DATE_DIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date, Day) 
      END),2) as avg_delay_days

FROM `ecommerce_analysis.orders` o
JOIN `ecommerce_analysis.customers` c 
ON o.customer_id = c.customer_id 
WHERE order_status = 'delivered'
GROUP BY 1 ) 

SELECT 
      a.customer_state,
      a.total_orders,
      ROUND(100 * a.ontime_orders / a.total_orders, 2) as ontime_orders_percent, 
      ROUND(100 * a.delayed_orders / a.total_orders, 2) as delayed_orders_percent,
      a.avg_delivery_days,
      a.avg_delay_days

FROM agg_metrics a;