with source as (

    select * from {{ source('stg', 'product_variant_combination') }}

),

renamed as (

    select
        product_template_attribute_value_id,
        product_product_id,
        year,
        month

    from source

)

select * from renamed