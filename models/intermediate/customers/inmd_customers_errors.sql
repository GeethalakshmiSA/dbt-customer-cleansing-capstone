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
    creditcard_cvv,

    is_valid_custname,
    is_valid_phone,
    is_valid_email,
    is_valid_cust_id,
    is_valid_ytd_sales,

    array_to_string(
    array_construct_compact(
        case when not is_valid_custname then 'INVALID_CUSTOMER_NAME' end,
        case when not is_valid_phone then 'DUPLICATE_OR_INVALID_PHONE' end,
        case when not is_valid_email then 'INVALID_EMAIL' end,
        case when not is_valid_cust_id then 'INVALID_CUSTOMER_ID' end,
        case when not is_valid_ytd_sales then 'INVALID_YTD_SALES' end
        ), ' | '        
    ) as error_reason

from {{ ref('inmd_customers_validated') }}

where not is_valid_custname
   or not is_valid_phone
   or not is_valid_email
   or not is_valid_cust_id
   or not is_valid_ytd_sales