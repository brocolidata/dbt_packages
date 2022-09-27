with source as (

    select * from {{ source('adventure_works_full', 'BillOfMaterials') }}

),

renamed as (

    select
        CAST(BillOfMaterialsID AS int64) AS nomenclature_id,
        CAST(ProductAssemblyID AS int64) AS ID_assemblage_produit,
        CAST(ComponentID AS int64) AS ID_composant,
        CAST(StartDate AS datetime) AS date_debut,
        CAST(EndDate AS datetime) AS date_fin,
        CAST(UnitMeasureCode AS string) AS code_unite_mesure,
        CAST(BOMLevel AS int64) AS niveau_nomenclature,
        CAST(PerAssemblyQty AS numeric) AS quantite_par_assemblage,
        CAST(ModifiedDate AS datetime) AS date_modification
    from source

)

select * from renamed
