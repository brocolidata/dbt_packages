with iss_fct as (

    select * from {{ ref('iss_fct') }}

),

produit_dim as (
    select * from {{ ref('produit_dim') }}
),


iss as (
    select
        date_month,
    	id_produit,
    	stock_moyen,
        sorties_moyennes,
    	rotation_stock
    
    from iss_fct
),

produit as (
    select
        id_produit,
        nom_produit,
        numero_produit,
        est_manufacture_paraw,
        est_vendable,
        couleur,
        stock_securite,
        stock_alerte,
        cout_standard,
        prix_vente,
        taille_produit,
        code_unite_mesure_taille,
        code_unite_mesure_poids,
        poids_produit,
        nombre_jours_fabrication_produit,
        ligne_produit,
        gamme,
        style,
        id_sous_categorie_produit,
        id_model_produit,
        id_categorie_produit,
        nom_sous_categorie,
        unite_mesure_taille,
        unite_mesure_poids,
        nom_categorie as categorie_produit,
        sum(quantite_emplacement) as quantite_emplacement

    from produit_dim

    group by id_produit, nom_produit, numero_produit, est_manufacture_paraw, est_vendable, couleur, stock_securite, stock_alerte, cout_standard, prix_vente, taille_produit, code_unite_mesure_taille, code_unite_mesure_poids, poids_produit, nombre_jours_fabrication_produit, ligne_produit, gamme, style, id_sous_categorie_produit, id_model_produit, id_categorie_produit, nom_sous_categorie, unite_mesure_taille, unite_mesure_poids,   categorie_produit 

),

iss_produit as (
    select
        lc.*,
        p.* except(id_produit, id_sous_categorie_produit, id_model_produit, id_categorie_produit, quantite_emplacement, code_unite_mesure_taille, code_unite_mesure_poids, poids_produit, nombre_jours_fabrication_produit, unite_mesure_taille, unite_mesure_poids)

    from iss as lc
    left join produit as p on lc.id_produit = p.id_produit
)

select * from iss_produit where est_vendable is true
