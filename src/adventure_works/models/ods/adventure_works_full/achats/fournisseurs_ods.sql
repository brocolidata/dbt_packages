with vendor_prp as (

    select * from {{ ref('Vendor_prp') }}
),

productvendor_prp as (

    select * from {{ ref('ProductVendor_prp') }}
),

fournisseurs as (

    select
        vendor.id_fournisseur,
        vendor.numero_compte,
        vendor.nom_fournisseur,
        vendor.cote_credit,
        vendor.statut_fournisseur_prefere,
        vendor.est_actif,
        vendor.achat_service_web_url,
        vendor.date_modifiee,
        productvendor.id_produit,
        productvendor.delai_moyen_reception,
        productvendor.prix_standard,
        productvendor.cout_derniere_reception,
        productvendor.derniere_date_reception,
        productvendor.qte_commande_minimale,
        productvendor.qte_commande_maximale,
        productvendor.qte_commande_en_cours,
        productvendor.unite_de_mesure

    from vendor_prp as vendor
    left join
        productvendor_prp as productvendor on
            vendor.id_fournisseur = productvendor.id_fournisseur

)

select * from fournisseurs
