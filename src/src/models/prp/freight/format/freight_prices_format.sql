{{
    config(
        materialized='incremental'
    )
}}


with source as (

    select * from {{ source('stg', 'freight_prices') }}

),

renamed as (

    select
        round(cast(min_price as NUMERIC), 2) as min_price,
        round(cast(max_price as NUMERIC), 2) as max_price,
        round(cast(price as NUMERIC), 2) as price,
        
        {{ cast_datetime('upload_date') }} as upload_datetime,
        
        cast(PARSE_DATETIME('%F', indexdate) as DATETIME) as price_date,
        
        lane_code

    from source

)

select * from renamed