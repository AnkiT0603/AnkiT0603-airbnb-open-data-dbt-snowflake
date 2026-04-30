with calendar as (

    select * from {{ ref('stg_airbnb__calendar') }}

),

listings as (

    select * from {{ ref('stg_airbnb__listings') }}

)

select
    calendar.listing_id,
    listings.host_id,
    calendar.calendar_date,
    calendar.calendar_month,
    listings.neighbourhood,
    listings.neighbourhood_group,
    listings.property_type,
    listings.room_type,
    listings.accommodates,
    calendar.is_available,
    calendar.is_unavailable,
    coalesce(calendar.adjusted_price, calendar.listed_price, listings.nightly_price) as daily_price,
    calendar.minimum_nights,
    calendar.maximum_nights,
    case
        when calendar.is_unavailable then coalesce(calendar.adjusted_price, calendar.listed_price, listings.nightly_price)
        else 0
    end as estimated_unavailable_revenue
from calendar
left join listings
    on calendar.listing_id = listings.listing_id

