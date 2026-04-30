with source as (

    select * from {{ source('airbnb_raw', 'calendar') }}

),

renamed as (

    select
        cast(listing_id as number) as listing_id,
        try_to_date(date) as calendar_date,
        case
            when lower(available) in ('t', 'true', '1', 'yes') then true
            when lower(available) in ('f', 'false', '0', 'no') then false
            else null
        end as is_available,
        try_to_decimal(regexp_replace(price, '[^0-9.]', ''), 12, 2) as listed_price,
        try_to_decimal(regexp_replace(adjusted_price, '[^0-9.]', ''), 12, 2) as adjusted_price,
        try_to_number(minimum_nights) as minimum_nights,
        try_to_number(maximum_nights) as maximum_nights
    from source

)

select
    *,
    not coalesce(is_available, true) as is_unavailable,
    date_trunc('month', calendar_date) as calendar_month
from renamed

