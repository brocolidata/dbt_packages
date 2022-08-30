with source as (

    select * from {{ ref('fuel_stations') }}

),


renamed as (
    
    select
        station,
        city,
        cast(id_station as string) as id_station
    from source

)

select * from renamed