with source as (
    select * from {{ source('adventure_works_full', 'Currency') }}
),

prepared_source as (
    select
        CAST(currencycode as string) as code_devise,
        CAST(name as string) as nom_devise,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
