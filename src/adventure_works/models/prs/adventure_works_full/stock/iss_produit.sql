with iss_fct as (

    select * from {{ ref('iss_fct') }}

),

sales_fct as (
    select * from {{ ref('sales_fct') }}
),

produit_dim as (
    select * from {{ ref('produit_avec_stock_dim') }}
),

iss as (
    select *
    
    from iss_fct
),

sales as (
    select *
    
    from sales_fct
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

iss_sales as (
    select
        coalesce(sl.id_produit, i.id_produit) as id_produit,
        coalesce(sl.date_month, i.date_month) as date_month,
        coalesce(sl.date_quarter, i.date_quarter) as date_quarter,
        coalesce(sl.date_year, i.date_year) as date_year,

        sl.* except(id_produit, date_month, date_quarter, date_year),
        i.* except(id_produit,date_month, date_quarter, date_year)
        
        

    from iss as sl
    full join sales as i 
        on sl.id_produit = i.id_produit
            and sl.date_month = i.date_month
),


iss_produit as (
    select
        lc.*,
        p.* except(id_produit, id_sous_categorie_produit, id_model_produit, id_categorie_produit, quantite_emplacement, code_unite_mesure_taille, code_unite_mesure_poids, poids_produit, nombre_jours_fabrication_produit, unite_mesure_taille, unite_mesure_poids)

    from iss_sales as lc
    left join produit as p on lc.id_produit = p.id_produit
)

select * from iss_produit where est_vendable is true
