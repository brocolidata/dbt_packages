with source as (

    select * from {{ source('adventure_works_full', 'WorkOrderRouting') }}

),

renamed as (

    select
        CAST(WorkOrderID AS int64) AS ID_commande_travail,
        CAST(ProductID AS int64) AS ID_produit,
        CAST(OperationSequence AS int64) AS sequence_operation,
        CAST(LocationID AS int64) AS ID_emplacement,
        CAST(ScheduledStartDate AS datetime) AS date_debut_prevue,
        CAST(ScheduledEndDate AS datetime) AS date_fin_planifiee,
        CAST(ActualStartDate AS datetime) AS date_debut_reelle,
        CAST(ActualEndDate AS datetime) AS date_fin_reelle,
        CAST(ActualResourceHrs AS numeric) AS heures_ressources_reelles,
        CAST(PlannedCost AS numeric) AS cout_prevu,
        CAST(ActualCost AS numeric) AS prix_actuel,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source

)

select * from renamed



