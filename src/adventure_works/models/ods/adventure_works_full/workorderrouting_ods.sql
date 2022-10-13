with workorderrouting as (

    select * from {{ ref('WorkOrderRouting_prp') }}
),

workorderrouting_ods as (

    select
        id_commande_travail,
        id_produit,
        sequence_operation,
        id_emplacement,
        date_debut_prevue,
        date_fin_planifiee,
        date_debut_reelle,
        date_fin_reelle,
        heures_ressources_reelles,
        cout_prevu,
        prix_actuel,
        date_modification
    from workorderrouting

)

select * from workorderrouting_ods


