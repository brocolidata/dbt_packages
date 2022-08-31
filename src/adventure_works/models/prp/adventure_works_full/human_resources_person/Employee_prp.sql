with source as (
    select * from {{ source('adventure_works_full', 'Employee') }}
),

prepared_source as (
    select
        CAST(businessentityid as int64) as id_entite_commerciale,
        CAST(nationalidnumber as string) as numero_national_identite,
        CAST(loginid as string) as identifiant_connexion,
        CAST(organizationnode as bytes) as noeud_organisation,
        CAST(organizationlevel as int64) as niveau_organisation,
        CAST(jobtitle as string) as titre_poste,
        CAST(birthdate as date) as date_naissance,
        CAST(maritalstatus as string) as etat_civil,
        CAST(gender as string) as genre,
        CAST(hiredate as date) as date_embauche,
        CAST(salariedflag as bool) as est_salarie,
        CAST(vacationhours as int64) as heures_vacances,
        CAST(sickleavehours as int64) as heures_conge_maladie,
        CAST(currentflag as bool) as est_actuel,
        CAST(rowguid as string) as id_unique,
        CAST(modifieddate as datetime) as date_modification
    from source
)

select * from prepared_source
