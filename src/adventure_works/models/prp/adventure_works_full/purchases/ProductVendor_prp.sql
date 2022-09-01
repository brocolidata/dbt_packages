with source as (

    select * from {{ source('adventure_works_full', 'ProductVendor') }}

),

renamed as (

    select
        CAST(productid as int64) as id_produit,
        CAST(businessentityid as int64) as id_fournisseur,
        CAST(averageleadtime as int64) as delai_moyen_reception,
        CAST(standardprice as numeric) as prix_standard,
        CAST(lastreceiptcost as numeric) as cout_derniere_reception,
        CAST(lastreceiptdate as datetime) as derniere_date_reception,
        CAST(minorderqty as int64) as qte_commande_minimale,
        CAST(maxorderqty as int64) as qte_commande_maximale,
        CAST(onorderqty as int64) as qte_commande_en_cours,
        CAST(unitmeasurecode as string) as unite_de_mesure,
        CAST(modifieddate as datetime) as date_modifiee


    from source

)

select * from renamed
