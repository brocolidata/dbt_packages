with ventes as (
    select *
    from {{ metrics.calculate(
        metric('quantite_vendue'),
        grain='month',
        dimensions=['id_produit']
    ) }}
)

select
    date_month,
    id_produit,
    sum(quantite_vendue) as quantite_vendue
from ventes
group by 1, 2
