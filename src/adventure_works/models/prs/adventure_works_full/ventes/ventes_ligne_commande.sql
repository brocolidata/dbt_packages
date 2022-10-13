with ligne_commande_fct as (
    select * from {{ ref('ligne_commande_fct') }}
),

produit_ods as (
    select * from {{ ref('produit_ods') }}
),

offre_promotionnelle_fct as (
    select * from {{ ref('offre_promotionnelle_fct') }}
),

client_dim as (
    select * from {{ ref('client_dim') }}
),

vendeur_dim as (
    select * from {{ ref('vendeur_dim') }}
),

ligne_commande as (
    select
        id_ligne_commande,
        numero_suivi_transporteur,
        quantite_commandee,
        id_produit,
        id_offre_promotionnelle,
        prix_unitaire,
        remise,
        total_ligne,
        id_commande,
        date_commande,
        date_echeance,
        date_expedition,
        est_une_commande_internet,
        id_client,
        id_vendeur,
        id_territoire,
        id_methode_livraison
    from ligne_commande_fct
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

offre_promotionnelle as (
    select
        id_offre_promotionnelle,
        description,
        pourcentage_remise,
        type_remise,
        beneficiaire_remise,
        date_debut,
        date_fin,
        remise_minimale,
        remise_maximale,
        id_produit
    from offre_promotionnelle_fct
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

vendeur as (
    select
        id_entite_commerciale,
        nom_complet as nom_complet_vendeur,
        pourcentage_commission,
        nom_territoire,
        code_region,
        zone_geographique
    from vendeur_dim
),

ventes_ligne_commande as (
    select
        lc.* except(id_produit),
        p.* except(id_produit),
        op.* except(id_offre_promotionnelle, id_produit),
        c.* except(id_client),
        v.* except(id_entite_commerciale),
        p.cout_standard * lc.quantite_commandee as cout_total,
        lc.prix_unitaire * lc.quantite_commandee as chiffre_daffaires_brut,
        (
            lc.prix_unitaire * lc.remise * lc.quantite_commandee
        ) as montant_remise_ligne,
        (
            (lc.prix_unitaire * (1 - lc.remise)) * lc.quantite_commandee
        ) * (1 - op.pourcentage_remise) as chiffre_daffaires_net
    from ligne_commande as lc
    left join produit as p on p.id_produit = lc.id_produit
    left join offre_promotionnelle as op
        on op.id_offre_promotionnelle = lc.id_offre_promotionnelle
            and op.id_produit = lc.id_produit
    left join client as c on c.id_client = lc.id_client
    left join vendeur as v on v.id_entite_commerciale = lc.id_vendeur
),

computed_ventes_ligne_commande as (
    select
        *,
        (
            chiffre_daffaires_net / (1 - pourcentage_remise)
        ) - chiffre_daffaires_net as montant_remise_promo,
        cout_total - chiffre_daffaires_net as marge,
        (
            chiffre_daffaires_net / (1 - pourcentage_remise)
        ) - chiffre_daffaires_net + montant_remise_ligne as total_remise
    from ventes_ligne_commande
)

select * from computed_ventes_ligne_commande
