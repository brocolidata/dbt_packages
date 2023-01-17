select *
from {{ metrics.calculate(
    metric('stock_final'),
    grain='month',
    dimensions=['id_produit']
) }}
