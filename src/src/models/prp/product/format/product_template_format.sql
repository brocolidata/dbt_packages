with source as (

    select * from {{ source('stg', 'product_template') }}

),

renamed as (

    select
        service_type,
        expense_policy,
        write_date,
        color,
        has_configurable_attributes,
        purchase_method,
        description_pickingin,
        sale_line_warn_msg,
        description_picking,
        list_price,
        default_code,
        create_date,
        active,
        can_image_1024_be_zoomed,
        tracking,
        name,
        description_sale,
        purchase_line_warn_msg,
        description,
        sale_line_warn,
        create_uid,
        purchase_line_warn,
        uom_id,
        volume,
        sale_ok,
        type,
        uom_po_id,
        description_pickingout,
        id,
        service_to_purchase,
        company_id,
        weight,
        sequence,
        purchase_ok,
        sale_delay,
        invoice_policy,
        categ_id,
        message_main_attachment_id,
        write_uid,
        description_purchase,
        year,
        month

    from source

)

select * from renamed