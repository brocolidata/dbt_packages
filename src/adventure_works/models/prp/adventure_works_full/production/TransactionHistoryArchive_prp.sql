with source as (

    select *
    from {{ source('adventure_works_full', 'TransactionHistoryArchive') }}

),

renamed as (

    select
        CAST(transactionid as int64) as id_transaction,
        CAST(productid as int64) as id_produit,
        CAST(referenceorderid as int64) as id_commande,
        CAST(referenceorderlineid as int64) as id_ligne_commande,
        CAST(transactiondate as datetime) as date_transaction,
        CAST(transactiontype as string) as type_transaction,
        CAST(quantity as int64) as quantite_produit,
        CAST(actualcost as numeric) as cout_produit,
        CAST(modifieddate as datetime) as date_modification

    from source

)

select * from renamed
