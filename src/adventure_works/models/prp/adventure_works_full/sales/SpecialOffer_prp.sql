with source as (
    select * from {{ source('adventure_works_full', 'SpecialOffer') }}
),

prepared_source as (
    select
        CAST(SpecialOfferID AS int64) AS ID_offre_promotionnelle,
        CAST(Description AS string) AS description,
        CAST(DiscountPct AS numeric) AS pourcentage_remise,
        CAST(Type AS string) AS type_remise,
        CAST(Category AS string) AS beneficiaire_remise,
        CAST(StartDate AS datetime) AS date_debut,
        CAST(EndDate AS datetime) AS date_fin,
        CAST(MinQty AS int64) AS remise_minimale,
        CAST(MaxQty AS int64) AS remise_maximale,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source