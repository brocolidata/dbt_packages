with source as (
    select * from {{ source('adventure_works_full', 'Customer') }}
),

prepared_source as (
    select
        CAST(CustomerID AS int64) AS ID_client,
        CAST(PersonID AS int64) AS ID_personne,
        CAST(StoreID AS int64) AS ID_magasin,
        CAST(TerritoryID AS int64) AS ID_territoire,
        CAST(AccountNumber AS string) AS numero_compte,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source