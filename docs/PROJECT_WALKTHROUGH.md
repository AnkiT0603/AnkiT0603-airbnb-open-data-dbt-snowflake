# Project Walkthrough

## 1. Load Raw Data

Download the Inside Airbnb open dataset from:

https://insideairbnb.com/get-the-data/

For a large classroom dataset, use New York City and load:

- `listings.csv.gz`
- `calendar.csv.gz`
- `reviews.csv.gz`
- `neighbourhoods.csv`

These files should be loaded into the `AIRBNB_ANALYTICS.RAW` schema in Snowflake.

## 2. Define Sources

The file `models/sources.yml` tells dbt about the raw Snowflake tables.

Example:

```sql
{{ source('airbnb_raw', 'listings') }}
```

Use `source()` when reading raw data.

## 3. Build Staging Models

Staging models are located in `models/staging/`.

They:

- Rename fields
- Cast data types
- Clean price strings
- Convert `t` and `f` values into booleans
- Add simple calendar flags

Example:

```sql
not coalesce(is_available, true) as is_unavailable
```

## 4. Build Intermediate Logic

The intermediate models prepare reusable business logic.

Availability revenue proxy:

```text
estimated_unavailable_revenue = daily_price when listing is unavailable, otherwise 0
```

Inside Airbnb does not provide confirmed booking transactions, so unavailable-night revenue is an estimate and should be labeled that way.

## 5. Build Analytics Marts

The mart models are located in `models/marts/`.

They are the final tables analysts would use:

- `fct_listing_calendar`
- `fct_reviews`
- `dim_hosts`
- `dim_listings`
- `agg_listing_monthly_performance`
- `agg_neighbourhood_monthly_performance`

## 6. Test the Project

Run:

```powershell
dbt test --profiles-dir .
```

The project tests:

- Unique IDs
- Non-null IDs
- Valid relationships between calendar, reviews, and listings

## 7. Generate Documentation

Run:

```powershell
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .
```

Use the generated docs to inspect:

- Model descriptions
- Column descriptions
- Tests
- Source tables
- Model lineage
