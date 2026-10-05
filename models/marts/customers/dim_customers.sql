{{
    config(
        materialized='incremental',
        unique_key='cust_id',
        incremental_strategy='merge'
    )
}}

select
    {{ dbt_utils.generate_surrogate_key(['cust_id']) }} as customer_sk,

    cust_id,
    custname,
    city,
    state,
    country_code,
    country_name,
    postal_code,
    email_address,
    phone_number,
    ytd_sales,
    salesrep_id,
    nationality,
    national_id,
    creditcard_number,
    creditcard_type,
    creditcard_exp_date,
    creditcard_cvv

from {{ ref('inmd_customers_enriched') }}