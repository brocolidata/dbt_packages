with source as (

    select * from {{ source('adventure_works_full', 'ScrapReason') }}

),

renamed as (

    select
        CAST(scrapreasonid as int64) as id_raison,
        CAST(name as string) as raison,
        CAST(modifieddate as datetime) as date_modification
    from source

)

select * from renamed
