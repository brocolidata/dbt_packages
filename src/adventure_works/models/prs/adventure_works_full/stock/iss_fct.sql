with non_der as (
    select *
    from {{ metrics.calculate(
        metric_list=[metric('quantite_entree'), metric('quantite_sortie'), metric('quantite_restante')],
        grain='month',
        dimensions=['id_produit'],
        secondary_calculations=[
        metrics.prior(interval=1, alias="past_month", metric_list=('quantite_entree', 'quantite_sortie', 'quantite_restante')),
        metrics.prior(interval=12, alias="same_month_last_year", metric_list=('quantite_entree', 'quantite_sortie', 'quantite_restante')),
        metrics.rolling(aggregate="sum", interval=3, alias="sum_past_3months", metric_list=('quantite_entree', 'quantite_sortie')),
        metrics.rolling(aggregate="sum", interval=6, alias="sum_past_6months", metric_list=('quantite_entree', 'quantite_sortie')),
        metrics.rolling(aggregate="average", interval=3, alias="avg_past_3months", metric_list=('quantite_entree', 'quantite_sortie')),
        metrics.rolling(aggregate="average", interval=6, alias="avg_past_6months", metric_list=('quantite_entree', 'quantite_sortie')),
        metrics.period_over_period(comparison_strategy="difference", interval=1, alias="pop_difference_prev_month", metric_list=('quantite_entree', 'quantite_sortie')),
        metrics.period_over_period(comparison_strategy="difference", interval=12, alias="pop_difference_same_month_prev_year", metric_list=('quantite_entree', 'quantite_sortie')),
        metrics.period_to_date(aggregate="sum", period="quarter", alias="ptd_sum_quarter", metric_list=('quantite_entree', 'quantite_sortie')),
        metrics.period_to_date(aggregate="sum", period="year", alias="ptd_sum_year", metric_list=('quantite_entree', 'quantite_sortie'))
    ]
    ) }}  
),




der as (
    select *
    from {{ metrics.calculate(
        metric_list=[metric('rotation_stock')],
        grain='month',
        dimensions=['id_produit']
    ) }}  
),


iss as (
    select
        coalesce(nd.id_produit, d.id_produit) as id_produit,
        coalesce(nd.date_month, d.date_month) as date_month,
        nd.date_quarter,
        nd.date_year,
        coalesce(nd.quantite_entree,0) as quantite_entree, 
        coalesce(nd.quantite_sortie,0) as quantite_sortie, 
        coalesce(nd.quantite_restante,0) as quantite_restante, 
        coalesce(nd.quantite_entree_past_month,0) as quantite_entree_past_month, 
        coalesce(nd.quantite_sortie_past_month,0) as quantite_sortie_past_month, 
        coalesce(nd.quantite_restante_past_month,0) as quantite_restante_past_month, 
        coalesce(nd.quantite_entree_same_month_last_year,0) as quantite_entree_same_month_last_year, 
        coalesce(nd.quantite_sortie_same_month_last_year,0) as quantite_sortie_same_month_last_year, 
        coalesce(nd.quantite_restante_same_month_last_year,0) as quantite_restante_same_month_last_year, 
        coalesce(nd.quantite_entree_sum_past_3months,0) as quantite_entree_sum_past_3months, 
        coalesce(nd.quantite_sortie_sum_past_3months,0) as quantite_sortie_sum_past_3months, 
        coalesce(nd.quantite_entree_sum_past_6months,0) as quantite_entree_sum_past_6months, 
        coalesce(nd.quantite_sortie_sum_past_6months,0) as quantite_sortie_sum_past_6months, 
        coalesce(nd.quantite_entree_avg_past_3months,0) as quantite_entree_avg_past_3months, 
        coalesce(nd.quantite_sortie_avg_past_3months,0) as quantite_sortie_avg_past_3months, 
        coalesce(nd.quantite_entree_avg_past_6months,0) as quantite_entree_avg_past_6months, 
        coalesce(nd.quantite_sortie_avg_past_6months,0) as quantite_sortie_avg_past_6months, 
        coalesce(nd.quantite_entree_pop_difference_prev_month,0) as quantite_entree_pop_difference_prev_month, 
        coalesce(nd.quantite_sortie_pop_difference_prev_month,0) as quantite_sortie_pop_difference_prev_month, 
        coalesce(nd.quantite_entree_pop_difference_same_month_prev_year,0) as quantite_entree_pop_difference_same_month_prev_year, 
        coalesce(nd.quantite_sortie_pop_difference_same_month_prev_year,0) as quantite_sortie_pop_difference_same_month_prev_year, 
        coalesce(nd.quantite_entree_ptd_sum_quarter,0) as quantite_entree_ptd_sum_quarter, 
        coalesce(nd.quantite_sortie_ptd_sum_quarter,0) as quantite_sortie_ptd_sum_quarter, 
        coalesce(nd.quantite_entree_ptd_sum_year,0) as quantite_entree_ptd_sum_year, 
        coalesce(nd.quantite_sortie_ptd_sum_year,0) as quantite_sortie_ptd_sum_year, 
        coalesce(d.stock_moyen,0) as stock_moyen,
        coalesce(d.sorties_moyennes,0) as sorties_moyennes,
        coalesce(d.rotation_stock,0) as rotation_stock

    from non_der as nd
    full join der as d 
        on nd.id_produit = d.id_produit
            and nd.date_month = d.date_month
)



select * from iss