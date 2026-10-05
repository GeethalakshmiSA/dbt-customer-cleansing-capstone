{{
    config(
        materialized='view'
    )
}}

with ranked as (

    select
        *,
        row_number() over (
            partition by cust_id
            order by cust_id
        ) as rn

    from {{ ref('stg_customers') }}

)

select
    cust_id,
    custname,
    city,
    state,
    country_code,
    postal_code,
    email_address,
    phone_number,
    ytd_sales,
    salesrep_id,
    nationality,
    national_id,
    creditcard_number,
    creditcard_type,
    creditcard_exp,
    creditcard_cvv
from ranked
where rn = 1