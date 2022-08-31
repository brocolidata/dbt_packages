with source as (

    select * from {{ source('adventure_works_full', 'PurchaseOrderDetail') }}

),

renamed as (

    select

        CAST(purchaseorderid as int64) as id_commande_dachat,
        CAST(purchaseorderdetailid as int64) as id_ligne_commande_dachat,
        CAST(duedate as datetime) as date_echeance_reception,
        CAST(orderqty as int64) as quantite_commandee,
        CAST(productid as int64) as id_produit,
        CAST(unitprice as numeric) as prix_unitaire_achat,
        CAST(linetotal as numeric) as ligne_totale_achat,
        CAST(receivedqty as numeric) as qte_recue,
        CAST(rejectedqty as numeric) as qte_rejetee,
        CAST(stockedqty as numeric) as qte_stockee,
        CAST(modifieddate as datetime) as date_modifiee

    from source

)

select * from renamed
