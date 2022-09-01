with source as (
    select * from {{ source('adventure_works_full', 'CurrencyRate') }}
),

prepared_source as (
    select
        CAST(currencyrateid as int64) as id_taux_change,
        CAST(currencyratedate as datetime) as date_taux_change,
        CAST(fromcurrencycode as string) as change_depuis,
        CAST(tocurrencycode as string) as change_vers,
        CAST(averagerate as numeric) as taux_change_moyen,
        CAST(endofdayrate as numeric) as taux_change_fin_journee,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
