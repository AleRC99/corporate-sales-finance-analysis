-- ============================================================================
-- PROYECTO: Corporate Sales & Finance Analysis
-- Archivo: 01_data_cleaning.sql
-- Descripción: Transforma los datos crudos en una tabla limpia con precisión financiera, fechas estandarizadas, manejo de nulos y llave primaria.
-- ============================================================================

DROP TABLE IF EXISTS cleaned_sales CASCADE;

CREATE TABLE cleaned_sales AS
WITH deduplicated_sales AS (
    SELECT 
        row_id::INTEGER AS row_id,
        TRIM(order_id) AS order_id,
        -- Soporta tanto formato americano (MM/DD/YYYY) como ISO (YYYY-MM-DD)
        CASE 
            WHEN order_date LIKE '%/%' THEN TO_DATE(TRIM(order_date), 'MM/DD/YYYY')
            ELSE TRIM(order_date)::DATE 
        END AS order_date,
        CASE 
            WHEN ship_date LIKE '%/%' THEN TO_DATE(TRIM(ship_date), 'MM/DD/YYYY')
            ELSE TRIM(ship_date)::DATE 
        END AS ship_date,
        TRIM(ship_mode) AS ship_mode,
        TRIM(customer_id) AS customer_id,
        TRIM(customer_name) AS customer_name,
        TRIM(segment) AS segment,
        TRIM(country) AS country,
        TRIM(city) AS city,
        TRIM(state) AS state,
        -- Imputación de códigos postales nulos o vacíos
        COALESCE(NULLIF(TRIM(postal_code), ''), '00000') AS postal_code,
        TRIM(region) AS region,
        TRIM(product_id) AS product_id,
        TRIM(category) AS category,
        TRIM(sub_category) AS sub_category,
        TRIM(product_name) AS product_name,
        -- Redondeo a 2 decimales para consistencia contable/financiera
        ROUND(sales::NUMERIC, 2) AS sales,
        quantity::INTEGER AS quantity,
        ROUND(discount::NUMERIC, 4) AS discount,
        ROUND(profit::NUMERIC, 2) AS profit,
        -- Detección de líneas de pedido exactamente duplicadas
        ROW_NUMBER() OVER (
            PARTITION BY order_id, product_id, quantity, sales 
            ORDER BY row_id::INTEGER
        ) AS row_num
    FROM raw_sales
    WHERE order_id IS NOT NULL 
      AND sales IS NOT NULL 
      AND TRIM(sales) <> ''
)
SELECT 
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit
FROM deduplicated_sales
WHERE row_num = 1;

-- Definimos la llave primaria para optimizar consultas e integridad
ALTER TABLE cleaned_sales ADD PRIMARY KEY (row_id);