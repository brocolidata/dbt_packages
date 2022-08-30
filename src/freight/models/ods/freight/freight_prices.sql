{{
    config(
        materialized='incremental'
    )
}}


with freight_prices as (

    select * from {{ ref('freight_prices_format') }}

    {% if is_incremental() %}
        where upload_datetime > (select max(upload_datetime) from {{ this }})
    {% endif %}

)

select * from freight_prices
