create table if not exists AIRBNB_ANALYTICS.RAW.LISTINGS (
    id number,
    name string,
    host_id number,
    host_name string,
    host_since string,
    host_is_superhost string,
    host_listings_count string,
    neighbourhood_cleansed string,
    neighbourhood_group_cleansed string,
    latitude string,
    longitude string,
    property_type string,
    room_type string,
    accommodates string,
    bathrooms string,
    bathrooms_text string,
    bedrooms string,
    beds string,
    price string,
    minimum_nights string,
    maximum_nights string,
    availability_365 string,
    number_of_reviews string,
    reviews_per_month string,
    calculated_host_listings_count string,
    last_scraped string
);

create table if not exists AIRBNB_ANALYTICS.RAW.CALENDAR (
    listing_id number,
    date string,
    available string,
    price string,
    adjusted_price string,
    minimum_nights string,
    maximum_nights string
);

create table if not exists AIRBNB_ANALYTICS.RAW.REVIEWS (
    listing_id number,
    id number,
    date string,
    reviewer_id number,
    reviewer_name string,
    comments string
);

create table if not exists AIRBNB_ANALYTICS.RAW.NEIGHBOURHOODS (
    neighbourhood_group string,
    neighbourhood string
);
