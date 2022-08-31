with source as (

    select * from {{ source('adventure_works_full', 'TransactionHistory') }}

),

renamed as (

    select
        cast(transactionid as int64) as ID_transaction,
        cast(productid as int64) as ID_produit,
        cast(referenceorderid as int64) as ID_commande,
        cast(referenceorderlineid as int64) as ID_ligne_commande,
        cast(transactiondate as datetime) as date_transaction,
        cast(transactiontype as string) as type_transaction,
        cast(quantity as int64) as quantite_produit,
        cast(actualcost as numeric) as cout_produit,
        cast(modifieddate as datetime) as date_modification

    from source

)

select * from renamed