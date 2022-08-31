with source as (

    select * from {{ source('adventure_works_full', 'ProductVendor') }}

),

renamed as (

    select
        CAST(ProductID AS int64) AS ID_produit,
        CAST(BusinessEntityID AS int64) AS ID_fournisseur,
        CAST(AverageLeadTime AS int64) AS delai_moyen_reception,
        CAST(StandardPrice AS numeric) AS prix_standard,
        CAST(LastReceiptCost AS numeric) AS cout_derniere_reception,
        CAST(LastReceiptDate AS datetime) AS derniere_date_reception,
        CAST(MinOrderQty AS int64) AS qte_commande_minimale,
        CAST(MaxOrderQty AS int64) AS qte_commande_maximale,
        CAST(OnOrderQty AS int64) AS qte_commande_en_cours,
        CAST(UnitMeasureCode AS string) AS unite_de_mesure,
        CAST(ModifiedDate AS datetime) AS date_modifiee,


    from source

)

select * from renamed