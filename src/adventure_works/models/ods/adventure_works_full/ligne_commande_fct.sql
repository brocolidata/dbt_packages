with sales_order_detail_prp as (
    select * from {{ ref('SalesOrderDetail_prp') }}
),

sales_order_detail as (
    select
        id_commande_commerciale,
        id_ligne_commande,
        numero_suivi_transporteur,
        quantite_commandee,
        id_produit,
        id_offre_promotionnelle,
        prix_unitaire,
        remise,
        total_ligne
    from sales_order_detail_prp
)

select * from sales_order_detail
