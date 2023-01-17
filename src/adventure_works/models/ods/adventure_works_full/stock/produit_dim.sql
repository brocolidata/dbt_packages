with product_prp as (

    select * from {{ ref('product_prp') }}
),

productcategory_prp as (

    select * from {{ ref('ProductCategory_prp') }}
),

productsubcategory_prp as (

    select * from {{ ref('ProductSubcategory_prp') }}
),

unitmeasure_prp as (

    select * from {{ ref('UnitMeasure_prp') }}
),

product_costhistory_prp as (

    select * from {{ ref('ProductCostHistory_prp') }}
),

product_union as (
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
        sub.id_categorie_produit,
        sub.nom_sous_categorie,
        unitt.nom_unite_mesure as unite_mesure_taille,
        unitp.nom_unite_mesure as unite_mesure_poids,
        cost.date_debut_cout_produit,
        cost.date_fin_cout_produit,
        coalesce(cat.nom_categorie, 'Others') as nom_categorie
    from product_prp as pdt
    left join
        productsubcategory_prp as sub on
            pdt.id_sous_categorie_produit = sub.id_sous_categorie_produit
    left join
        productcategory_prp as cat on
            sub.id_categorie_produit = cat.id_categorie_produit
    left join
        unitmeasure_prp as unitt on
            pdt.code_unite_mesure_taille = unitt.code_unite_mesure
    left join
        unitmeasure_prp as unitp on
            pdt.code_unite_mesure_poids = unitp.code_unite_mesure
    left join
        product_costhistory_prp as cost on pdt.id_produit = cost.id_produit
)

select * from product_union
