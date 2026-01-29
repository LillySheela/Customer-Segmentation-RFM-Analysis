-- =========================================================
-- File: 01_data_cleaning.sql
-- Purpose: Clean raw retail sales data for RFM analysis
-- Tool: Google BigQuery
-- Output Table: clean_sales
-- =========================================================

-- Step 1: Create a cleaned version of the sales table
-- Assumptions:
-- 1. Cancelled invoices start with 'C'
-- 2. Quantity and UnitPrice must be positive
-- 3. CustomerID must not be NULL

CREATE OR REPLACE TABLE `customer-segmentation-373712.retail.clean_sales` AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    UnitPrice,
    CustomerID,
    Country,
    TIMESTAMP(InvoiceDate) AS InvoiceDate,
    
    -- Revenue per product line
    Quantity * UnitPrice AS amount
FROM
    `customer-segmentation-373712.retail.sales`
WHERE
    -- Exclude cancelled invoices
    NOT STARTS_WITH(InvoiceNo, 'C')
    
    -- Remove invalid records
    AND CustomerID IS NOT NULL
    AND Quantity > 0
    AND UnitPrice > 0;
