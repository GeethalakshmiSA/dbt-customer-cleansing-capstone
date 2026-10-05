{{
    config(
        materialized='view'
    )
}}

with customers as ( 
    select * from {{ ref('inmd_customers_valid') }}
),

countries as (
    select country_code, country_name from {{ ref('countries') }}
),

enriched as (
    select
        c.cust_id,
        c.custname,
        c.city,
        c.state,
        c.country_code,
        co.country_name,
        c.postal_code,
        c.email_address,
        c.phone_number,
        c.ytd_sales,
        c.salesrep_id,
        c.nationality,
        c.national_id,
        c.creditcard_number,
        c.creditcard_type,
        try_to_date('01-' || c.creditcard_exp,'DD-YY-MON') as creditcard_exp_date,
        c.creditcard_cvv
    from customers c
    left join 
        countries co
        on c.country_code = co.country_code
)
select * from enriched