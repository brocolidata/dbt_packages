with source as (

    select * from {{ source('adventure_works_full', 'ProductCategory') }}

),

renamed as (

    select
        cast(productcategoryid as int64) as ID_categorie_produit,
        cast(name as string) as nom_categorie,
        cast(rowguid as string) as ID_unique,
        cast(modifieddate as datetime) as date_modification

    from source

)

select * from renamed