# DBT_Training

# Customer Data Cleansing ELT Pipeline

A dbt + Snowflake capstone project implementing an end-to-end ELT workflow for customer data cleansing, validation, enrichment, and incremental loading.

## Project Objective

The objective of this project is to build a customer data cleansing pipeline that:

- loads customer source files into a Snowflake raw layer
- standardizes and cleans source attributes
- removes duplicate customer records
- validates customer names
- validates phone-number uniqueness
- validates email addresses
- separates invalid records for investigation
- enriches customers using a country lookup
- corrects datatype and formatting issues
- standardizes credit-card expiry dates
- creates a customer warehouse target with a surrogate key
- supports incremental inserts and updates

## Technology Stack

- dbt
- Snowflake
- SQL
- Jinja
- Git
- GitHub

## High-Level Architecture

```text
Customer Source File
        |
        v
      RAW
        |
        v
      STG
        |
        +------> Error Records
        |
        v
Cleansing & Enrichment
        |
        v
      DWH
        |
        v
  DIM_CUSTOMER
