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
        id_client,
        id_personne,
        id_magasin,
        id_territoire,
        numero_compte
    from customer_prp
),

person as (
    select
        id_entite_commerciale,
        type_personne,
        nom_complet,
        contact_par_email,
        coordonnees_supplementaires,
        informations_supplementaires
    from person_prp
),

store as (
    select
        id_entite_commerciale,
        nom_magasin
    from store_prp
),

client as (
    select
        c.* except (id_personne),
        p.*,
        s.nom_magasin
    from customer as c
    left join person as p on c.id_personne = p.id_entite_commerciale
    left join store as s on c.id_magasin = s.id_entite_commerciale
)

select * from client
