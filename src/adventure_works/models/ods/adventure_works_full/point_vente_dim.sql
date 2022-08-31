with store_prp as (
    select * from {{ ref('Store_prp') }}
),

vendeur as (
    select * from {{ ref('vendeur_dim') }}
),

store as (
    select
        id_entite_commerciale,
        nom_magasin,
        id_vendeur
    from store_prp
),

point_vente as (
    select
        s.*,
        v.*
    from store as s
    left join vendeur as v on s.id_vendeur = v.id_entite_commerciale
)

select * from store
