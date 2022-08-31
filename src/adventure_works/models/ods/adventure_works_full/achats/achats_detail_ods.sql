with purchaseorderdetail_prp as (

    select * from {{ ref('PurchaseOrderDetail_prp') }}
),

achats as (

    select 
        orderdetail.ID_commande_dachat,
        orderdetail.date_echeance_reception,
        orderdetail.quantite_commandee,
        orderdetail.ID_produit,
        orderdetail.prix_unitaire_achat,
        orderdetail.ligne_totale_achat,
        orderdetail.qte_recue,
        orderdetail.qte_rejetee,
        orderdetail.qte_stockee


    from purchaseorderdetail_prp as orderdetail 
)

select * from achats