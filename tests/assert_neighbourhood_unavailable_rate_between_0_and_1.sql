select
    neighbourhood,
    calendar_month,
    unavailable_rate
from {{ ref('agg_neighbourhood_monthly_performance') }}
where unavailable_rate < 0
   or unavailable_rate > 1

