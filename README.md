# Customer-Segmentation-RFM-Analysis

## 📌 Project Overview
This project performs **customer segmentation using RFM (Recency, Frequency, Monetary) analysis** on retail transaction data using **Google BigQuery SQL**.  
The goal is to help a retail business **optimize marketing spend, improve targeting, and retain high-value customers** by identifying distinct customer segments based on purchasing behavior.

---

## 🧩 Problem Statement
A retail chain selling a wide range of products currently treats all customers uniformly, leading to inefficient marketing efforts.

The business wants to:
- Understand which customers are most valuable
- Identify loyal, inactive, and at-risk customers
- Allocate marketing budget more effectively through data-driven segmentation

---

## 🎯 Business Objective
- Segment customers based on historical purchasing behavior
- Identify high-value and churn-risk customers
- Enable targeted and personalized marketing strategies
- Support decision-making using scalable SQL-based analytics

---

## 📊 Dataset Overview
The dataset contains **transaction-level retail sales data**, where each row represents a product purchased within an invoice.

**Key attributes include:**
- Invoice number and date
- Product details (StockCode, Description)
- Quantity and unit price
- Customer identifier
- Customer country

Cancelled transactions and invalid records were excluded during data preparation to ensure accuracy.

---

## 🛠️ Tools & Technologies
- **Google BigQuery**
- **SQL (CTEs, aggregations, window functions, CASE logic)**
- **Power BI / Tableau**
- **GitHub**

---

## 🧠 Methodology

### 1. Data Cleaning & Processing
- Removed cancelled invoices
- Filtered invalid quantities, prices, and missing customer IDs
- Calculated transaction-level and invoice-level revenue

### 2. RFM Metric Calculation
For each customer:
- **Recency**: Days since the most recent purchase
- **Frequency**: Average number of purchases per month
- **Monetary**: Total revenue generated

### 3. Quintile-Based Scoring
- Customers were divided into **five equal groups (quintiles)** for each RFM metric using BigQuery’s `APPROX_QUANTILES()`
- Scores from **1 (lowest)** to **5 (highest)** were assigned
- Recency scores were reversed (more recent = higher score)

### 4. Customer Segmentation
- Combined R and FM scores
- Mapped customers to **11 standard RFM segments** (DMA model), such as:
  - Champions
  - Loyal Customers
  - Potential Loyalists
  - At Risk
  - Hibernating
  - Lost Customers

---

## 📈 Key Outcomes
- Identified high-value customers contributing the most revenue
- Flagged at-risk and inactive customers for re-engagement
- Created a reusable segmentation framework that can be automated
- Produced a clean customer-level dataset ready for BI reporting


## 📁 Repository Structure

customer-segmentation-rfm-bigquery/
- data/                          # Dataset schema & metadata (no raw data uploaded)
  - sales_data_schema.md
- sql/                           # BigQuery SQL scripts for RFM analysis
  - 01_data_cleaning.sql
  - 02_rfm_metrics.sql
  - 03_quintile_calculation.sql
  - 04_rfm_scoring.sql
  - 05_rfm_segmentation.sql
- reports/                       # Final insights & business recommendations
  - customer_segmentation_insights.pdf
- README.md                      # Project overview & methodology


---

## 🚀 How to Run This Project
1. Upload `sales.csv` to Google BigQuery
2. Execute SQL scripts in the `/sql` folder sequentially
3. Export final RFM segmentation table


---

## 💡 Business Value
This project demonstrates how **simple, explainable analytics techniques like RFM** can deliver strong business value by:
- Improving customer retention
- Increasing marketing ROI
- Supporting strategic decision-making with data

---
