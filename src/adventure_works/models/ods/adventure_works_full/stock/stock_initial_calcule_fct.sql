with stock_fin as (
    select * 
    from {{ metrics.calculate(
        metric('stock_final'),
        grain='month',
        dimensions=['id_produit']
    ) }} where stock_final <> 0
),

entree as (
    select *
    from {{ metrics.calculate(
        metric('quantite_entree'),
        grain='month',
        dimensions=['id_produit']
    ) }} where quantite_entree <> 0
),

sorties as (
    select *
    from {{ metrics.calculate(
        metric('quantite_sortie'),
        grain='month',
        dimensions=['id_produit']
    ) }} where quantite_sortie <> 0
),

etat_stock_initial as(

    select
        coalesce(sf.date_month, e.date_month, s.date_month) as date_month,
        coalesce(sf.id_produit, e.id_produit, s.id_produit) as id_produit,
        sf.stock_final as stock_fin,
        
        case
            when e.date_month < sf.date_month then e.quantite_entree
            else 0
        end as quantite_ent,
    
        case
            when s.date_month < sf.date_month then s.quantite_sortie
            else 0
        end as quantite_sort

    from stock_fin as sf
    full join entree as e on sf.id_produit = e.id_produit
                            and sf.date_month = e.date_month
    full join sorties as s on sf.id_produit = s.id_produit
                            and sf.date_month = e.date_month

),


etat_stock_initial_final as (

    select
        si.*,
        si.stock_fin - si.quantite_ent + si.quantite_sort as stock_init

    from etat_stock_initial as si
),

etat as (

    select
        sif.date_month,
        case when sif.date_month = sif.date_month then "2008-02-01" else "2008-02-01" end as date_stock_init,
        sif.id_produit,
        sum(sif.stock_init) as stock_init,
        sum(sif.quantite_ent) as quantite_ent,
        sum(sif.quantite_sort) as quantite_sort,
        sum(sif.stock_fin) as stock_fin
        

    from etat_stock_initial_final as sif
    group by id_produit, date_month
)


select date_stock_init as date_month, id_produit, stock_init, quantite_ent, quantite_sort, stock_fin from etat