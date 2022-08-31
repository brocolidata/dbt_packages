with source as (
    select * from {{ source('adventure_works_full', 'Person') }}
),

prepared_source as (
    select
        CAST(BusinessEntityID AS int64) AS ID_entite_commerciale,
        CAST(PersonType AS string) AS type_personne,
        CAST(NameStyle AS bool) AS style_nom,
        CAST(Title AS string) AS titre,
        CAST(FirstName AS string) AS prenom,
        CAST(MiddleName AS string) AS deuxieme_prenom,
        CAST(LastName AS string) AS nom_famille,
        CAST(Suffix AS string) AS suffixe,
        CAST (
            ARRAY_TO_STRING([Title, FirstName, MiddleName, LastName, Suffix], ' ') AS string
        ) AS nom_complet,
        CAST(EmailPromotion AS int64) AS contact_par_email,
        CAST(AdditionalContactInfo AS string) AS coordonnees_supplementaires,
        CAST(Demographics AS string) AS informations_supplementaires,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source


