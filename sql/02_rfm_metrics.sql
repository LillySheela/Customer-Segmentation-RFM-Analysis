-- =========================================================
-- File: 02_rfm_metrics.sql
-- Purpose: Calculate customer-level RFM metrics
-- Tool: Google BigQuery
-- Input Table: clean_sales
-- Output Table: rfm_base
-- =========================================================

-- Step 1: Calculate total bill amount per invoice
WITH invoice_totals AS (
    SELECT
        InvoiceNo,
        CustomerID,
        InvoiceDate,
        SUM(amount) AS total_invoice_amount
    FROM
        `customer-segmentation-373712.retail.clean_sales`
    GROUP BY
        InvoiceNo,
        CustomerID,
        InvoiceDate
),

-- Step 2: Aggregate invoice data to customer level
customer_purchases AS (
    SELECT
        CustomerID,

        -- Purchase dates
        DATE(MAX(InvoiceDate)) AS last_purchase_date,
        DATE(MIN(InvoiceDate)) AS first_purchase_date,

        -- Frequency: number of distinct purchases
        COUNT(DISTINCT InvoiceNo) AS total_purchases,

        -- Monetary: total revenue generated
        SUM(total_invoice_amount) AS monetary
    FROM
        invoice_totals
    GROUP BY
        CustomerID
),

-- Step 3: Calculate recency, frequency (normalized), and customer lifetime
rfm_metrics AS (
    SELECT
        CustomerID,
        last_purchase_date,
        first_purchase_date,
        total_purchases,
        monetary,

        -- Reference date: most recent transaction in the dataset
        DATE_DIFF(
            (SELECT DATE(MAX(InvoiceDate)) FROM invoice_totals),
            last_purchase_date,
            DAY
        ) AS recency,

        -- Customer lifetime in months (minimum 1)
        DATE_DIFF(last_purchase_date, first_purchase_date, MONTH) + 1 AS customer_lifetime_months,

        -- Frequency normalized by customer lifetime
        SAFE_DIVIDE(
            total_purchases,
            DATE_DIFF(last_purchase_date, first_purchase_date, MONTH) + 1
        ) AS frequency
    FROM
        customer_purchases
)

-- Step 4: Create the final RFM base table
CREATE OR REPLACE TABLE `customer-segmentation-373712.retail.rfm_base` AS
SELECT
    CustomerID,
    recency,
    frequency,
    monetary
FROM
    rfm_metrics;
