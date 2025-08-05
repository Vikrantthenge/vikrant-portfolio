-- Snowflake Schema Optimization and Query Tuning

-- Step 1: Create staging table
CREATE OR REPLACE TABLE STAGING_REGION_SUMMARY (
    REGION VARCHAR,
    TOTAL_REVENUE FLOAT
);

-- Step 2: Load data from Parquet (using Snowflake external stage)
COPY INTO STAGING_REGION_SUMMARY
FROM @my_snowflake_stage/staging_region_summary.parquet
FILE_FORMAT = (TYPE = PARQUET);

-- Step 3: Optimize table by clustering on REGION
ALTER TABLE STAGING_REGION_SUMMARY
CLUSTER BY (REGION);

-- Step 4: Query optimization
SELECT REGION, TOTAL_REVENUE
FROM STAGING_REGION_SUMMARY
ORDER BY TOTAL_REVENUE DESC;