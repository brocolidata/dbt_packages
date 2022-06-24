with source as (

    select * from {{ source('stg', 'product_attribute_product_template_rel') }}

),

renamed as (

    select
        product_template_id,
        product_attribute_id

    from source

)

select * from renamed