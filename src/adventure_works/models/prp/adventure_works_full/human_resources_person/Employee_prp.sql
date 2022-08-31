with source as (
    select * from {{ source('adventure_works_full', 'Employee') }}
),

prepared_source as (
    select 
        CAST(BusinessEntityID AS int64) AS ID_entite_commerciale,
        CAST(NationalIDNumber AS string) AS numero_national_identite,
        CAST(LoginID AS string) AS identifiant_connexion,
        CAST(OrganizationNode AS bytes) AS noeud_organisation,
        CAST(OrganizationLevel AS int64) AS niveau_organisation,
        CAST(JobTitle AS string) AS titre_poste,
        CAST(BirthDate AS date) AS date_naissance,
        CAST(MaritalStatus AS string) AS etat_civil,
        CAST(Gender AS string) AS genre,
        CAST(HireDate AS date) AS date_embauche,
        CAST(SalariedFlag AS bool) AS est_salarie,
        CAST(VacationHours AS int64) AS heures_vacances,
        CAST(SickLeaveHours AS int64) AS heures_conge_maladie,
        CAST(CurrentFlag AS bool) AS est_actuel,
        CAST(rowguid AS string) AS ID_unique,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source
)

select * from prepared_source