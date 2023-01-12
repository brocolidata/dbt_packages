with sorties as (
    select *
    from {{ metrics.calculate(
        metric('quantite_sortie'),
        grain='month',
        dimensions=['id_produit'],
        secondary_calculations=[
        metrics.rolling(aggregate="average", interval=6, alias="sorties_moyennes_6mois")
    ]
    ) }}
)


select *
from sorties
