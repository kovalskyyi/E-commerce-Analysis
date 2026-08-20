-- Transition into product level 
-- Included only delivered orders

with product_level as (
SELECT
      oi.product_id,
      c.customer_unique_id,
      o.order_id, 
      SUM(oi.price) as revenue

FROM `ecommerce_analysis.orders` o 
JOIN `ecommerce_analysis.order_items` oi
ON o.order_id = oi.order_id
JOIN `ecommerce_analysis.customers` c
ON o.customer_id = c.customer_id
WHERE order_status = 'delivered'
GROUP BY 1,2,3 ),

-- product level transition into category level
category_level as (
SELECT
        product_category_name as category_native_name,
        pl.customer_unique_id,
        SUM(pl.revenue) as revenue,
        COUNT(DISTINCT pl.order_id) as total_orders
        
FROM product_level pl
LEFT JOIN `ecommerce_analysis.products` p
ON pl.product_id = p.product_id
GROUP BY 1,2 )

-- final query | adding english category name
SELECT 
      COALESCE(cat.string_field_1, 'unknown') as category_eng,
      COUNT(DISTINCT cl.customer_unique_id) as total_customers,
      ROUND(SUM(cl.revenue),2) as total_revenue, 
      SUM(cl.total_orders) as total_orders,
      ROUND((SUM(cl.revenue) / SUM(cl.total_orders)),2) as AOV

FROM category_level cl
LEFT JOIN `ecommerce_analysis.category` cat
ON cl.category_native_name = cat.string_field_0
GROUP BY 1;