with detail_transaction as (

    select * from {{ ref('details_transaction_ods') }}

),

produit as (

    select * from {{ ref('produit_dim') }}
),

transaction_details as (
    select
        pdt.nom_produit,
        pdt.nom_sous_categorie,
        pdt.numero_produit,
        pdt.nom_categorie,
        trans.id_transaction,
        trans.id_commande,
        trans.id_ligne_commande,
        trans.date_transaction,
        trans.type_transaction,
        trans.quantite_produit,
        trans.cout_produit,
        trans.date_modification

    from detail_transaction as trans
    left join produit as pdt on trans.id_produit = pdt.id_produit


)

select * from transaction_details
