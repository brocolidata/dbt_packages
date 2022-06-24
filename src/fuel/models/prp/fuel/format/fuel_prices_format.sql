
{{
    config(
        materialized='incremental'
    )
}}

with source as (

    select * from {{ source('macro_fuel', 'fuel_prices') }}

),

renamed as (
    
    select
        {% for col in ["prix_diesel", "prix_essence", "prix_excelium_sp","prix_aditive"] %}
        cast({{col}} as FLOAT64) as {{col}},
        {% endfor %}

        station,
        {{ cast_datetime('date') }} as upload_datetime

    from source

)

select * from renamed

{% if is_incremental() %}
  where upload_datetime > (select max(upload_datetime) from {{ this }})
{% endif %}