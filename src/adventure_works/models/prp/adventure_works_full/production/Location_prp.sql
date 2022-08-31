with source as (

    select * from {{ source('adventure_works_full', 'Location') }}

),

renamed as (

    select
        cast(locationid as int64) as ID_emplacement,
        cast(name as string) as nom_emplacement,
        cast(costrate as numeric) as cout_standard_emplacement,
        cast(availability as numeric) as disponibilite_emplacement,
        cast(modifieddate as datetime) as date_modification

    from source

)

select * from renamed