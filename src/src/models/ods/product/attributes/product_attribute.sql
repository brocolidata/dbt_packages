with source_product_attribute_format as (
    SELECT 
        id,
        name,
        create_variant,
        display_type,
        create_uid,
        create_date,
        write_uid,
        write_date,
        year,
        month   
    FROM {{ ref("product_attribute_format") }}
),

source_product_attribute_value_format as (
    SELECT
        id,
        name,
        attribute_id,
        is_custom,
        html_color,
        create_uid,
        create_date,
        write_uid,
        write_date,
        year,
        month

    from {{ ref("product_attribute_value_format") }}
),

product_attribute_union as (
    SELECT 
        attrib.id as product_attribute_id,
        attrib.name as product_attribute_name,
        attrib.create_variant,
        attrib.display_type,
        attrib.create_uid,
        attrib.create_date,
        attrib.write_uid,
        attrib.write_date,
        attrib.year,
        attrib.month,
        attrval.id as product_attribute_value_id,
        attrval.name as product_attribute_value_name,
        attrval.attribute_id,
        attrval.is_custom,
        attrval.html_color

    FROM source_product_attribute_format attrib
    JOIN source_product_attribute_value_format attrval
    ON attrib.id = attrval.attribute_id
)

SELECT * FROM product_attribute_union

