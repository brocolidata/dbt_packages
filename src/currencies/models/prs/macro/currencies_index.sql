with source as (

    select * from {{ ref('currencies_prices') }}

)

select * from source
