USE ecommerce_analytics;

-- ============================================================
-- REVENUE & SALES ANALYSIS
-- Dataset: Olist Brazilian E-Commerce
-- Purpose: Understand sales scale, trends, AOV, category/product
--          drivers, seller contribution, and geographic markets.
-- ============================================================


-- ============================================================
-- QUESTION 1
-- How much business is being generated?
-- ============================================================

SELECT
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    ROUND(SUM(oi.price), 2) AS total_product_sales,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS overall_aov
FROM raw_orders o
JOIN raw_order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


-- KEY INSIGHT:
-- Delivered orders generated approximately 13.22M in product
-- sales value across 96,478 delivered orders.
--
-- Overall AOV was approximately 137.04.
--
-- IMPORTANT:
-- Product sales here means SUM(order_items.price).
-- Freight and payment values are not included.


-- ============================================================
-- QUESTION 2
-- How are sales and order volumes changing over time?
-- ============================================================

SELECT
    DATE_FORMAT(
        o.order_purchase_timestamp,
        '%Y-%m'
    ) AS month,

    COUNT(DISTINCT o.order_id) AS delivered_orders,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_product_sales,

    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS AOV

FROM raw_orders o
JOIN raw_order_items oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    DATE_FORMAT(
        o.order_purchase_timestamp,
        '%Y-%m'
    )

ORDER BY month;


-- KEY INSIGHT:
-- Product sales increased substantially as order volume increased.
--
-- AOV remained relatively stable across the main operating period,
-- suggesting that sales growth was driven primarily by increasing
-- order volume rather than a major increase in order value.
--
-- The earliest months contain very few delivered orders and should
-- not be treated as representative.


-- ============================================================
-- QUESTION 3
-- What is the Average Order Value (AOV)?
-- ============================================================

SELECT
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS overall_aov

FROM raw_orders o
JOIN raw_order_items oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered';


-- KEY INSIGHT:
-- Overall delivered-order AOV was approximately 137.04.
--
-- Monthly AOV was relatively stable compared with the much larger
-- changes in order volume.
--
-- This supports the conclusion that marketplace sales growth was
-- primarily volume-driven.


-- ============================================================
-- QUESTION 4
-- Which products and categories drive sales?
-- ============================================================


-- ------------------------------------------------------------
-- 4A. CATEGORY PERFORMANCE
-- ------------------------------------------------------------

SELECT
    p.product_category_name AS category,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_sales,

    COUNT(DISTINCT o.order_id) AS orders,

    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS AOV

FROM raw_orders o

JOIN raw_order_items oi
    ON o.order_id = oi.order_id

JOIN raw_products p
    ON oi.product_id = p.product_id

WHERE o.order_status = 'delivered'
  AND p.product_category_name IS NOT NULL

GROUP BY
    p.product_category_name

ORDER BY
    total_sales DESC;


-- KEY INSIGHT:
-- The highest-sales categories included:
--
-- beleza_saude          ~1.23M
-- relogios_presentes    ~1.17M
-- cama_mesa_banho       ~1.02M
--
-- Categories can generate high sales through different mechanisms.
--
-- For example:
-- * beleza_saude has high order volume with moderate AOV.
-- * relogios_presentes has fewer orders but higher AOV.
-- * cama_mesa_banho has very high order volume but lower AOV.
--
-- Therefore:
-- High sales does NOT automatically mean high order value.
-- Sales must be evaluated together with order volume and order value.


-- ------------------------------------------------------------
-- 4B. PRODUCT PERFORMANCE
-- ------------------------------------------------------------

SELECT
    p.product_id,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_sales,

    COUNT(DISTINCT o.order_id) AS orders

FROM raw_orders o

JOIN raw_order_items oi
    ON o.order_id = oi.order_id

JOIN raw_products p
    ON oi.product_id = p.product_id

WHERE o.order_status = 'delivered'

GROUP BY
    p.product_id

ORDER BY
    total_sales DESC

LIMIT 20;


