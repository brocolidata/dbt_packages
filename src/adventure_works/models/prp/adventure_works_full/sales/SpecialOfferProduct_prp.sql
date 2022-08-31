with source as (
    select * from {{source('adventure_works_full', 'SpecialOfferProduct')}}
),

prepared_source as (
    select
        CAST(SpecialOfferID AS int64) AS ID_offre_promotionnelle,
        CAST(ProductID AS int64) AS ID_produit,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source