with source as (

    select * from {{ source('adventure_works_full', 'ProductSubcategory') }}

),

renamed as (

    select
        cast(productsubcategoryid as int64) as id_sous_categorie_produit,
        cast(productcategoryid as int64) as id_categorie_produit,
        cast(name as string) as nom_sous_categorie,
        cast(rowguid as string) as id_unique,
        cast(modifieddate as datetime) as date_modification

    from source

)

select * from renamed
