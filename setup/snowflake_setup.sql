create database if not exists AIRBNB_ANALYTICS;

create warehouse if not exists COMPUTE_WH
    warehouse_size = XSMALL
    auto_suspend = 60
    auto_resume = true;

create schema if not exists AIRBNB_ANALYTICS.RAW;
create schema if not exists AIRBNB_ANALYTICS.STAGING;
create schema if not exists AIRBNB_ANALYTICS.INTERMEDIATE;
create schema if not exists AIRBNB_ANALYTICS.MARTS;

-- Load the Inside Airbnb open dataset into AIRBNB_ANALYTICS.RAW before running dbt.
-- Recommended files from https://insideairbnb.com/get-the-data/:
-- listings.csv.gz, calendar.csv.gz, reviews.csv.gz, neighbourhoods.csv
--
-- Easiest classroom option:
-- Use Snowflake Snowsight > Data > Add Data, upload each file, and create these tables:
-- AIRBNB_ANALYTICS.RAW.LISTINGS
-- AIRBNB_ANALYTICS.RAW.CALENDAR
-- AIRBNB_ANALYTICS.RAW.REVIEWS
-- AIRBNB_ANALYTICS.RAW.NEIGHBOURHOODS
