with purchaseorderheader_prp as (

    select * from {{ ref('PurchaseOrderHeader_prp') }}
),

purchaseorderdetail_prp as (

    select * from {{ ref('PurchaseOrderDetail_prp') }}
),

shipmethod_prp as (

    select * from {{ ref('ShipMethod_prp') }}
),

achats as (

    select
        orderheader.id_commande_dachat,
        orderheader.numero_revision,
        orderheader.statut_de_la_commande,
        orderheader.id_employes,
        orderheader.id_fournisseur,
        orderheader.date_commande,
        orderheader.date_expedition,
        orderheader.soustotal_commande,
        orderheader.montant_taxe_commande,
        orderheader.frais_de_port,
        orderheader.total_commande,
        orderheader.date_modifiee,

        shipmethod.nom_methode_exepdition,
        shipmethod.base_min_expedition,
        shipmethod.taux_expedition

    from purchaseorderheader_prp as orderheader
    left join
        shipmethod_prp as shipmethod on
            orderheader.id_methode_expedition = shipmethod.id_methode_expedition
)

select * from achats
