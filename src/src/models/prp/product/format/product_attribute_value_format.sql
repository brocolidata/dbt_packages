with source as (

    select * from {{ source('stg', 'product_attribute_value') }}

),

renamed as (

    select
        is_custom,
        attribute_id,
        sequence,
        create_uid,
        name,
        write_date,
        write_uid,
        create_date,
        html_color,
        id,
        year,
        month

    from source

)

select * from renamed