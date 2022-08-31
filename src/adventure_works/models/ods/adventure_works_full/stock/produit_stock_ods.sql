with productinventory_prp as (

    select * from {{ ref('ProductInventory_prp') }}
),

location_prp as (

    select * from {{ ref('Location_prp') }}
),

stock_produit as (

    select 
        inv.ID_produit,
        inv.ID_emplacement,
        inv.etagere,
        inv.compartiment,
        inv.quantite_emplacement,
        loc.nom_emplacement,
        loc.cout_standard_emplacement,
        loc.disponibilite_emplacement
    
    from productinventory_prp as inv 
    left join location_prp as loc on inv.ID_emplacement = loc.ID_emplacement

)

select * from stock_produit