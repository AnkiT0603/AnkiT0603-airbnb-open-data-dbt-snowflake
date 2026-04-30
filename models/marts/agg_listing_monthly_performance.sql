select
    listing_id,
    host_id,
    calendar_month,
    neighbourhood,
    neighbourhood_group,
    property_type,
    room_type,
    count(*) as calendar_days,
    count_if(is_available) as available_days,
    count_if(is_unavailable) as unavailable_days,
    avg(daily_price) as average_daily_price,
    sum(estimated_unavailable_revenue) as estimated_unavailable_revenue,
    count_if(is_unavailable)::decimal / nullif(count(*), 0) as unavailable_rate
from {{ ref('fct_listing_calendar') }}
group by 1, 2, 3, 4, 5, 6, 7

