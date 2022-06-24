with source as (

    select * from {{ source('stg', 'product_template_attribute_value') }}

),

renamed as (

    select
        create_uid,
        ptav_active,
        price_extra,
        id,
        attribute_line_id,
        product_tmpl_id,
        write_uid,
        write_date,
        product_attribute_value_id,
        attribute_id,
        create_date,
        year,
        month

    from source

)

select * from renamed