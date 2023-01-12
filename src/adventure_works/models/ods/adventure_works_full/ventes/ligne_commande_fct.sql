with sales_order_detail_prp as (
    select * from {{ ref('SalesOrderDetail_prp') }}
),

sales_order_header_prp as (
    select * from {{ ref('SalesOrderHeader_prp') }}
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
),

sales_order_header as (
    select
        id_commande,
        date_commande,
        date_echeance,
        date_expedition as date_mouvement,
        est_une_commande_internet,
        id_client,
        id_vendeur,
        id_territoire,
        id_methode_livraison
    from sales_order_header_prp
),

ligne_commande as (
    select
        sod.* except(id_commande_commerciale),
        soh.*
    from sales_order_detail as sod
    left join sales_order_header as soh
        on sod.id_commande_commerciale = soh.id_commande
)

select * from ligne_commande
