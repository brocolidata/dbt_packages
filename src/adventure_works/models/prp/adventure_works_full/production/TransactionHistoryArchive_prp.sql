with source as (

    select * from {{ source('adventure_works_full', 'TransactionHistoryArchive') }}

),

renamed as (

    select
        CAST(TransactionID AS int64) AS ID_transaction,
        CAST(ProductID AS int64) AS ID_produit,
        CAST(ReferenceOrderID AS int64) AS ID_commande,
        CAST(ReferenceOrderLineID AS int64) AS ID_ligne_commande,
        CAST(TransactionDate AS datetime) AS date_transaction,
        CAST(TransactionType AS string) AS type_transaction,
        CAST(Quantity AS int64) AS quantite_produit,
        CAST(ActualCost AS numeric) AS cout_produit,
        CAST(ModifiedDate AS datetime) AS date_modification

    from source

)

select * from renamed