with source as (
    select * from {{ source('adventure_works_full', 'Person') }}
),

prepared_source as (
    select
        CAST(businessentityid as int64) as id_entite_commerciale,
        CAST(persontype as string) as type_personne,
        CAST(namestyle as bool) as style_nom,
        CAST(title as string) as titre,
        CAST(firstname as string) as prenom,
        CAST(middlename as string) as deuxieme_prenom,
        CAST(lastname as string) as nom_famille,
        CAST(suffix as string) as suffixe,
        CAST(
            ARRAY_TO_STRING(
                [title, firstname, middlename, lastname, suffix], ' '
            ) as string
        ) as nom_complet,
        CAST(emailpromotion as int64) as contact_par_email,
        CAST(additionalcontactinfo as string) as coordonnees_supplementaires,
        CAST(demographics as string) as informations_supplementaires,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
