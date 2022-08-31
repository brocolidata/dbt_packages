with source as (
    select * from {{source('adventure_works_full', 'StateProvince')}}
),

prepared_source as (
    select
        CAST(StateProvinceID AS int64) AS ID_province,
        CAST(StateProvinceCode AS string) AS code_province,
        CAST(CountryRegionCode AS string) AS code_region,
        CAST(IsOnlyStateProvinceFlag AS bool) AS est_uniquement_une_province,
        CAST(Name AS string) AS nom_province,
        CAST(TerritoryID AS int64) AS ID_territoire,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source