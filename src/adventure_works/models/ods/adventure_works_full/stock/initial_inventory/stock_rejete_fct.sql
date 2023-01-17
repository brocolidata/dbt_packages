select *
from {{ metrics.calculate(
        [metric('quantite_rejetee')],
        grain='month',
        dimensions=['id_produit']
    ) }}
