with sales_territory_prp as (
    select * from {{ ref('SalesTerritory_prp') }}
),

sales_territory as (
    select
        id_territoire,
        nom_territoire,
        code_region,
        zone_geographique,
        ventes_ytd,
        ventes_annee_derniere,
        cout_ytd,
        cout_annee_derniere
    from sales_territory_prp
)

select * from sales_territory
