with source as (
    select * from {{ source('adventure_works_full', 'Customer') }}
),

prepared_source as (
    select
        CAST(customerid as int64) as id_client,
        CAST(personid as int64) as id_personne,
        CAST(storeid as int64) as id_magasin,
        CAST(territoryid as int64) as id_territoire,
        CAST(accountnumber as string) as numero_compte,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
