with special_offer_prp as (
    select * from {{ ref('SpecialOffer_prp') }}
),

special_offer_product_prp as (
    select * from {{ ref('SpecialOfferProduct_prp') }}
),

special_offer as (
    select
        id_offre_promotionnelle,
        description,
        pourcentage_remise,
        type_remise,
        beneficiaire_remise,
        date_debut,
        date_fin,
        remise_minimale,
        remise_maximale
    from special_offer_prp
),

special_offer_product as (
    select
        id_offre_promotionnelle,
        id_produit
    from special_offer_product_prp
),

offre_promotionnelle as (
    select
        so.*,
        sop.id_produit
    from special_offer as so
    left join
        special_offer_product as sop on
            so.id_offre_promotionnelle = sop.id_offre_promotionnelle
)

select * from offre_promotionnelle
