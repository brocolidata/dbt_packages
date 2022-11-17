with achats as (

    select * from {{ ref('achats_ods') }}

),

achats_detail as (

    select * from {{ ref('achats_detail_ods') }}

),

produits as (

    select * from {{ ref('produit_dim') }}

),

fournisseurs as (

    select * from {{ ref('fournisseurs_ods') }}

),

employees as (

    select * from {{ ref('employes_ods') }}

),

achats_union as (

    select
        acha.id_commande_dachat,
        acha.statut_de_la_commande,
        acha.date_commande,
        acha.soustotal_commande,
        acha.montant_taxe_commande,
        acha.frais_de_port,
        acha.total_commande,
        acha.nom_methode_exepdition as methode_expedition,
        acha.base_min_expedition,
        acha.taux_expedition,

        prod.id_produit,
        prod.nom_produit,
        prod.couleur,
        prod.stock_securite,
        prod.stock_alerte,
        prod.cout_standard,
        prod.prix_vente as prix_vente_conseille,
        prod.taille_produit,
        prod.unite_mesure_taille,
        prod.unite_mesure_poids,
        prod.poids_produit,
        prod.nombre_jours_fabrication_produit,
        prod.ligne_produit,
        prod.gamme,
        prod.style,
        prod.date_debut_vente,
        prod.date_fin_vente,
        prod.date_interruption,
        prod.nom_sous_categorie,
        prod.nom_categorie,
        prod.date_debut_cout_produit,
        prod.date_fin_cout_produit,


        achadet.date_echeance_reception,
        achadet.quantite_commandee,
        achadet.prix_unitaire_achat,
        achadet.ligne_totale_achat,
        achadet.qte_recue,
        achadet.qte_rejetee,
        achadet.qte_stockee,
        achadet.date_modifiee,

        empl.noeud_organisation,
        empl.niveau_organisation,
        empl.titre_poste,
        empl.date_naissance,
        empl.etat_civil,
        empl.genre,
        empl.date_embauche,
        empl.est_salarie,
        empl.heures_vacances,
        empl.heures_conge_maladie,
        empl.est_actuel,


        frs.nom_fournisseur,
        frs.cote_credit,
        frs.statut_fournisseur_prefere,
        frs.est_actif as fournisseur_est_actif,
        frs.achat_service_web_url,
        frs.delai_moyen_reception,
        frs.prix_standard as prix_standard_fournisseur,
        frs.cout_derniere_reception,
        frs.derniere_date_reception,
        frs.qte_commande_minimale,
        frs.qte_commande_maximale,
        frs.qte_commande_en_cours


    from achats as acha
    left join employees as empl on acha.id_employes = empl.id_entite_commerciale
    left join fournisseurs as frs on acha.id_fournisseur = frs.id_fournisseur
    left join
        achats_detail as achadet on
            acha.id_commande_dachat = achadet.id_commande_dachat
    left join produits as prod on achadet.id_produit = prod.id_produit
)

select * from achats_union
