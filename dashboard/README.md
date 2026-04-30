# Dashboard Layer

This folder contains a Streamlit dashboard for exploring the final Snowflake mart tables built by dbt.

## Prerequisites

Run the dbt project first:

```powershell
dbt run --profiles-dir .
dbt test --profiles-dir .
```

Set the same Snowflake environment variables used by dbt:

```powershell
$env:SNOWFLAKE_ACCOUNT = "your_account_identifier"
$env:SNOWFLAKE_USER = "your_username"
$env:SNOWFLAKE_PASSWORD = "your_password"
$env:SNOWFLAKE_ROLE = "ACCOUNTADMIN"
$env:SNOWFLAKE_DATABASE = "AIRBNB_ANALYTICS"
$env:SNOWFLAKE_WAREHOUSE = "COMPUTE_WH"
```

The dashboard reads from:

```text
AIRBNB_ANALYTICS.MARTS.AGG_NEIGHBOURHOOD_MONTHLY_PERFORMANCE
AIRBNB_ANALYTICS.MARTS.AGG_LISTING_MONTHLY_PERFORMANCE
AIRBNB_ANALYTICS.MARTS.DIM_LISTINGS
AIRBNB_ANALYTICS.MARTS.DIM_HOSTS
```

## Run

```powershell
streamlit run dashboard/streamlit_app.py
```

