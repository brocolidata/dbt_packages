with source as (

    select * from {{ source('stg', 'purchase_order_line') }}

),

purchase_order_line_format as (

    select
        id,
        name,
        product_qty,
        cast(date_planned as DATETIME) as date_planned,
        product_id,
        price_unit,
        price_total,
        order_id,
        company_id,
        state,
        partner_id,
        cast(create_date as DATETIME) as create_date,
        cast(write_date as DATETIME) as write_date

    from source 

)

select * from purchase_order_line_format