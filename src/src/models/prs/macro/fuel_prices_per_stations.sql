with source as (

    select * from {{ ref('fuel_prices_stations') }}
    
)

select * from source