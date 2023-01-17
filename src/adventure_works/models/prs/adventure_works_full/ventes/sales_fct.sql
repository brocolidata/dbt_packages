with ventes_non_der as (
    select *
    from {{ metrics.calculate(
        metric_list=[metric('cout_total'), metric('chiffre_daffaires_brut'), metric('montant_remise_ligne'), metric('chiffre_daffaires_net')],
        grain='month',
        dimensions=['id_produit'],
        secondary_calculations=[
        metrics.prior(interval=1, alias="past_month", metric_list=('cout_total','chiffre_daffaires_brut','montant_remise_ligne','chiffre_daffaires_net')),
        metrics.prior(interval=12, alias="same_month_last_year", metric_list=('cout_total','chiffre_daffaires_brut','montant_remise_ligne','chiffre_daffaires_net')),
        metrics.rolling(aggregate="sum", interval=3, alias="sum_past_3months", metric_list=('cout_total','chiffre_daffaires_brut','montant_remise_ligne','chiffre_daffaires_net')),
        metrics.rolling(aggregate="sum", interval=6, alias="sum_past_6months", metric_list=('cout_total','chiffre_daffaires_brut','montant_remise_ligne','chiffre_daffaires_net')),
        metrics.rolling(aggregate="average", interval=3, alias="avg_past_3months", metric_list=('cout_total','chiffre_daffaires_brut','montant_remise_ligne','chiffre_daffaires_net')),
        metrics.rolling(aggregate="average", interval=6, alias="avg_past_6months", metric_list=('cout_total','chiffre_daffaires_brut','montant_remise_ligne','chiffre_daffaires_net')),
        metrics.period_over_period(comparison_strategy="difference", interval=1, alias="pop_difference_prev_month", metric_list=('cout_total','chiffre_daffaires_brut','montant_remise_ligne','chiffre_daffaires_net')),
        metrics.period_over_period(comparison_strategy="difference", interval=12, alias="pop_difference_same_month_prev_year", metric_list=('cout_total','chiffre_daffaires_brut','montant_remise_ligne','chiffre_daffaires_net')),
        metrics.period_to_date(aggregate="sum", period="quarter", alias="ptd_sum_quarter", metric_list=('cout_total','chiffre_daffaires_brut','montant_remise_ligne','chiffre_daffaires_net')),
        metrics.period_to_date(aggregate="sum", period="year", alias="ptd_sum_year", metric_list=('cout_total','chiffre_daffaires_brut','montant_remise_ligne','chiffre_daffaires_net'))
    ]
    ) }}
),

vente_der as (
    select *
    from {{ metrics.calculate(
        metric_list=[ metric('total_remise'), metric('marge_ligne')],
        grain='month',
        dimensions=['id_produit']
    ) }}
),

sales as (
    select
        nd.* except(id_produit, date_month),
        d.* except(
            id_produit,
            date_month,
            chiffre_daffaires_net,
            cout_total,
            montant_remise_ligne
        ),
        d.chiffre_daffaires_net as ca_net,
        d.cout_total as cout,
        coalesce(nd.id_produit, d.id_produit) as id_produit,
        coalesce(nd.date_month, d.date_month) as date_month



    from ventes_non_der as nd
    full join vente_der as d
        on nd.id_produit = d.id_produit
            and nd.date_month = d.date_month
)

select * from sales
