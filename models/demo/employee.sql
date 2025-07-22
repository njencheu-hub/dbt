{{ 
    config(
        materialized='table'
    ) 
}}

with employee_raw as (
    select
        EMPID as emp_id,
        split_part(NAME, ' ', 1) as emp_firstname,
        split_part(NAME, ' ', 2) as emp_lastname,
        SALARY as emp_salary,
        HIREDATE as emp_hiredate,
        split_part(ADDRESS, ',', 1) as emp_street,
        split_part(ADDRESS, ',', 2) as emp_city,
        split_part(ADDRESS, ',', 3) as emp_country,
        split_part(ADDRESS, ',', 4) as emp_zipcode
    -- from DBT_DB.PUBLIC.EMPLOYEE_RAW   -- this is hardcoded (shown when Compiled)
    from {{ source('employee', 'EMPLOYEE_RAW') }} -- {{ source('source_name','table_name')}} (see demo.yml file)
)

select * from employee_raw