select * 
from {{ metrics.calculate(
    metric('quantite_achetee'),
    grain='month',
    dimensions=['id_produit']
) }}