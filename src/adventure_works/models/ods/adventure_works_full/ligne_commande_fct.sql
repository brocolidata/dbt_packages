with sales_order_detail_prp as (
    select * from {{ ref('SalesOrderDetail_prp') }}
),

sales_order_detail as (
    select 
        ID_commande_commerciale,
        ID_ligne_commande,
        numero_suivi_transporteur,
        quantite_commandee,
        ID_produit,
        ID_offre_promotionnelle,
        prix_unitaire,
        remise,
        total_ligne
    from sales_order_detail_prp
)

select * from sales_order_detail