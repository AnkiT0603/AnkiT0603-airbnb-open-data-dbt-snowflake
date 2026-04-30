# Airbnb Open Data Transformation with Snowflake and dbt

This project transforms the Inside Airbnb open dataset into clean reporting models using Snowflake and dbt.

## What This Project Shows

- Large open dataset ingestion into Snowflake
- Snowflake as the cloud data warehouse
- Staging models for cleaning and standardization
- Intermediate models for reusable business logic
- Mart models for analytics-ready reporting
- Incremental model for the large calendar fact table
- Streamlit dashboard layer for reporting
- Generic tests for data quality
- Documentation-ready model metadata

## Dataset

This project uses the Inside Airbnb open dataset:

https://insideairbnb.com/get-the-data/

Recommended classroom dataset: **New York City, New York, United States**.

Download these files:

- `listings.csv.gz`
- `calendar.csv.gz`
- `reviews.csv.gz`
- `neighbourhoods.csv`

Inside Airbnb does not provide actual booking transactions. This project uses calendar availability and price data to estimate unavailable-night revenue.

## Classroom Documentation

- `docs/INSTRUCTOR_GUIDE.md`: lesson plan, learning objectives, teaching flow, assignments, and rubric
- `docs/STUDENT_GUIDE.md`: setup instructions, dbt commands, project overview, and exercises
- `docs/SNOWFLAKE_SETUP.md`: Snowflake database, warehouse, profile, and environment setup
- `docs/INSIDE_AIRBNB_DATASET.md`: dataset source, recommended files, and loading notes
- `docs/DATA_DICTIONARY.md`: raw and final model field descriptions
- `docs/PROJECT_WALKTHROUGH.md`: step-by-step explanation of how data moves through the project

## Project Structure

```text
.
|-- dbt_project.yml
|-- profiles.yml.example
|-- requirements.txt
|-- models/
|   |-- staging/
|   |-- intermediate/
|   `-- marts/
|-- tests/
|-- setup/
|   `-- snowflake_setup.sql
|-- dashboard/
|   |-- README.md
|   `-- streamlit_app.py
|-- analyses/
`-- docs/
```

## Quick Start

Create Snowflake objects:

```sql
-- Run setup/snowflake_setup.sql in Snowflake
```

Load the Inside Airbnb files into these Snowflake tables:

- `AIRBNB_ANALYTICS.RAW.LISTINGS`
- `AIRBNB_ANALYTICS.RAW.CALENDAR`
- `AIRBNB_ANALYTICS.RAW.REVIEWS`
- `AIRBNB_ANALYTICS.RAW.NEIGHBOURHOODS`

Create a virtual environment:

```powershell
py -3.12 -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

Configure Snowflake connection variables:

```powershell
$env:SNOWFLAKE_ACCOUNT = "your_account_identifier"
$env:SNOWFLAKE_USER = "your_username"
$env:SNOWFLAKE_PASSWORD = "your_password"
$env:SNOWFLAKE_ROLE = "ACCOUNTADMIN"
$env:SNOWFLAKE_DATABASE = "AIRBNB_ANALYTICS"
$env:SNOWFLAKE_WAREHOUSE = "COMPUTE_WH"
$env:SNOWFLAKE_SCHEMA = "ANALYTICS"
```

Run the project:

```powershell
dbt debug --profiles-dir .
dbt run --profiles-dir .
dbt run --full-refresh --select fct_listing_calendar --profiles-dir .
dbt test --profiles-dir .
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .
```

Run the dashboard:

```powershell
streamlit run dashboard/streamlit_app.py
```

## Final Models

- `dim_listings`: one row per listing with host, location, property, price, and review attributes
- `dim_hosts`: one row per host
- `fct_listing_calendar`: one row per listing per calendar date
- `fct_reviews`: one row per review
- `agg_listing_monthly_performance`: monthly listing availability, price, and estimated revenue metrics
- `agg_neighbourhood_monthly_performance`: monthly neighbourhood performance metrics

`fct_listing_calendar` is configured as an incremental model because the Inside Airbnb calendar table can be large.

When loading a new Inside Airbnb dataset snapshot, run:
`dbt run --full-refresh --select fct_listing_calendar --profiles-dir .`


## Example Business Questions

- Which neighbourhoods have the highest estimated unavailable-night revenue?
- Which room types have the highest average daily price?
- Which hosts manage the most listings?
- Which neighbourhoods have the lowest availability rate?
- How does listing availability vary by month?
