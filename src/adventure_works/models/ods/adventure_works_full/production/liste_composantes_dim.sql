with billofmaterials_prp as (

    select * from {{ ref('BillOfMaterials_prp') }}
),

liste as (

    select
        bi.nomenclature_id,
        bi.id_assemblage_produit,
        bi.id_composant,
        bi.date_debut,
        bi.date_fin,
        bi.code_unite_mesure,
        bi.niveau_nomenclature,
        bi.quantite_par_assemblage,
        bi.date_modification
        


    from billofmaterials_prp as bi
)

select * from liste
