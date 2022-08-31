with source as (
    select * from {{source('adventure_works_full', 'SalesOrderDetail')}}
),

prepared_source as (
    select
        CAST(SalesOrderID AS int64) AS ID_commande_commerciale,
        CAST(SalesOrderDetailID AS int64) AS ID_ligne_commande,
        CAST(CarrierTrackingNumber AS string) AS numero_suivi_transporteur,
        CAST(OrderQty AS int64) AS quantite_commandee,
        CAST(ProductID AS int64) AS ID_produit,
        CAST(SpecialOfferID AS int64) AS ID_offre_promotionnelle,
        CAST(UnitPrice AS numeric) AS prix_unitaire,
        CAST(UnitPriceDiscount AS numeric) AS remise,
        CAST(LineTotal AS bignumeric) AS total_ligne,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source