-- =========================================================
-- File: 04_rfm_scoring.sql
-- Purpose: Assign RFM scores to customers
-- Tool: Google BigQuery
-- Input Table: rfm_quintiles
-- Output Table: rfm_scores
-- =========================================================

CREATE OR REPLACE TABLE `customer-segmentation-373712.retail.rfm_scores` AS
SELECT
    CustomerID,
    recency,
    frequency,
    monetary,

    -- Monetary score (higher is better)
    CASE
        WHEN monetary <= m20 THEN 1
        WHEN monetary <= m40 THEN 2
        WHEN monetary <= m60 THEN 3
        WHEN monetary <= m80 THEN 4
        ELSE 5
    END AS m_score,

    -- Frequency score (higher is better)
    CASE
        WHEN frequency <= f20 THEN 1
        WHEN frequency <= f40 THEN 2
        WHEN frequency <= f60 THEN 3
        WHEN frequency <= f80 THEN 4
        ELSE 5
    END AS f_score,

    -- Recency score (lower recency = more recent = higher score)
    CASE
        WHEN recency <= r20 THEN 5
        WHEN recency <= r40 THEN 4
        WHEN recency <= r60 THEN 3
        WHEN recency <= r80 THEN 2
        ELSE 1
    END AS r_score,

    -- Combined Frequency & Monetary score
    CAST(
        ROUND(
            ( 
              CASE
                  WHEN frequency <= f20 THEN 1
                  WHEN frequency <= f40 THEN 2
                  WHEN frequency <= f60 THEN 3
                  WHEN frequency <= f80 THEN 4
                  ELSE 5
              END
              +
              CASE
                  WHEN monetary <= m20 THEN 1
                  WHEN monetary <= m40 THEN 2
                  WHEN monetary <= m60 THEN 3
                  WHEN monetary <= m80 THEN 4
                  ELSE 5
              END
            ) / 2,
            0
        ) AS INT64
    ) AS fm_score

FROM
    `customer-segmentation-373712.retail.rfm_quintiles`;
