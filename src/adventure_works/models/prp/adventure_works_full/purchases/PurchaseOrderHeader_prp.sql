with source as (

    select * from {{ source('adventure_works_full', 'PurchaseOrderHeader') }}

),

renamed as (

    select

        CAST(purchaseorderid as int64) as id_commande_dachat,
        CAST(revisionnumber as int64) as numero_revision,
        case
            when status = 1 then 'en attente'
            when status = 2 then 'approuvé'
            when status = 3 then 'rejeté'
            when status = 4 then 'complet'
            else 'nouveau_statut'
        end as statut_de_la_commande,
        CAST(employeeid as int64) as id_employes,
        CAST(vendorid as int64) as id_fournisseur,
        CAST(shipmethodid as int64) as id_methode_expedition,
        CAST(orderdate as datetime) as date_commande,
        CAST(shipdate as datetime) as date_expedition,
        CAST(subtotal as numeric) as soustotal_commande,
        CAST(taxamt as numeric) as montant_taxe_commande,
        CAST(freight as numeric) as frais_de_port,
        CAST(totaldue as numeric) as total_commande,
        CAST(modifieddate as datetime) as date_modifiee

    from source

)

select * from renamed
