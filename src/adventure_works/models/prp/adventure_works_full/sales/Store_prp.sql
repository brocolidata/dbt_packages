with source as (
    select * from {{source('adventure_works_full', 'Store')}}
),

prepared_source as (
    select
        CAST(BusinessEntityID AS int64) AS ID_entite_commerciale,
        CAST(Name AS string) AS nom_magasin,
        CAST(SalesPersonID AS int64) AS ID_vendeur,
        CAST(Demographics AS string) AS statistiques_magasin,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source