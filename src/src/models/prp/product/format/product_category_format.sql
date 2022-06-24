with source as (

    select * from {{ source('stg', 'product_category') }}

),

renamed as (

    select
        id,
        name,
        complete_name,
        parent_id,
        parent_path,
        create_uid,
        create_date,
        write_uid,
        write_date,
        removal_strategy_id,
        year,
        month

    from source

)

select * from renamed