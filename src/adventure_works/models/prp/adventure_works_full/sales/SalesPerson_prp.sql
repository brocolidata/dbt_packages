with source as (
    select * from {{source('adventure_works_full', 'SalesPerson')}}
),

prepared_source as (
    select
        CAST(BusinessEntityID AS int64) AS ID_entite_commerciale,
        CAST(TerritoryID AS int64) AS ID_territoire,
        CAST(SalesQuota AS numeric) AS quota_vente,
        CAST(Bonus AS numeric) AS prime,
        CAST(CommissionPct AS numeric) AS pourcentage_commission,
        CAST(SalesYTD AS numeric) AS ventes_YTD,
        CAST(SalesLastYear AS numeric) AS ventes_annee_derniere,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source