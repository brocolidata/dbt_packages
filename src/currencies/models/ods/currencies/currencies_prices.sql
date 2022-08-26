{{
    config(
        materialized='incremental'
    )
}}


with currencies_prices as (

    select * from {{ ref('currencies_rates_format') }}

    {% if is_incremental() %}
        where upload_datetime > (select max(upload_datetime) from {{ this }})
    {% endif %}

)

select * from currencies_prices
