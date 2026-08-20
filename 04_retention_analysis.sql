-- Included only delivered orders 
-- First CTE to get cohort month on a customer level grain
 
with cohort_month as (
SELECT 
      customer_unique_id,
      MIN(DATE(DATE_TRUNC(order_purchase_timestamp, Month))) as cohort_month

FROM `ecommerce_analysis.customers` c 
JOIN `ecommerce_analysis.orders`o
ON c.customer_id = o.customer_id
WHERE order_status = 'delivered'
GROUP BY 1 ),

-- Second CTE to transition grain into customer + month level
customer_per_month as (
SELECT 
      customer_unique_id,
      DATE(DATE_TRUNC(order_purchase_timestamp, Month)) as order_month

FROM `ecommerce_analysis.orders` o 
JOIN `ecommerce_analysis.customers` c 
ON o.customer_id = c.customer_id
WHERE order_status = 'delivered'
GROUP BY 1, 2 )

-- Retention table, grain change to cohort month + date difference 
SELECT 
      cohort_month,
      DATE_DIFF(cpm.order_month, cm.cohort_month, Month) as month_diff,
      COUNT(DISTINCT cpm.customer_unique_id) as customer_count
    
FROM cohort_month cm 
JOIN customer_per_month cpm
ON cm.customer_unique_id = cpm.customer_unique_id
GROUP BY 1, 2
ORDER BY 1 ASC;