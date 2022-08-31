with source as (

    select * from {{ source('adventure_works_full', 'Vendor') }}

),

renamed as (

    select
        CAST(businessentityid as int64) as id_fournisseur,
        CAST(accountnumber as string) as numero_compte,
        CAST(name as string) as nom_fournisseur,
        case
            when creditrating = 1 then 'supérieur'
            when creditrating = 2 then 'excellent'
            when creditrating = 3 then 'supérieur'
            when creditrating = 4 then 'moyenne'
            when creditrating = 5 then 'inférieur'
            else CAST(creditrating as string)
        end as cote_credit,
        case
            when preferredvendorstatus is false then 'à ne pas solliciter'
            when preferredvendorstatus is true then 'à solliciter'
            else CAST(preferredvendorstatus as string)
        end as statut_fournisseur_prefere,
        case
            when activeflag is false then 'inactif'
            when activeflag is true then 'actif'
            else CAST(activeflag as string)
        end as est_actif,
        CAST(purchasingwebserviceurl as string) as achat_service_web_url,
        CAST(modifieddate as datetime) as date_modifiee

    from source

)

select * from renamed
