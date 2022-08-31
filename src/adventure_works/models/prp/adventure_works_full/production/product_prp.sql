with source as (

    select * from {{ source('adventure_works_full', 'Product') }}

),

renamed as (

    select
        cast(productid as int64) as id_produit,
        cast(name as string) as nom_produit,
        cast(productnumber as string) as numero_produit,
        cast(makeflag as bool) as est_manufacture_paraw,
        cast(finishedgoodsflag as bool) as est_vendable,
        cast(color as string) as couleur,
        cast(safetystocklevel as int64) as stock_securite,
        cast(reorderpoint as int64) as stock_alerte,
        cast(standardcost as numeric) as cout_standard,
        cast(listprice as numeric) as prix_vente,
        cast(size as string) as taille_produit,
        cast(sizeunitmeasurecode as string) as code_unite_mesure_taille,
        cast(weightunitmeasurecode as string ) as code_unite_mesure_poids,
        cast(weight as numeric) as poids_produit,
        cast(daystomanufacture as int64) as nombre_jours_fabrication_produit,
        cast(productsubcategoryid as int64) as id_sous_categorie_produit,
        cast(productmodelid as int64) as id_model_produit,
        cast(sellstartdate as datetime) as date_debut_vente,
        cast(sellenddate as datetime) as date_fin_vente,
        cast(discontinueddate as datetime) as date_interruption,
        cast(rowguid as string) as id_unique,
        cast(modifieddate as datetime) as date_modification,
        case
            when trim(productline) = 'R' then 'route'
            when trim(productline) = 'M' then 'montagne'
            when trim(productline) = 'T' then 'tournee'
            when trim(productline) = 'S' then 'standard'
            else trim(productline)
        end as gamme,
        case
            when trim(class) = 'H' then 'haut'
            when trim(class) = 'M' then 'milieu'
            when trim(class) = 'L' then 'bas'
            else trim(class)
        end as ligne_produit,
        case
            when trim(style) = 'W' then 'Femme'
            when trim(style) = 'M' then 'Homme'
            when trim(style) = 'U' then 'Universel'
            else trim(style)
        end as style

    from source

)

select * from renamed
