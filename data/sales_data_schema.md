# Sales Data Schema

## Dataset Description
This dataset contains **transaction-level retail sales data** for a multi-category retail business.  
Each row represents a **single product purchased within a transaction (invoice)**.

The data includes cancelled transactions and missing customer identifiers, which were handled during data preparation.

---

## Table: sales

### Granularity
- **One row per product per invoice**

---

## Column Definitions

| Column Name  | Data Type | Description | Business Notes |
|-------------|-----------|-------------|----------------|
| InvoiceNo | STRING | Unique invoice identifier for each transaction | Invoices starting with 'C' indicate cancelled transactions |
| StockCode | STRING | Unique product code | Identifies individual products |
| Description | STRING | Product name | Used for product-level analysis (not required for RFM) |
| Quantity | INTEGER | Number of units purchased per product | Values ≤ 0 were excluded |
| InvoiceDate | TIMESTAMP | Date and time of transaction | Used to calculate recency |
| UnitPrice | FLOAT | Price per unit (in GBP) | Values ≤ 0 were excluded |
| CustomerID | STRING | Unique customer identifier | Null values were excluded |
| Country | STRING | Customer’s country of residence | Useful for geographic analysis |

---

## Data Quality & Cleaning Notes

The following data preparation steps were applied before analysis:

- Excluded **cancelled transactions** (`InvoiceNo` starting with 'C')
- Removed records with:
  - Missing `CustomerID`
  - Non-positive `Quantity`
  - Non-positive `UnitPrice`
- Converted `InvoiceDate` to a standard timestamp format

These steps ensured accurate calculation of customer behavior metrics.

---

## Derived Fields

The following fields were created during analysis:

| Derived Field | Description |
|--------------|-------------|
| amount | Revenue per product (`Quantity × UnitPrice`) |
| total_invoice_amount | Total bill amount per invoice |
| recency | Days since last purchase |
| frequency | Average number of purchases per month |
| monetary | Total revenue generated per customer |

---

## Notes
- Monetary values were calculated at the **customer level**
- Frequency was normalized by customer lifetime to avoid bias
- This schema supports scalable customer segmentation and BI reporting
