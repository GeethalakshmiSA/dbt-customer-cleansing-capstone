{{
    config(
        materialized='view'
    )
}}

with base as (
    select * from {{ ref('inmd_customers_deduped') }}
),

phone_check as (
    select *, count(*) over (partition by phone_number) as phone_count from base
),

validated as (
    select *,

        /* Customer name: alphabets and spaces only */
        case when custname is null or not regexp_like(custname, '^[A-Za-z ]+$') then false else true
        end as is_valid_custname,

        /* Phone must exist and be unique */
        case when phone_number is null or trim(phone_number) = '' or phone_count > 1 then false else true
        end as is_valid_phone,

        /* Basic email format validation */
        case when email_address is null or not regexp_like(email_address,'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') then false else true
        end as is_valid_email,

        /* ID conversion check */
        case when cust_id is null then false else true
        end as is_valid_cust_id,

        /* Sales conversion check */
        case when ytd_sales is null then false else true
        end as is_valid_ytd_sales

    from phone_check
)

select * from validated