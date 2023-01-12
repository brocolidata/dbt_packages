with source as (
    select *
    from
        {{ source('adventure_works_full', 'StateProvince') }}
),

prepared_source as (
    select
        CAST(stateprovinceid as int64) as id_province,
        CAST(stateprovincecode as string) as code_province,
        CAST(countryregioncode as string) as code_region,
        CAST(isonlystateprovinceflag as bool) as est_uniquement_une_province,
        CAST(name as string) as nom_province,
        CAST(territoryid as int64) as id_territoire,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
