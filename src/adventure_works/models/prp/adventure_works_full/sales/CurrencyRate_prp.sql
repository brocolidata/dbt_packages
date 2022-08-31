with source as (
    select * from {{ source('adventure_works_full', 'CurrencyRate') }}
),

prepared_source as (
    select
        CAST(CurrencyRateID AS int64) AS ID_taux_change,
        CAST(CurrencyRateDate AS datetime) AS date_taux_change,
        CAST(FromCurrencyCode AS string) AS change_depuis,
        CAST(ToCurrencyCode AS string) AS change_vers,
        CAST(AverageRate AS numeric) AS taux_change_moyen,
        CAST(EndOfDayRate AS numeric) AS taux_change_fin_journee,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source