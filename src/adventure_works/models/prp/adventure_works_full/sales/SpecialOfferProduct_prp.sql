with source as (
    select *
    from
        {{ source('adventure_works_full', 'SpecialOfferProduct') }}
),

prepared_source as (
    select
        CAST(specialofferid as int64) as id_offre_promotionnelle,
        CAST(productid as int64) as id_produit,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
