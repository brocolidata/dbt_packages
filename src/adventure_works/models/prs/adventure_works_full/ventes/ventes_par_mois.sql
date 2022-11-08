with ca_brut as (
    select *
    from
    {{ 
        metrics.calculate(
            metric('ca_brut'),
            grain='month',
            dimensions=['id_produit', 'id_client']
        ) 
    }}
),

produit_ods as (
    select * from {{ ref('produit_ods') }}
),

client_dim as (
    select * from {{ ref('client_dim') }}
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
        date_debut_vente,
        date_fin_vente,
        date_interruption,
        id_categorie_produit,
        nom_sous_categorie,
        unite_mesure_taille,
        unite_mesure_poids,
        date_debut_cout_produit,
        date_fin_cout_produit,
        nom_categorie
    from produit_ods
),

client as (
    select
        id_client,
        id_magasin,
        numero_compte,
        id_entite_commerciale,
        type_personne,
        nom_complet as nom_complet_client,
        nom_magasin
    from client_dim
),

ventes_ligne_commande as (
    select
        ca_brut.*,
        p.* except(id_produit),
        c.* except(id_client)
    from ca_brut
    left join produit as p on p.id_produit = ca_brut.id_produit
    left join client as c on c.id_client = ca_brut.id_client
)

select * from ventes_ligne_commande