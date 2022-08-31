with source as (
    select * from {{ source('adventure_works_full', 'SalesTerritory') }}
),

prepared_source as (
    select
        CAST(TerritoryID AS int64) AS ID_territoire,
        CAST(Name AS string) AS nom_territoire,
        CAST(CountryRegionCode AS string) AS code_region,
        CAST(Groupe AS string) AS zone_geographique,
        CAST(SalesYTD AS numeric) AS ventes_YTD,
        CAST(SalesLastYear AS numeric) AS ventes_annee_derniere,
        CAST(CostYTD AS numeric) AS cout_YTD,
        CAST(CostLastYear AS numeric) AS cout_annee_derniere,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source