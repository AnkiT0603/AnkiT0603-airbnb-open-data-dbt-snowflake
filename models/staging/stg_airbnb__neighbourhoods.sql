with source as (

    select * from {{ source('airbnb_raw', 'neighbourhoods') }}

)

select
    trim(neighbourhood_group) as neighbourhood_group,
    trim(neighbourhood) as neighbourhood
from source

