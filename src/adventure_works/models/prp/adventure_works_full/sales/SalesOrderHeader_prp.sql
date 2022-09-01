with source as (
    select *
    from
        {{ source('adventure_works_full', 'SalesOrderHeader') }}
),

prepared_source as (
    select
        CAST(salesorderid as int64) as id_commande,
        CAST(revisionnumber as int64) as numero_revision,
        CAST(orderdate as datetime) as date_commande,
        CAST(duedate as datetime) as date_echeance,
        CAST(shipdate as datetime) as date_expedition,
        CAST(status as int64) as statut,
        CAST(onlineorderflag as bool) as est_une_commande_internet,
        CAST(salesordernumber as string) as numero_commande_client,
        CAST(purchaseordernumber as string) as numero_achat_client,
        CAST(accountnumber as string) as numero_compte,
        CAST(customerid as int64) as id_client,
        CAST(salespersonid as int64) as id_vendeur,
        CAST(territoryid as int64) as id_territoire,
        CAST(billtoaddressid as int64) as id_adresse_facturation,
        CAST(shiptoaddressid as int64) as id_adresse_expedition,
        CAST(shipmethodid as int64) as id_methode_livraison,
        CAST(creditcardid as int64) as id_carte_credit,
        CAST(creditcardapprovalcode as string) as code_approbation_carte_credit,
        CAST(currencyrateid as int64) as id_taux_change,
        CAST(subtotal as numeric) as sous_total,
        CAST(taxamt as numeric) as montant_taxe,
        CAST(freight as numeric) as fret,
        CAST(totaldue as numeric) as total,
        CAST(comment as string) as commentaire,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
