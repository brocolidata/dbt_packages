select * 
    from {{ metrics.calculate(
        metric('quantite_consommee'),
        grain='month',
        dimensions=['id_composant']
    )}} where quantite_consommee <> 0