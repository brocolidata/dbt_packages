with source as (

    select * from {{ source('adventure_works_full', 'PurchaseOrderHeader') }}

),

renamed as (

    select

        CAST(PurchaseOrderID AS int64) AS ID_commande_dachat,
        CAST(RevisionNumber AS int64) AS numero_revision,
        CASE
            WHEN Status=1 THEN 'en attente'
            WHEN Status=2 THEN 'approuvé'
            WHEN Status=3 THEN 'rejeté'
            WHEN Status=4 THEN 'complet'
	        ELSE 'nouveau_statut'
        END as statut_de_la_commande,
        CAST(EmployeeID AS int64) AS ID_employes,
        CAST(VendorID AS int64) AS ID_fournisseur,
        CAST(ShipMethodID AS int64) AS ID_methode_expedition,
        CAST(OrderDate AS datetime) AS date_commande,
        CAST(ShipDate AS datetime) AS date_expedition,
        CAST(SubTotal AS numeric) AS soustotal_commande,
        CAST(TaxAmt AS numeric) AS montant_taxe_commande,
        CAST(Freight AS numeric) AS frais_de_port,
        CAST(TotalDue AS numeric) AS total_commande,
        CAST(ModifiedDate AS datetime) AS date_modifiee,
        
    from source

)

select * from renamed