with transaction_history as (

    select * from {{ ref('TransactionHistory_prp') }}
),


transaction_history_archive as (

    select * from {{ ref('TransactionHistoryArchive_prp') }}
),

detail_transaction as (

    select * from transaction_history
    union all
    select * from transaction_history_archive

)

select * from detail_transaction
