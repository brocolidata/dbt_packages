with source as (

    select * from {{ source('stg', 'product_product') }}

),

renamed as (

    select
        create_date,
        product_tmpl_id,
        message_main_attachment_id,
        active,
        volume,
        barcode,
        combination_indices,
        create_uid,
        id,
        default_code,
        write_uid,
        can_image_variant_1024_be_zoomed,
        weight,
        write_date

    from source

)

select * from renamed