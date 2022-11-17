with entete_bon_de_travail_fct as (

    select * from {{ ref('entete_bon_de_travail_fct') }}

),

liste_composantes_dim as (

    select * from {{ ref('liste_composantes_dim') }}

),

entete_bon_de_travail as (
    select
        id_commande_travail,
        id_produit,
        quantite_commandee as quantite_produite,
        quantite_stockee as quantite_produite_stockee,
        quantite_supprimee as quantite_produite_supprimee,
        date_debut as date_debut_production,
        date_mouvement,
        date_echeance,
        id_raison,
        date_modification

    from entete_bon_de_travail_fct
),

liste_composantes as (
    select

        nomenclature_id,
        id_assemblage_produit as id_produit,
        id_composant,
        date_debut as date_debut_utilisation,
        date_fin as date_fin_utilisation,
        code_unite_mesure,
        niveau_nomenclature,
        quantite_par_assemblage,
        date_modification
        
    from liste_composantes_dim
),

conso_prod as (
    select
        e.id_commande_travail,
        e.date_mouvement,
        e.id_produit,
        e.quantite_produite,
        e.quantite_produite_stockee,
        e.quantite_produite_supprimee,
        bi.* except(nomenclature_id,date_modification, id_produit),
        e.quantite_produite * bi.quantite_par_assemblage as quantite_consomee

    from entete_bon_de_travail as e
    left join liste_composantes as bi on e.id_produit = bi.id_produit
    
    
)

select * from conso_prod