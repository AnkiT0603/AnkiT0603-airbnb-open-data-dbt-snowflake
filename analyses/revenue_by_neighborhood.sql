select
    neighbourhood_group,
    neighbourhood,
    calendar_month,
    active_listings,
    average_daily_price,
    estimated_unavailable_revenue,
    unavailable_rate
from {{ ref('agg_neighbourhood_monthly_performance') }}
order by calendar_month, estimated_unavailable_revenue desc
