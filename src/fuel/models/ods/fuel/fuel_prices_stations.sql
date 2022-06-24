{{
    config(
        materialized='incremental'
    )
}}


with fuel_prices as (

    select * from {{ ref('fuel_prices_format') }}

    {% if is_incremental() %}
      where upload_datetime > (select max(upload_datetime) from {{ this }})
    {% endif %}

),

fuel_stations as (

    select * from {{ ref('fuel_stations_format') }}

),

prices_stations_union as (

    select 
        prices.prix_diesel,
        prices.prix_essence,
        prices.prix_excelium_sp,
        prices.prix_aditive,
        prices.upload_datetime,
        stations.station,
        stations.city
    from fuel_prices as prices 
    join fuel_stations as stations on prices.station = stations.id_station

)

select * from prices_stations_union