with source as (

    select * from {{ source('airbnb_raw', 'listings') }}

),

renamed as (

    select
        cast(id as number) as listing_id,
        trim(name) as listing_name,
        cast(host_id as number) as host_id,
        trim(host_name) as host_name,
        try_to_date(host_since) as host_since,
        case
            when lower(host_is_superhost) in ('t', 'true', '1', 'yes') then true
            when lower(host_is_superhost) in ('f', 'false', '0', 'no') then false
            else null
        end as host_is_superhost,
        try_to_number(host_listings_count) as host_listings_count,
        trim(neighbourhood_cleansed) as neighbourhood,
        trim(neighbourhood_group_cleansed) as neighbourhood_group,
        try_to_decimal(latitude, 10, 6) as latitude,
        try_to_decimal(longitude, 10, 6) as longitude,
        trim(property_type) as property_type,
        trim(room_type) as room_type,
        try_to_number(accommodates) as accommodates,
        try_to_decimal(bathrooms, 4, 1) as bathrooms,
        trim(bathrooms_text) as bathrooms_text,
        try_to_number(bedrooms) as bedrooms,
        try_to_number(beds) as beds,
        try_to_decimal(regexp_replace(price, '[^0-9.]', ''), 12, 2) as nightly_price,
        try_to_number(minimum_nights) as minimum_nights,
        try_to_number(maximum_nights) as maximum_nights,
        try_to_number(availability_365) as availability_365,
        try_to_number(number_of_reviews) as number_of_reviews,
        try_to_decimal(reviews_per_month, 10, 2) as reviews_per_month,
        try_to_number(calculated_host_listings_count) as calculated_host_listings_count,
        try_to_timestamp(last_scraped) as last_scraped_at
    from source

)

select * from renamed
