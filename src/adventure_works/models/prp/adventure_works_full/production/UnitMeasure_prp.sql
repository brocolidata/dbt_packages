with source as (

    select * from {{ source('adventure_works_full', 'UnitMeasure') }}

),

renamed as (

    select
        cast(unitmeasurecode as string) as code_unite_mesure,
        cast(name as string) as nom_unite_mesure,
        cast(modifieddate as datetime) as date_modification

    from source

)

select * from renamed