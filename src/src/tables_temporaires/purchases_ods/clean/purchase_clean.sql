with source_purchase_order_line_format as (
    SELECT
        id,
        name,
        product_qty,
        date_planned,
        product_id,
        price_unit,
        price_total,
        order_id,
        company_id,
        state,
        partner_id,
        create_date,
        write_date
    FROM {{ ref("purchase_order_line_format") }}
),


source_purchase_order_format as (
    SELECT 
        id,
        name,
        date_order,
        partner_id,
        state,
        amount_untaxed,
        amount_tax,
        amount_total,
        company_id,
        user_id
    FROM {{ ref("purchase_order_format") }}
),

purchase_order_union as (
    SELECT
        polt.id as order_line_ID,
        polt.name as order_line_name,
        polt.product_qty as product_quantity,
        polt.date_planned as date_planned,
        polt.product_id as product_ID,
        polt.price_unit as price_unit,
        polt.price_total as price_total,
        polt.order_id as id_order,
        polt.company_id as company_id,
        polt.state as state,
        polt.partner_id as partner_id,
        pot.id as order_ID,
        pot.name as order_name,
        pot.date_order as date_order,
        pot.amount_total as amount_total

    FROM source_purchase_order_line_format polt
    JOIN source_purchase_order_format pot
    ON polt.order_id = pot.id
)

SELECT * FROM purchase_order_union