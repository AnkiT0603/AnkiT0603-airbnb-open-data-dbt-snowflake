select
    listing_id,
    calendar_month,
    calendar_days,
    available_days,
    unavailable_days
from {{ ref('agg_listing_monthly_performance') }}
where calendar_days <> available_days + unavailable_days

