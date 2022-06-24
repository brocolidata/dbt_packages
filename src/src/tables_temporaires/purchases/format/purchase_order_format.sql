with source as (

    select * from {{ source('stg', 'purchase_order') }}

),

renamed as (

    select
        id,
        name,
        cast(date_order as DATETIME) as date_order,
        partner_id,
        state,
        amount_untaxed,
        amount_tax,
        amount_total,
        company_id,
        user_id

    from source

)

select * from renamed