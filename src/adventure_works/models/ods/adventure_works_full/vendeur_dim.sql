with sales_person_prp as (
    select * from {{ ref('SalesPerson_prp') }}
),

person_prp as (
    select * from {{ ref('Person_prp') }}
),

territoire_vente_dim as (
    select 
        ID_territoire,
        nom_territoire,
        code_region,
        zone_geographique
    from {{ ref('territoire_vente_dim') }}
),


sales_person as (
    select
        ID_entite_commerciale,
        ID_territoire,
        quota_vente,
        prime,
        pourcentage_commission,
        ventes_YTD,
        ventes_annee_derniere
    from sales_person_prp
),

person as (
    select
        ID_entite_commerciale,
        nom_complet
    from person_prp
    where type_personne = 'SP'
),

vendeur as (
    select 
        sp.*,
        p.nom_complet,
        tv.* except(ID_territoire)
    from sales_person sp
    left join person p on sp.ID_entite_commerciale = p.ID_entite_commerciale
    left join territoire_vente_dim tv on sp.ID_territoire = tv.ID_territoire
)

select * from vendeur