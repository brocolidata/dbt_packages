with workorder as (

    select * from {{ ref('WorkOrder_prp') }}

),

workorder_ods as (

    select
        ID_commande_travail,
        ID_produit,
        quantite_commandee,
        quantite_stockee,
        quantite_supprimee,
        date_debut,
        date_fin,
        date_echeance,
        ID_raison,
        date_modification
    from workorder

)

select * from workorder_ods