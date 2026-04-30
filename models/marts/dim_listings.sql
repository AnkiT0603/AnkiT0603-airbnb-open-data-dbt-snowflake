with listings as (

    select * from {{ ref('stg_airbnb__listings') }}

),

review_metrics as (

    select * from {{ ref('int_listing_review_metrics') }}

)

select
    listings.listing_id,
    listings.host_id,
    listings.host_name,
    listings.host_since,
    listings.host_is_superhost,
    listings.host_listings_count,
    listings.listing_name,
    listings.neighbourhood,
    listings.neighbourhood_group,
    listings.latitude,
    listings.longitude,
    listings.property_type,
    listings.room_type,
    listings.accommodates,
    listings.bedrooms,
    listings.bathrooms,
    listings.bathrooms_text,
    listings.beds,
    listings.nightly_price,
    listings.minimum_nights,
    listings.maximum_nights,
    listings.availability_365,
    listings.number_of_reviews,
    listings.reviews_per_month,
    coalesce(review_metrics.total_reviews, 0) as total_reviews_from_reviews_file,
    review_metrics.first_review_date,
    review_metrics.latest_review_date,
    coalesce(review_metrics.reviews_last_12_months, 0) as reviews_last_12_months,
    listings.last_scraped_at
from listings
left join review_metrics
    on listings.listing_id = review_metrics.listing_id
