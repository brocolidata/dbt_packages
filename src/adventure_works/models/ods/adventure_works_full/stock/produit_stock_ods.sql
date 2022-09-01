with productinventory_prp as (

    select * from {{ ref('ProductInventory_prp') }}
),

location_prp as (

    select * from {{ ref('Location_prp') }}
),

stock_produit as (

    select
        inv.id_produit,
        inv.id_emplacement,
        inv.etagere,
        inv.compartiment,
        inv.quantite_emplacement,
        loc.nom_emplacement,
        loc.cout_standard_emplacement,
        loc.disponibilite_emplacement

    from productinventory_prp as inv
    left join location_prp as loc on inv.id_emplacement = loc.id_emplacement

)

select * from stock_produit
