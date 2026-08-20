-- Only delivered orders are included 
-- First CTE just to have cleaner code with all the joins, tehcnically this could be done in a single query 

with revenue_and_ids as ( 
SELECT 
      oi.seller_id,
      o.order_id,
      c.customer_unique_id,
      product_id,
      SUM(oi.price) as revenue
      
FROM `ecommerce_analysis.orders`o
JOIN `ecommerce_analysis.order_items` oi 
ON o.order_id = oi.order_id
JOIN `ecommerce_analysis.customers` c 
ON o.customer_id = c.customer_id 
WHERE o.order_status = 'delivered'
GROUP BY 1, 2, 3, 4 )

SELECT 
      seller_id,
      COUNT(DISTINCT customer_unique_id) as customer_count,
      COUNT(DISTINCT order_id) as order_count,
      COUNT(product_id) as product_sold_count,
      ROUND(SUM(revenue),2) as revenue,
      ROUND(SUM(revenue) / COUNT(DISTINCT order_id),2) as AOV 
      
FROM revenue_and_ids
GROUP BY 1;
