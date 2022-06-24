with source as (

    select * from {{ source('stg', 'product_attribute') }}

),

renamed as (

    select
        write_date,
        write_uid,
        id,
        create_uid,
        name,
        create_variant,
        sequence,
        display_type,
        create_date,
        year,
        month

    from source

)

select * from renamed