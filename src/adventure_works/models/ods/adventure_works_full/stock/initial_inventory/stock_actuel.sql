with entree as (
    select *
    from {{ metrics.calculate(
        metric('quantite_restante'),
        grain='month',
        dimensions=['id_produit'],
        secondary_calculations=[
        metrics.rolling(aggregate="average", interval=2, alias="stock_moyen")
    ]
    ) }}
)


select *
from entree
