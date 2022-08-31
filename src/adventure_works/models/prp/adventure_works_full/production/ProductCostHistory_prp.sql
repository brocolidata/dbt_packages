with source as (

    select * from {{ source('adventure_works_full', 'ProductCostHistory') }}

),

renamed as (

    select
        cast(productid as int64) as ID_produit,
        cast(startdate as datetime) as date_debut_cout_produit,
        cast(enddate as datetime) as date_fin_cout_produit,
        cast(standardcost as numeric) as cout_standard,
        cast(modifieddate as datetime) as date_modification

    from source

)

select * from renamed