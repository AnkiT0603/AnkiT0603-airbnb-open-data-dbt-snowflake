{{
    config(
        materialized='incremental',
        unique_key=['listing_id', 'calendar_date'],
        incremental_strategy='merge',
        on_schema_change='sync_all_columns'
    )
}}

select
    listing_id,
    host_id,
    calendar_date,
    calendar_month,
    neighbourhood,
    neighbourhood_group,
    property_type,
    room_type,
    accommodates,
    is_available,
    is_unavailable,
    daily_price,
    minimum_nights,
    maximum_nights,
    estimated_unavailable_revenue
from {{ ref('int_listing_daily_availability') }}
