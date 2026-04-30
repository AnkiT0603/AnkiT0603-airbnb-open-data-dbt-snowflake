# Student Guide: Airbnb Open Data Transformation with dbt

## Project Goal

You will transform the Inside Airbnb open dataset into clean analytics tables using Snowflake and dbt. The final output helps answer questions about listings, availability, estimated revenue, reviews, neighbourhoods, and hosts.

## Dataset

Download the dataset from:

https://insideairbnb.com/get-the-data/

Recommended city: **New York City, New York, United States**.

Download:

- `listings.csv.gz`
- `calendar.csv.gz`
- `reviews.csv.gz`
- `neighbourhoods.csv`

Your instructor may provide the files or ask you to download them yourself.

## Setup

Install:

- Python 3.11 or 3.12
- Access to a Snowflake account
- A code editor such as VS Code

Open PowerShell in the project folder:

```powershell
py -3.12 -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

Set Snowflake connection values:

```powershell
$env:SNOWFLAKE_ACCOUNT = "your_account_identifier"
$env:SNOWFLAKE_USER = "your_username"
$env:SNOWFLAKE_PASSWORD = "your_password"
$env:SNOWFLAKE_ROLE = "ACCOUNTADMIN"
$env:SNOWFLAKE_DATABASE = "AIRBNB_ANALYTICS"
$env:SNOWFLAKE_WAREHOUSE = "COMPUTE_WH"
$env:SNOWFLAKE_SCHEMA = "ANALYTICS"
```

Check the connection:

```powershell
dbt debug --profiles-dir .
```

Run the transformations:

```powershell
dbt run --profiles-dir .
dbt test --profiles-dir .
```

Generate documentation:

```powershell
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .
```

Run the dashboard:

```powershell
streamlit run dashboard/streamlit_app.py
```

## Raw Snowflake Tables

The downloaded files should be loaded into:

- `AIRBNB_ANALYTICS.RAW.LISTINGS`
- `AIRBNB_ANALYTICS.RAW.CALENDAR`
- `AIRBNB_ANALYTICS.RAW.REVIEWS`
- `AIRBNB_ANALYTICS.RAW.NEIGHBOURHOODS`

## Important dbt Commands

| Command | Purpose |
| --- | --- |
| `dbt debug --profiles-dir .` | Tests the Snowflake connection |
| `dbt run --profiles-dir .` | Builds dbt models |
| `dbt test --profiles-dir .` | Runs data quality tests |
| `dbt docs generate --profiles-dir .` | Creates documentation files |
| `dbt docs serve --profiles-dir .` | Opens dbt documentation website |
| `dbt run --select staging --profiles-dir .` | Runs only staging models |
| `dbt run --select fct_listing_calendar --profiles-dir .` | Runs one selected model |

## Project Layers

`staging` models clean and standardize raw data.

`intermediate` models contain reusable business logic.

`marts` models are designed for analytics and reporting.

Final models include:

- `dim_listings`
- `dim_hosts`
- `fct_listing_calendar`
- `fct_reviews`
- `agg_listing_monthly_performance`
- `agg_neighbourhood_monthly_performance`

The `fct_listing_calendar` model is incremental. In this classroom version, it demonstrates Snowflake merge and upsert behavior using `listing_id` and `calendar_date` as the unique key, while still scanning the full source snapshot because Inside Airbnb data can change across many dates.


## Business Metrics

| Metric | Meaning |
| --- | --- |
| `daily_price` | Listing price for a calendar date |
| `is_available` | Whether the listing is available on that date |
| `is_unavailable` | Whether the listing is unavailable on that date |
| `estimated_unavailable_revenue` | Price assigned to unavailable dates as an estimated revenue proxy |
| `unavailable_rate` | Unavailable days divided by total calendar days |

## Important Note

Inside Airbnb does not provide confirmed booking transactions. Unavailable dates may represent booked dates, blocked dates, or other unavailable periods. For that reason, the project uses the label `estimated_unavailable_revenue`, not confirmed booking revenue.

## Practice Questions

1. Which neighbourhood has the highest estimated unavailable-night revenue?
2. Which room type has the highest average daily price?
3. Which host has the most listings?
4. Which month has the lowest availability rate?
5. Which listings have the most reviews in the last 12 months?

## Extension Challenge

Create `agg_host_monthly_performance.sql` in `models/marts/`.

It should include:

- host ID
- host name
- calendar month
- total listings
- available days
- unavailable days
- average daily price
- estimated unavailable revenue
- unavailable rate
