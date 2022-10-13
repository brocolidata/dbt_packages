with billofmaterials as (

    select * from {{ ref('BillOfMaterials_prp') }}
),

billofmaterials_ods as (
    select
        nomenclature_id,
        ID_assemblage_produit,
        ID_composant,
        date_debut,
        date_fin,
        code_unite_mesure,
        niveau_nomenclature,
        quantite_par_assemblage,
        date_modification

    from billofmaterials

)

select * from billofmaterials_ods