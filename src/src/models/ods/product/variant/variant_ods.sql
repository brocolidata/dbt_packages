with source_product_template_attribute_line_format as (
    SELECT
        id,
        active,
        product_tmpl_id,
        attribute_id,
        year,
        month

    FROM {{ ref("product_template_attribute_line_format") }}
),

source_product_template_attribute_value_format as (
    SELECT
        id,
        ptav_active,
        product_attribute_value_id,
        attribute_line_id,
        price_extra,
        product_tmpl_id,
        attribute_id,
        create_uid,
        create_date,
        write_uid,
        write_date,
        year,
        month
    
    FROM {{ ref("product_template_attribute_value_format") }}
),

product_template_variant as (
    SELECT  
        templine.id as product_template_attribute_id,
        templine.active,
        templine.product_tmpl_id as product_template_id,
        templine.attribute_id,
        templine.year,
        templine.month,
        tempval.id,
        tempval.ptav_active,
        tempval.product_attribute_value_id,
        tempval.attribute_line_id,
        tempval.price_extra,
        tempval.product_tmpl_id as product_tmpl_id, 

    FROM source_product_template_attribute_line_format templine
    JOIN source_product_template_attribute_value_format tempval
        ON templine.id = tempval.attribute_id
)

SELECT * FROM product_template_variant