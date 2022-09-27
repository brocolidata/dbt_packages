with source as (

    select * from {{ source('adventure_works_full', 'ScrapReason') }}

),

renamed as (

    select
        CAST(ScrapReasonID AS int64) AS ID_raison,
        CAST(Name AS string) AS raison,
        CAST(ModifiedDate AS datetime) AS date_modification,
    from source

)

select * from renamed



