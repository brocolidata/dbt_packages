with sales_territory_prp as (
    select * from {{ ref('SalesTerritory_prp') }}
),

sales_territory as (
    select
        ID_territoire,
        nom_territoire,
        code_region,
        zone_geographique,
        ventes_YTD,
        ventes_annee_derniere,
        cout_YTD,
        cout_annee_derniere
    from sales_territory_prp
)

select * from sales_territory