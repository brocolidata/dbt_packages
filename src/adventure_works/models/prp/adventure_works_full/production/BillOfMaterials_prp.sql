with source as (

    select * from {{ source('adventure_works_full', 'BillOfMaterials') }}

),

renamed as (

    select
        CAST(billofmaterialsid as int64) as nomenclature_id,
        CAST(productassemblyid as int64) as id_assemblage_produit,
        CAST(componentid as int64) as id_composant,
        CAST(startdate as datetime) as date_debut,
        CAST(enddate as datetime) as date_fin,
        CAST(unitmeasurecode as string) as code_unite_mesure,
        CAST(bomlevel as int64) as niveau_nomenclature,
        CAST(perassemblyqty as numeric) as quantite_par_assemblage,
        CAST(modifieddate as datetime) as date_modification
    from source

)

select * from renamed
