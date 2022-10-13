with produit as (

    select * from {{ ref('produit_ods') }}

),

stock as (

    select * from {{ ref('produit_stock_ods')}}
),


stock_union as (

    select 
        pdt.id_produit,
        pdt.nom_produit,
        pdt.numero_produit,
        pdt.est_manufacture_paraw,
        pdt.est_vendable,
        pdt.couleur,
        pdt.stock_securite,
        pdt.stock_alerte,
        pdt.cout_standard,
        pdt.prix_vente,
        pdt.taille_produit,
        pdt.code_unite_mesure_taille,
        pdt.code_unite_mesure_poids,
        pdt.poids_produit,
        pdt.nombre_jours_fabrication_produit,
        pdt.ligne_produit,
        pdt.gamme,
        pdt.style,
        pdt.id_sous_categorie_produit,
        pdt.id_model_produit,
        pdt.date_debut_vente,
        pdt.date_fin_vente,
        pdt.date_interruption,
        pdt.id_categorie_produit,
        pdt.nom_sous_categorie,

        stk.id_emplacement,
        stk.etagere,
        stk.compartiment,
        stk.quantite_emplacement,
        stk.nom_emplacement,
        stk.cout_standard_emplacement,
        stk.disponibilite_emplacement
    
    from produit as pdt
    left join stock as stk on pdt.id_produit = stk.id_produit
)

select * from stock_union


