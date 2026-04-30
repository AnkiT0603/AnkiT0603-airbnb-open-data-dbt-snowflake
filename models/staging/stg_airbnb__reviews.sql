with source as (

    select * from {{ source('airbnb_raw', 'reviews') }}

)

select
    cast(id as number) as review_id,
    cast(listing_id as number) as listing_id,
    try_to_date(date) as review_date,
    cast(reviewer_id as number) as reviewer_id,
    trim(reviewer_name) as reviewer_name,
    comments as review_comments
from source

