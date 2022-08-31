with source as (
    select *
    from
        {{ source('adventure_works_full', 'SalesPerson') }}
),

prepared_source as (
    select
        CAST(businessentityid as int64) as id_entite_commerciale,
        CAST(territoryid as int64) as id_territoire,
        CAST(salesquota as numeric) as quota_vente,
        CAST(bonus as numeric) as prime,
        CAST(commissionpct as numeric) as pourcentage_commission,
        CAST(salesytd as numeric) as ventes_ytd,
        CAST(saleslastyear as numeric) as ventes_annee_derniere,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
