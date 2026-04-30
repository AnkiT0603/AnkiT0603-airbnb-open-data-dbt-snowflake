# Data Dictionary

## Raw Tables

### `AIRBNB_ANALYTICS.RAW.LISTINGS`

Loaded from Inside Airbnb `listings.csv.gz`.

Important fields used by this project:

| Column | Description |
| --- | --- |
| `id` | Listing identifier |
| `name` | Listing name |
| `host_id` | Host identifier |
| `host_name` | Host name |
| `host_since` | Date host joined Airbnb |
| `host_is_superhost` | Whether host is marked as superhost |
| `neighbourhood_cleansed` | Standardized neighbourhood |
| `neighbourhood_group_cleansed` | Borough or neighbourhood group, when available |
| `latitude` | Listing latitude |
| `longitude` | Listing longitude |
| `property_type` | Property type |
| `room_type` | Room type |
| `accommodates` | Guest capacity |
| `bathrooms` | Bathroom count |
| `bedrooms` | Bedroom count |
| `beds` | Bed count |
| `price` | Listing price as a currency string |
| `availability_365` | Available days in next 365 days |
| `number_of_reviews` | Total review count |
| `reviews_per_month` | Average reviews per month |

### `AIRBNB_ANALYTICS.RAW.CALENDAR`

Loaded from Inside Airbnb `calendar.csv.gz`.

| Column | Description |
| --- | --- |
| `listing_id` | Listing identifier |
| `date` | Calendar date |
| `available` | Whether listing is available |
| `price` | Listed price for the date |
| `adjusted_price` | Adjusted price for the date |
| `minimum_nights` | Minimum nights for the date |
| `maximum_nights` | Maximum nights for the date |

### `AIRBNB_ANALYTICS.RAW.REVIEWS`

Loaded from Inside Airbnb `reviews.csv.gz`.

| Column | Description |
| --- | --- |
| `id` | Review identifier |
| `listing_id` | Listing identifier |
| `date` | Review date |
| `reviewer_id` | Reviewer identifier |
| `reviewer_name` | Reviewer name |
| `comments` | Review text |

### `AIRBNB_ANALYTICS.RAW.NEIGHBOURHOODS`

Loaded from Inside Airbnb `neighbourhoods.csv`.

| Column | Description |
| --- | --- |
| `neighbourhood_group` | Neighbourhood group |
| `neighbourhood` | Neighbourhood name |

## Final Analytics Models

### `dim_listings`

One row per listing with host, location, property, price, and review metrics.

### `dim_hosts`

One row per host with host profile and listing count metrics.

### `fct_listing_calendar`

One row per listing per calendar date. This is the main fact table for availability and estimated unavailable-night revenue.

### `fct_reviews`

One row per review.

### `agg_listing_monthly_performance`

One row per listing per month with availability, price, and estimated revenue metrics.

### `agg_neighbourhood_monthly_performance`

One row per neighbourhood per month with availability, price, and estimated revenue metrics.
