with source as (
    select *
    from {{ source('adventure_works_full', 'Store') }}
),

prepared_source as (
    select
        CAST(businessentityid as int64) as id_entite_commerciale,
        CAST(name as string) as nom_magasin,
        CAST(salespersonid as int64) as id_vendeur,
        CAST(demographics as string) as statistiques_magasin,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
