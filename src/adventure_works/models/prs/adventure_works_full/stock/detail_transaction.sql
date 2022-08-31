with detail_transaction as (

    select * from {{ ref('details_transaction_ods') }}
    
),

produit as (

    select * from {{ ref('produit_ods') }}
),

transaction_details as (
    select 
        pdt.nom_produit,
        pdt.nom_sous_categorie,
        pdt.numero_produit,
        pdt.nom_categorie,
        trans.ID_transaction,
        trans.ID_commande,
        trans.ID_ligne_commande,
        trans.date_transaction,
        trans.type_transaction,
        trans.quantite_produit,
        trans.cout_produit,
        trans.date_modification

    from detail_transaction as trans
    left join produit as pdt on trans.ID_produit = pdt.ID_produit


)

select * from transaction_details


