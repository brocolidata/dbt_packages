with source as (
    select * from {{ source('adventure_works_full', 'SpecialOffer') }}
),

prepared_source as (
    select
        CAST(specialofferid as int64) as id_offre_promotionnelle,
        CAST(description as string) as description,
        CAST(discountpct as numeric) as pourcentage_remise,
        CAST(type as string) as type_remise,
        CAST(category as string) as beneficiaire_remise,
        CAST(startdate as datetime) as date_debut,
        CAST(enddate as datetime) as date_fin,
        CAST(minqty as int64) as remise_minimale,
        CAST(maxqty as int64) as remise_maximale,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
