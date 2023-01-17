with workorder_prp as (

    select * from {{ ref('WorkOrder_prp') }}
),

prod as (

    select
        wo.id_commande_travail,
        wo.id_produit,
        wo.quantite_commandee,
        wo.quantite_stockee,
        wo.quantite_supprimee,
        wo.date_debut,
        wo.date_fin as date_mouvement,
        wo.date_echeance,
        wo.id_raison,
        wo.date_modification


    from workorder_prp as wo
)

select * from prod
