{{
    config(
        materialized='incremental'
    )
}}


with source as (

    select * from {{ source('macro_currencies', 'currencies_exchange_rate') }}

),

renamed as (

    select
        cast(TIMESTAMP(FORMAT_TIMESTAMP('%F',upload_date)) as DATETIME) as upload_date,
        cast(PARSE_DATETIME('%F', price_date) as DATETIME) as price_date,
        round(cast(usd as NUMERIC), 4) as usd_rate,
        round(cast(gbp as NUMERIC), 4) as gbp_rate,
        round(cast(eur as NUMERIC), 4) as euro_rate,
        base_currency as mad_base

    from source

)

select * from renamed