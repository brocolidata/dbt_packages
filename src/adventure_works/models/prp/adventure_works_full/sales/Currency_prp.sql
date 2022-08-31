with source as (
    select * from {{ source('adventure_works_full', 'Currency') }}
),

prepared_source as (
    select
        CAST(CurrencyCode AS string) AS code_devise,
        CAST(Name AS string) AS nom_devise,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source