select
    review_id,
    listing_id,
    review_date,
    reviewer_id,
    reviewer_name,
    review_comments
from {{ ref('stg_airbnb__reviews') }}

