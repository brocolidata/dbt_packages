with source_product_format as (
    select 
        id,
        message_main_attachment_id,
        default_code,
        active,
        product_tmpl_id,
        barcode,
        combination_indices,
        volume,
        weight,
        can_image_variant_1024_be_zoomed,
        create_uid,
        create_date,
        write_uid,
        write_date
    
     from {{ ref("product_product_format") }}
),

source_product_template_format as (

    select  
        id,
        message_main_attachment_id,
        name,
        sequence,
        description,
        description_purchase,
        description_sale,
        type,
        categ_id,
        list_price,
        volume,
        weight,
        sale_ok,
        purchase_ok,
        uom_id,
        uom_po_id,
        company_id,
        active,
        color,
        default_code,
        can_image_1024_be_zoomed,
        has_configurable_attributes,
        create_uid,
        create_date,
        write_uid,
        write_date,
        service_type,
        sale_line_warn,
        sale_line_warn_msg,
        expense_policy,
        invoice_policy,
        sale_delay,
        tracking,
        description_picking,
        description_pickingout,
        description_pickingin,
        purchase_method,
        purchase_line_warn,
        purchase_line_warn_msg,
        service_to_purchase

    from {{ ref("product_template_format") }}
),

source_product_category_format as (

    SELECT
        id,
        name,
        complete_name,
        parent_id,
        parent_path,
        create_uid,
        create_date,
        write_uid,
        write_date,
        removal_strategy_id

    from {{ ref("product_category_format") }}
),

source_product_variant_combination_format as (

    select 
        product_product_id,
        product_template_attribute_value_id

    from {{ ref("product_variant_combination_format") }}
),

product_template_category as (
    SELECT
        temp.id as template_id,
        temp.name as template_name,
        temp.description,
        temp.description_sale,
        temp.type,
        temp.categ_id,
        temp.list_price,
        temp.volume,
        temp.weight,
        temp.sale_ok,
        temp.purchase_ok,
        temp.uom_id,
        temp.uom_po_id,
        temp.active as template_active,
        temp.color,
        temp.default_code as default_template_code,
        temp.can_image_1024_be_zoomed,
        temp.has_configurable_attributes,
        temp.expense_policy,
        temp.invoice_policy,
        temp.sale_delay,
        temp.tracking,
        categ.id as category_id,
        categ.name as category_name,
        categ.complete_name,
        categ.parent_id,
        categ.parent_path,
        prod.id as product_id,
        prod.message_main_attachment_id,
        prod.default_code as default_code_product,
        prod.active as active_product,
        prod.product_tmpl_id,
        prod.barcode,
        prod.combination_indices,
        prod.volume as product_volume,
        prod.weight as weight_product,
        prod.can_image_variant_1024_be_zoomed,
        rel.product_product_id,
        rel.product_template_attribute_value_id

    FROM source_product_template_format temp
    JOIN source_product_category_format categ
        ON temp.categ_id = categ.id
    JOIN source_product_format prod
        ON prod.product_tmpl_id = temp.id
    JOIN source_product_variant_combination_format rel
        ON rel.product_product_id = prod.id
)

SELECT * FROM product_template_category



