with source as (
    select * from {{source('adventure_works_full', 'SalesOrderHeader')}}
),

prepared_source as (
    select
        CAST(SalesOrderID AS int64) AS ID_commande,
        CAST(RevisionNumber AS int64) AS numero_revision,
        CAST(OrderDate AS datetime) AS date_commande,
        CAST(DueDate AS datetime) AS date_echeance,
        CAST(ShipDate AS datetime) AS date_expedition,
        CAST(Status AS int64) AS statut,
        CAST(OnlineOrderFlag AS bool) AS est_une_commande_internet,
        CAST(SalesOrderNumber AS string) AS numero_commande_client,
        CAST(PurchaseOrderNumber AS string) AS numero_achat_client,
        CAST(AccountNumber AS string) AS numero_compte,
        CAST(CustomerID AS int64) AS ID_client,
        CAST(SalesPersonID AS int64) AS ID_vendeur,
        CAST(TerritoryID AS int64) AS ID_territoire,
        CAST(BillToAddressID AS int64) AS ID_adresse_facturation,
        CAST(ShipToAddressID AS int64) AS ID_adresse_expedition,
        CAST(ShipMethodID AS int64) AS ID_methode_livraison,
        CAST(CreditCardID AS int64) AS ID_carte_credit,
        CAST(CreditCardApprovalCode AS string) AS code_approbation_carte_credit,
        CAST(CurrencyRateID AS int64) AS ID_taux_change,
        CAST(SubTotal AS numeric) AS sous_total,
        CAST(TaxAmt AS numeric) AS montant_taxe,
        CAST(Freight AS numeric) AS fret,
        CAST(TotalDue AS numeric) AS total,
        CAST(Comment AS string) AS commentaire,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source