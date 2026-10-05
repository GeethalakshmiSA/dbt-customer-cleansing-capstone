{{
    config(
        materialized='view'
    )
}}

select
    try_to_number(trim(cust_id)) as cust_id,

    trim(custname) as custname,
    trim(city) as city,
    trim(state) as state,
    upper(trim(country_code)) as country_code,
    trim(postal_code) as postal_code,
    lower(trim(email_address)) as email_address,
    trim(phone_number) as phone_number,

    try_to_decimal(trim(ytd_sales), 18, 2) as ytd_sales,

    trim(salesrep_id) as salesrep_id,
    trim(nationality) as nationality,
    trim(national_id) as national_id,

    trim(creditcard_number) as creditcard_number,
    trim(creditcard_type) as creditcard_type,
    trim(creditcard_exp) as creditcard_exp,
    trim(creditcard_cvv) as creditcard_cvv

from {{ source('customer_raw', 'CUSTOMERS_RAW') }}