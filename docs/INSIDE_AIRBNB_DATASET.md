# Inside Airbnb Open Dataset

This project is designed for the Inside Airbnb open dataset.

Primary source:

https://insideairbnb.com/get-the-data/

Recommended classroom dataset:

New York City, New York, United States

Recommended files:

| File | Use |
| --- | --- |
| `listings.csv.gz` | Detailed listing, host, location, property, pricing, and review summary data |
| `calendar.csv.gz` | Daily availability and price data for each listing |
| `reviews.csv.gz` | Detailed review data |
| `neighbourhoods.csv` | Neighbourhood reference data |

Inside Airbnb data is large enough for students to practice realistic warehouse loading and transformation patterns. For example, the calendar file usually contains one row per listing per date, which can quickly become millions of rows for large cities.

## Important Note About Bookings

Inside Airbnb does not publish actual Airbnb booking transactions. The `calendar.csv.gz` file includes availability and price by listing/date. This project therefore models:

- listing analytics
- availability analytics
- review analytics
- estimated unavailable-night revenue
- neighbourhood performance

The project avoids claiming that unavailable nights are confirmed bookings. They may represent bookings, blocked dates, or other unavailable dates.

## Suggested Download Flow

1. Open https://insideairbnb.com/get-the-data/
2. Search for `New York City`.
3. Download:
   - `listings.csv.gz`
   - `calendar.csv.gz`
   - `reviews.csv.gz`
   - `neighbourhoods.csv`
4. Upload these files into Snowflake table names:
   - `AIRBNB_ANALYTICS.RAW.LISTINGS`
   - `AIRBNB_ANALYTICS.RAW.CALENDAR`
   - `AIRBNB_ANALYTICS.RAW.REVIEWS`
   - `AIRBNB_ANALYTICS.RAW.NEIGHBOURHOODS`

Use Snowflake Snowsight's **Data > Add Data** workflow for the simplest classroom setup.

