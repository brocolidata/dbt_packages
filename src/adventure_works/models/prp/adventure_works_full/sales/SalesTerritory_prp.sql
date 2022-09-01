with source as (
    select * from {{ source('adventure_works_full', 'SalesTerritory') }}
),

prepared_source as (
    select
        CAST(territoryid as int64) as id_territoire,
        CAST(name as string) as nom_territoire,
        CAST(countryregioncode as string) as code_region,
        CAST(groupe as string) as zone_geographique,
        CAST(salesytd as numeric) as ventes_ytd,
        CAST(saleslastyear as numeric) as ventes_annee_derniere,
        CAST(costytd as numeric) as cout_ytd,
        CAST(costlastyear as numeric) as cout_annee_derniere,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