-- KEY INSIGHT:
-- Individual products can generate high sales through different
-- combinations of order volume and product value.
--
-- Therefore, ranking products only by sales does not explain WHY
-- they perform well.
--
-- Product-level analysis can later be extended into sales
-- concentration and category-level drill-downs.


-- ============================================================
-- QUESTION 5
-- Which sellers and geographic regions contribute most to sales?
-- ============================================================


-- ------------------------------------------------------------
-- 5A. SELLER CONTRIBUTION
-- ------------------------------------------------------------

SELECT
    oi.seller_id,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_sales,

    COUNT(DISTINCT o.order_id) AS orders

FROM raw_orders o

JOIN raw_order_items oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    oi.seller_id

ORDER BY
    total_sales DESC

LIMIT 20;


-- KEY INSIGHT:
-- Sales contribution is not evenly distributed across sellers.
--
-- The top-seller ranking identifies sellers that contribute
-- disproportionately to marketplace sales.
--
-- This can later be investigated further for seller dependency
-- and concentration risk.


-- ------------------------------------------------------------
-- 5B. CUSTOMER GEOGRAPHIC CONTRIBUTION
-- ------------------------------------------------------------

SELECT
    c.customer_state AS state,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_sales,

    COUNT(DISTINCT o.order_id) AS orders

FROM raw_orders o

JOIN raw_order_items oi
    ON o.order_id = oi.order_id

JOIN raw_customers c
    ON o.customer_id = c.customer_id

WHERE o.order_status = 'delivered'

GROUP BY
    c.customer_state

ORDER BY
    total_sales DESC;


-- KEY INSIGHT:
-- São Paulo (SP) is the dominant customer market:
--
-- SP → approximately 5.07M sales
--      approximately 40,501 orders
--
-- RJ and MG are the next largest markets.
--
-- This indicates substantial geographic concentration of marketplace
-- sales, with SP contributing significantly more than other states.


-- ============================================================
-- QUESTION 6
-- What is driving significant changes in sales?
-- ============================================================

-- Sales can be understood through two primary components:
--
--              SALES
--                |
--        -----------------
--        |               |
--   ORDER VOLUME        AOV
--
-- Therefore, changes in sales should be investigated by comparing
-- changes in delivered order volume and average order value.
--
-- The monthly analysis from QUESTION 2 provides both metrics.


SELECT
    DATE_FORMAT(
        o.order_purchase_timestamp,
        '%Y-%m'
    ) AS month,

    COUNT(DISTINCT o.order_id) AS delivered_orders,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_product_sales,

    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS AOV

FROM raw_orders o

JOIN raw_order_items oi
    ON o.order_id = oi.order_id

WHERE o.order_status = 'delivered'

GROUP BY
    DATE_FORMAT(
        o.order_purchase_timestamp,
        '%Y-%m'
    )

ORDER BY month;


-- KEY INSIGHT:
-- The monthly results indicate that changes in marketplace sales
-- were primarily associated with changes in order volume.
--
-- AOV remained comparatively stable during the main operating period.
--
-- Therefore, increasing order volume appears to have been the
-- dominant driver of sales growth.
--
-- NOTE:
-- This establishes an association in the observed data.
-- It does NOT prove what caused the increase in order volume.
-- Further investigation would be required to identify causal
-- business drivers.


-- ============================================================
-- REVENUE & SALES — OVERALL CONCLUSION
-- ============================================================
--
-- 1. The marketplace generated substantial product sales from
--    delivered orders.
--
-- 2. Sales increased strongly as order volume increased.
--
-- 3. AOV was comparatively stable, indicating volume-driven growth.
--
-- 4. Categories differ in HOW they generate sales:
--    some rely on high order volume while others have higher
--    order values.
--
-- 5. Product performance also varies between high-volume and
--    high-value products.
--
-- 6. Sales are geographically concentrated, particularly in SP,
--    followed by RJ and MG.
--
-- 7. Seller contribution should be monitored because marketplace
--    sales may be concentrated among a smaller group of sellers.
--
-- NEXT DOMAIN:
-- Customer Behaviour
-- ============================================================
