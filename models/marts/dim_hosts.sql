select
    host_id,
    any_value(host_name) as host_name,
    min(host_since) as host_since,
    boolor_agg(coalesce(host_is_superhost, false)) as host_is_superhost,
    max(host_listings_count) as host_listings_count,
    count(distinct listing_id) as listings_in_dataset,
    datediff(day, min(host_since), current_date()) as host_tenure_days
from {{ ref('stg_airbnb__listings') }}
group by 1

