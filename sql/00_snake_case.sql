-- ============================================================================
-- Proyecto: Corporate Sales & Finance Analysis
-- Archivo: 00_snake_case.sql
-- Descripción: Aplica convención de nombres en snake_case a las columnas de la tabla raw_sales.
-- ============================================================================
ALTER TABLE raw_sales RENAME COLUMN "Row ID" TO "row_id";
ALTER TABLE raw_sales RENAME COLUMN "Order ID" TO "order_id";
ALTER TABLE raw_sales RENAME COLUMN "Order Date" TO "order_date";
ALTER TABLE raw_sales RENAME COLUMN "Ship Date" TO "ship_date";
ALTER TABLE raw_sales RENAME COLUMN "Ship Mode" TO "ship_mode";
ALTER TABLE raw_sales RENAME COLUMN "Customer ID" TO "customer_id";
ALTER TABLE raw_sales RENAME COLUMN "Customer Name" TO "customer_name";
ALTER TABLE raw_sales RENAME COLUMN "Segment" TO "segment";
ALTER TABLE raw_sales RENAME COLUMN "Country" TO "country";
ALTER TABLE raw_sales RENAME COLUMN "City" TO "city";
ALTER TABLE raw_sales RENAME COLUMN "State" TO "state";
ALTER TABLE raw_sales RENAME COLUMN "Postal Code" TO "postal_code";
ALTER TABLE raw_sales RENAME COLUMN "Region" TO "region";
ALTER TABLE raw_sales RENAME COLUMN "Product ID" TO "product_id";
ALTER TABLE raw_sales RENAME COLUMN "Category" TO "category";
ALTER TABLE raw_sales RENAME COLUMN "Sub-Category" TO "sub_category";
ALTER TABLE raw_sales RENAME COLUMN "Product Name" TO "product_name";
ALTER TABLE raw_sales RENAME COLUMN "Sales" TO "sales";
ALTER TABLE raw_sales RENAME COLUMN "Quantity" TO "quantity";
ALTER TABLE raw_sales RENAME COLUMN "Discount" TO "discount";
ALTER TABLE raw_sales RENAME COLUMN "Profit" TO "profit";

