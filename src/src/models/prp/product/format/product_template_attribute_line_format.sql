with source as (

    select * from {{ source('stg', 'product_template_attribute_line') }}

),

renamed as (

    select
        active,
        write_date,
        create_date,
        attribute_id,
        product_tmpl_id,
        write_uid,
        id,
        create_uid
        year,
        month

    from source

)

select * from renamed