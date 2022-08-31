with source as (

    select * from {{ source('adventure_works_full', 'PurchaseOrderDetail') }}

),

renamed as (

    select

        CAST(PurchaseOrderID AS int64) AS ID_commande_dachat,
        CAST(PurchaseOrderDetailID AS int64) AS ID_ligne_commande_dachat,
        CAST(DueDate AS datetime) AS date_echeance_reception,
        CAST(OrderQty AS int64) AS quantite_commandee,
        CAST(ProductID AS int64) AS ID_produit,
        CAST(UnitPrice AS numeric) AS prix_unitaire_achat,
        CAST(LineTotal AS numeric) AS ligne_totale_achat,
        CAST(ReceivedQty AS numeric) AS qte_recue,
        CAST(RejectedQty AS numeric) AS qte_rejetee,
        CAST(StockedQty AS numeric) AS qte_stockee,
        CAST(ModifiedDate AS datetime) AS date_modifiee,
        
    from source

)

select * from renamed