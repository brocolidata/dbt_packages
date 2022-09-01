with source as (

    select * from {{ source('adventure_works_full', 'ShipMethod') }}

),

renamed as (

    select
        CAST(shipmethodid as int64) as id_methode_expedition,
        CAST(name as string) as nom_methode_exepdition,
        CAST(shipbase as numeric) as base_min_expedition,
        CAST(shiprate as numeric) as taux_expedition,
        CAST(rowguid as string) as id_ligne,
        CAST(modifieddate as datetime) as date_modifiee


    from source

)

select * from renamed
