with source as (

    select * from {{ ref('freight_prices') }}

)

select * from source
