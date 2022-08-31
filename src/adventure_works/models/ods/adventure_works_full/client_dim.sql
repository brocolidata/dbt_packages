with customer_prp as (
    select * from {{ ref('Customer_prp') }}
),

person_prp as (
    select * from {{ ref('Person_prp') }}
),

store_prp as (
    select * from {{ ref('Store_prp') }}
),

customer as (
    select
        ID_client,
        ID_personne,
        ID_magasin,
        ID_territoire,
        numero_compte
    from customer_prp
),

person as (
    select 
        ID_entite_commerciale,
        type_personne,
        nom_complet,
        contact_par_email,
        coordonnees_supplementaires,
        informations_supplementaires
    from person_prp
),

store as (
    select
        ID_entite_commerciale,
        nom_magasin
    from store_prp
),

client as (
    select 
        c.* except (ID_personne),
        p.*,
        s.nom_magasin
    from customer c
    left join person p on c.ID_personne = p.ID_entite_commerciale
    left join store s on c.ID_magasin = s.ID_entite_commerciale
)

select * from client