{{
    config(
        materialized='view'
    )
}}

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

from {{ ref('inmd_customers_validated') }}

where is_valid_custname
  and is_valid_phone
  and is_valid_email
  and is_valid_cust_id
  and is_valid_ytd_sales