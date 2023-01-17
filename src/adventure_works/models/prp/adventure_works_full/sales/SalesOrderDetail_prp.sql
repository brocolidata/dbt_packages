with source as (
    select *
    from
        {{ source('adventure_works_full', 'SalesOrderDetail') }}
),

prepared_source as (
    select
        CAST(salesorderid as int64) as id_commande_commerciale,
        CAST(salesorderdetailid as int64) as id_ligne_commande,
        CAST(carriertrackingnumber as string) as numero_suivi_transporteur,
        CAST(orderqty as int64) as quantite_commandee,
        CAST(productid as int64) as id_produit,
        CAST(specialofferid as float64) as id_offre_promotionnelle,
        CAST(unitprice as float64) as prix_unitaire,
        CAST(unitpricediscount as float64) as remise,
        CAST(linetotal as bignumeric) as total_ligne,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
