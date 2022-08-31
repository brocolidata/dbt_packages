with source as (

    select * from {{ source('adventure_works_full', 'ShipMethod') }}

),

renamed as (

    select
        CAST(ShipMethodID AS int64) AS ID_methode_expedition,
        CAST(Name AS string) AS nom_methode_exepdition,
        CAST(ShipBase AS numeric) AS base_min_expedition,
        CAST(ShipRate AS numeric) AS taux_expedition,
        CAST(rowguid AS string) AS ID_ligne,
        CAST(ModifiedDate AS datetime) AS date_modifiee,


    from source

)

select * from renamed