with source as (

    select * from {{ source('adventure_works_full', 'ProductInventory') }}

),

renamed as (

    select
        cast(productid as int64) as id_produit,
        cast(locationid as int64) as id_emplacement,
        cast(shelf as string) as etagere,
        cast(bin as int64) as compartiment,
        cast(quantity as int64) as quantite_emplacement,
        cast(rowguid as string) as id_unique,
        cast(modifieddate as datetime) as date_modification

    from source

)

select * from renamed
