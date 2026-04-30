# Snowflake Setup Guide

This project uses Snowflake and dbt to transform the Inside Airbnb open dataset for reporting.

## 1. Create Snowflake Objects

Run `setup/snowflake_setup.sql` in a Snowflake worksheet.

It creates:

- `AIRBNB_ANALYTICS`
- `COMPUTE_WH`
- `RAW`
- `STAGING`
- `INTERMEDIATE`
- `MARTS`

## 2. Load Inside Airbnb Files

Download the data from:

https://insideairbnb.com/get-the-data/

Recommended classroom city: **New York City**.

Load these files into Snowflake:

| Inside Airbnb file | Snowflake table |
| --- | --- |
| `listings.csv.gz` | `AIRBNB_ANALYTICS.RAW.LISTINGS` |
| `calendar.csv.gz` | `AIRBNB_ANALYTICS.RAW.CALENDAR` |
| `reviews.csv.gz` | `AIRBNB_ANALYTICS.RAW.REVIEWS` |
| `neighbourhoods.csv` | `AIRBNB_ANALYTICS.RAW.NEIGHBOURHOODS` |

The simplest classroom method is Snowflake Snowsight:

1. Go to **Data > Add Data**.
2. Upload one file.
3. Create the matching table in `AIRBNB_ANALYTICS.RAW`.
4. Repeat for all four files.

## 3. Configure dbt Profile

The project uses environment variables so credentials are not hardcoded.

```powershell
$env:SNOWFLAKE_ACCOUNT = "your_account_identifier"
$env:SNOWFLAKE_USER = "your_username"
$env:SNOWFLAKE_PASSWORD = "your_password"
$env:SNOWFLAKE_ROLE = "ACCOUNTADMIN"
$env:SNOWFLAKE_DATABASE = "AIRBNB_ANALYTICS"
$env:SNOWFLAKE_WAREHOUSE = "COMPUTE_WH"
$env:SNOWFLAKE_SCHEMA = "ANALYTICS"
```

## 4. Install dbt

Use Python 3.11 or 3.12.

```powershell
py -3.12 -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

## 5. Run the Pipeline

```powershell
dbt debug --profiles-dir .
dbt run --profiles-dir .
dbt test --profiles-dir .
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .
```

## 6. Refreshing New Dataset Snapshots

When you download and load a new Inside Airbnb dataset snapshot, run:

```powershell
dbt run --full-refresh --select fct_listing_calendar --profiles-dir .


Small note: in normal daily use, students can run:

```powershell
dbt run --profiles-dir .
