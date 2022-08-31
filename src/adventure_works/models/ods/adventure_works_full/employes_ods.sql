with employees as (
     
     select * from {{ ref('Employee_prp') }}
),

employees_ods as (
    select 
        ID_entite_commerciale,
        noeud_organisation,
        niveau_organisation,
        titre_poste,
        date_naissance,
        etat_civil,
        genre,
        date_embauche,
        est_salarie,
        heures_vacances,
        heures_conge_maladie,
        est_actuel

    from employees

)
select * from employees_ods