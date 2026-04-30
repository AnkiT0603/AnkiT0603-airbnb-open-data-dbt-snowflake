select
    listing_id,
    count(*) as total_reviews,
    min(review_date) as first_review_date,
    max(review_date) as latest_review_date,
    count_if(review_date >= dateadd(month, -12, current_date())) as reviews_last_12_months
from {{ ref('stg_airbnb__reviews') }}
group by 1

