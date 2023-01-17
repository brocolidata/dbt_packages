select *
from {{ metrics.calculate(
        metric('quantite_produite'),
        grain='month',
        dimensions=['id_produit']
    ) }}
