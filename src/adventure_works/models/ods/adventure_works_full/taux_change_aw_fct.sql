with currency_prp as (
    select * from {{ ref('Currency_prp') }}
),

currency_rate_prp as (
    select * from {{ ref('CurrencyRate_prp') }}
),

currency_analytic as (
    select
        code_devise,
        nom_devise
    from currency_prp
),

currency_rate_analytic as (
    select
        id_taux_change,
        date_taux_change,
        change_depuis,
        change_vers,
        taux_change_moyen,
        taux_change_fin_journee
    from currency_rate_prp
),

taux_change_fct as (
    select
        cr.* except(change_depuis, change_vers),
        cd.nom_devise as change_depuis,
        cv.nom_devise as change_vers
    from currency_rate_analytic as cr
    right join currency_analytic as cd on cr.change_depuis = cd.code_devise
    right join currency_analytic as cv on cr.change_vers = cd.code_devise
)

select * from taux_change_fct
