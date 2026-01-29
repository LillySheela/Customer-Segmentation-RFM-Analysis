-- =========================================================
-- File: 03_quintile_calculation.sql
-- Purpose: Calculate RFM quintile thresholds
-- Tool: Google BigQuery
-- Input Table: rfm_base
-- Output Table: rfm_quintiles
-- =========================================================

-- Step 1: Calculate quintile boundaries using APPROX_QUANTILES
CREATE OR REPLACE TABLE `customer-segmentation-373712.retail.rfm_quintiles` AS
SELECT
    rfm.*,

    -- Monetary quintiles
    m_q[OFFSET(1)] AS m20,
    m_q[OFFSET(2)] AS m40,
    m_q[OFFSET(3)] AS m60,
    m_q[OFFSET(4)] AS m80,

    -- Frequency quintiles
    f_q[OFFSET(1)] AS f20,
    f_q[OFFSET(2)] AS f40,
    f_q[OFFSET(3)] AS f60,
    f_q[OFFSET(4)] AS f80,

    -- Recency quintiles
    r_q[OFFSET(1)] AS r20,
    r_q[OFFSET(2)] AS r40,
    r_q[OFFSET(3)] AS r60,
    r_q[OFFSET(4)] AS r80

FROM
    `customer-segmentation-373712.retail.rfm_base` rfm
CROSS JOIN
    (SELECT APPROX_QUANTILES(monetary, 5) AS m_q FROM `customer-segmentation-373712.retail.rfm_base`)
CROSS JOIN
    (SELECT APPROX_QUANTILES(frequency, 5) AS f_q FROM `customer-segmentation-373712.retail.rfm_base`)
CROSS JOIN
    (SELECT APPROX_QUANTILES(recency, 5) AS r_q FROM `customer-segmentation-373712.retail.rfm_base`);
