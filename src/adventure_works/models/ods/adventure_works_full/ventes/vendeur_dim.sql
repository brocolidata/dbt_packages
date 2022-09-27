with sales_person_prp as (
    select * from {{ ref('SalesPerson_prp') }}
),

person_prp as (
    select * from {{ ref('Person_prp') }}
),

territoire_vente_dim as (
    select * from {{ ref('territoire_vente_dim') }}
),

sales_person as (
    select
        id_entite_commerciale,
        id_territoire,
        quota_vente,
        prime,
        pourcentage_commission,
        ventes_ytd,
        ventes_annee_derniere
    from sales_person_prp
),

person as (
    select
        id_entite_commerciale,
        nom_complet
    from person_prp
    where type_personne = 'SP'
),

territoire_vente as (
    select
        id_territoire,
        nom_territoire,
        code_region,
        zone_geographique
    from territoire_vente_dim
),

vendeur as (
    select
        sp.*,
        tv.* except(id_territoire),
        p.nom_complet
    from sales_person as sp
    left join person as p on sp.id_entite_commerciale = p.id_entite_commerciale
    left join territoire_vente as tv on sp.id_territoire = tv.id_territoire
    left join store as s on sp. = s.
)

select * from vendeur
