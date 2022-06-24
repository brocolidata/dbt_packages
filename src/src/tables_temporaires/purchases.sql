with source as (
    SELECT * FROM {{ source('ods', 'purchase_clean') }}
),

purchases_temp as (
    SELECT
        order_line_ID as Order_line_ID,
        order_line_name as Order_line_name,
        product_quantity as Product_Quantity,
        date_planned as Date_planned,
        product_ID as Product_ID,
        price_unit as Unit_price,
        price_total as Total_price,
        id_order as Order_ID,
        company_id as Company_ID,
        state as State,
        partner_id as Partner_ID,
        order_name as Order_name,
        date_order as Order_date,
        amount_total as Total_Amount

    FROM source 
)

SELECT * FROM purchases_temp