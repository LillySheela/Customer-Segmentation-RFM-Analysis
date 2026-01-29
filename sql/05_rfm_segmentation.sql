-- =========================================================
-- File: 05_rfm_segmentation.sql
-- Purpose: Assign customer segments based on RFM scores
-- Tool: Google BigQuery
-- Input Table: rfm_scores
-- Output Table: rfm_segments
-- =========================================================

CREATE OR REPLACE TABLE `customer-segmentation-373712.retail.rfm_segments` AS
SELECT
    CustomerID,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    fm_score,

    CASE
        -- High value, most recent customers
        WHEN (r_score = 5 AND fm_score IN (4, 5))
            OR (r_score = 4 AND fm_score = 5)
        THEN 'Champions'

        -- Regular high-spending customers
        WHEN (r_score IN (4, 5) AND fm_score IN (3, 4))
            OR (r_score = 3 AND fm_score = 5)
        THEN 'Loyal Customers'

        -- Recently active with growth potential
        WHEN (r_score IN (3, 4, 5) AND fm_score = 2)
        THEN 'Potential Loyalists'

        -- New or very recent customers
        WHEN (r_score = 5 AND fm_score = 1)
        THEN 'Recent Customers'

        -- Customers showing early engagement
        WHEN (r_score IN (3, 4) AND fm_score = 1)
        THEN 'Promising'

        -- Moderate activity, need attention
        WHEN (r_score IN (2, 3) AND fm_score IN (2, 3))
        THEN 'Customers Needing Attention'

        -- Customers about to disengage
        WHEN (r_score = 2 AND fm_score = 1)
        THEN 'About to Sleep'

        -- Previously valuable but inactive
        WHEN (r_score IN (1, 2) AND fm_score IN (4, 5))
        THEN 'At Risk'

        -- Highest past value but long inactive
        WHEN (r_score = 1 AND fm_score IN (4, 5))
        THEN 'Cant Lose Them'

        -- Low activity, long inactive
        WHEN (r_score = 1 AND fm_score = 2)
        THEN 'Hibernating'

        -- Lowest value, churned customers
        WHEN (r_score = 1 AND fm_score = 1)
        THEN 'Lost'

        ELSE 'Unclassified'
    END AS rfm_segment

FROM
    `customer-segmentation-373712.retail.rfm_scores`;
