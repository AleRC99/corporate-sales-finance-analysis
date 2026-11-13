-- ============================================================================
-- Proyecto: Corporate Sales & Finance Analysis
-- Archivo: 02_business_views.sql
-- Descripción: Capa semántica en SQL con métricas clave de ventas, rentabilidad y márgenes agrupadas por tiempo, producto y segmento de cliente.
-- ============================================================================

-- 1. Evolución mensual de ventas y ganancias
CREATE OR REPLACE VIEW vw_sales_by_month AS
SELECT 
    EXTRACT(YEAR FROM order_date)::INTEGER AS order_year,
    EXTRACT(MONTH FROM order_date)::INTEGER AS order_month,
    TO_CHAR(order_date, 'YYYY-MM') AS year_month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_sold,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_pct
FROM cleaned_sales
GROUP BY 1, 2, 3
ORDER BY 1, 2;

-- 2. Rentabilidad y volumen por producto y categoría
CREATE OR REPLACE VIEW vw_sales_by_product AS
SELECT 
    category,
    sub_category,
    product_id,
    product_name,
    SUM(quantity) AS total_units_sold,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_pct
FROM cleaned_sales
GROUP BY 1, 2, 3, 4
ORDER BY total_sales DESC;

-- 3. Desempeño financiero por segmento de cliente
CREATE OR REPLACE VIEW vw_sales_by_segment AS
SELECT 
    segment,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0)) * 100, 2) AS profit_margin_pct
FROM cleaned_sales
GROUP BY 1
ORDER BY total_sales DESC;