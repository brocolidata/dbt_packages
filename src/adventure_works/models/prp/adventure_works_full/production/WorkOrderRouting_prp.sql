with source as (

    select * from {{ source('adventure_works_full', 'WorkOrderRouting') }}

),

renamed as (

    select
        CAST(workorderid as int64) as id_commande_travail,
        CAST(productid as int64) as id_produit,
        CAST(operationsequence as int64) as sequence_operation,
        CAST(locationid as int64) as id_emplacement,
        CAST(scheduledstartdate as datetime) as date_debut_prevue,
        CAST(scheduledenddate as datetime) as date_fin_planifiee,
        CAST(actualstartdate as datetime) as date_debut_reelle,
        CAST(actualenddate as datetime) as date_fin_reelle,
        CAST(actualresourcehrs as numeric) as heures_ressources_reelles,
        CAST(plannedcost as numeric) as cout_prevu,
        CAST(actualcost as numeric) as prix_actuel,
        CAST(modifieddate as datetime) as date_modification
    from source

)

select * from renamed
