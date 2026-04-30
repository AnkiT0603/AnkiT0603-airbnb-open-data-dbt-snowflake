select
    listing_id,
    calendar_date,
    daily_price
from {{ ref('fct_listing_calendar') }}
where daily_price < 0

