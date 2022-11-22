
select *
    from {{ metrics.calculate(
        metric('quantite_entree'),
        grain='month',
        dimensions=['id_produit']
    ) }}
where quantite_entree <> 0 
