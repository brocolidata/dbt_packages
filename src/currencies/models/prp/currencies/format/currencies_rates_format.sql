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
        cast(
            timestamp(format_timestamp('%F', upload_date)) as DATETIME
        ) as upload_date,
        cast(parse_datetime('%F', price_date) as DATETIME) as price_date,
        base_currency as mad_base,
        round(cast(usd as NUMERIC), 4) as usd_rate,
        round(cast(gbp as NUMERIC), 4) as gbp_rate,
        round(cast(eur as NUMERIC), 4) as euro_rate

    from source

)

select * from renamed
