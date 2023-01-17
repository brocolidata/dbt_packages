with source as (

    select * from {{ source('adventure_works_full', 'WorkOrder') }}

),

renamed as (

    select
        CAST(workorderid as int64) as id_commande_travail,
        CAST(productid as int64) as id_produit,
        CAST(orderqty as int64) as quantite_commandee,
        CAST(stockedqty as int64) as quantite_stockee,
        CAST(scrappedqty as int64) as quantite_supprimee,
        CAST(startdate as datetime) as date_debut,
        CAST(enddate as datetime) as date_fin,
        CAST(duedate as datetime) as date_echeance,
        CAST(scrapreasonid as int64) as id_raison,
        CAST(modifieddate as datetime) as date_modification
    from source

)

select * from renamed
