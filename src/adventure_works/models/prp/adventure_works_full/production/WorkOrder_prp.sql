with source as (

    select * from {{ source('adventure_works_full', 'WorkOrder') }}

),

renamed as (

    select
        CAST(WorkOrderID AS int64) AS ID_commande_travail,
        CAST(ProductID AS int64) AS ID_produit,
        CAST(OrderQty AS int64) AS quantite_commandee,
        CAST(StockedQty AS int64) AS quantite_stockee,
        CAST(ScrappedQty AS int64) AS quantite_supprimee,
        CAST(StartDate AS datetime) AS date_debut,
        CAST(EndDate AS datetime) AS date_fin,
        CAST(DueDate AS datetime) AS date_echeance,
        CAST(ScrapReasonID AS int64) AS ID_raison,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source

)

select * from renamed



