

with source as (

    select * from {{ source('adventure_works_full', 'Vendor') }}

),

renamed as (

    select
    CAST(BusinessEntityID AS int64) AS ID_fournisseur,
    CAST(AccountNumber AS string) AS numero_compte,
    CAST(Name AS string) AS nom_fournisseur,
    CASE
        WHEN CreditRating=1 THEN 'supérieur'
        WHEN CreditRating=2 THEN 'excellent'
        WHEN CreditRating=3 THEN 'supérieur'
        WHEN CreditRating=4 THEN 'moyenne'
        WHEN CreditRating=5 THEN 'inférieur'
        ELSE CAST(CreditRating AS string)
    END as cote_credit,
    CASE
        WHEN PreferredVendorStatus is false THEN 'à ne pas solliciter'
        WHEN PreferredVendorStatus is true THEN 'à solliciter'
        ELSE CAST(PreferredVendorStatus AS string)
    END as statut_fournisseur_prefere,
    CASE
        WHEN ActiveFlag is false THEN 'inactif'
        WHEN ActiveFlag is true THEN 'actif'
        ELSE CAST(ActiveFlag AS string)
    END as est_actif,
    CAST(PurchasingWebServiceURL AS string) AS achat_service_web_url,
    CAST(ModifiedDate AS datetime) AS date_modifiee,

    from source

)

select * from renamed
