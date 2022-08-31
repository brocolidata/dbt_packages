with store_prp as (
    select * from {{ ref('Store_prp') }}
),

vendeur as (
    select * from {{ ref('vendeur_dim') }}
),

store as (
    select
        ID_entite_commerciale,
        nom_magasin,
        ID_vendeur
    from store_prp
),

point_vente as (
    select
        s.*,
        v.* 
    from store s 
    left join vendeur v on s.ID_vendeur = v.ID_entite_commerciale
)

select * from store