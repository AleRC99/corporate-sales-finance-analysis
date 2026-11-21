-- ============================================================================
-- Proyecto: Corporate Sales & Finance Analysis
-- Archivo: 03_star_schema_views.sql
-- Descripción: Separa la tabla limpia en 1 Tabla de Hechos y 3 Dimensiones asegurando llaves primarias únicas (1:*) para Power BI.
-- ============================================================================

-- 1. Dimensión Clientes
CREATE OR REPLACE VIEW dim_customers AS
SELECT DISTINCT ON (customer_id)
    customer_id,
    customer_name,
    segment
FROM cleaned_sales
ORDER BY customer_id, order_date DESC;

-- 2. Dimensión Productos (DISTINCT ON resuelve IDs con variaciones de nombre)
CREATE OR REPLACE VIEW dim_products AS
SELECT DISTINCT ON (product_id)
    product_id,
    category,
    sub_category,
    product_name
FROM cleaned_sales
ORDER BY product_id, order_date DESC;

-- 3. Dimensión Geografía (llave subrogada compuesta para evitar ambigüedad)
CREATE OR REPLACE VIEW dim_geography AS
SELECT DISTINCT
    CONCAT_WS('|', region, state, city, postal_code) AS geo_id,
    country,
    region,
    state,
    city,
    postal_code
FROM cleaned_sales;

-- 4. Tabla de Hechos de Ventas
CREATE OR REPLACE VIEW fact_sales AS
SELECT 
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    product_id,
    CONCAT_WS('|', region, state, city, postal_code) AS geo_id,
    sales,
    quantity,
    discount,
    profit
FROM cleaned_sales;