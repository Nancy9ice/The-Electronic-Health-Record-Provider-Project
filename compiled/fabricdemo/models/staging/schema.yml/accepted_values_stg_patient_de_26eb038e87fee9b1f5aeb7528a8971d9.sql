
    
    

with all_values as (

    select
        patient_age_category as value_field,
        count(*) as n_records

    from "dbt-fabric project"."dbo_staging"."stg_patient_details"
    group by patient_age_category

)

select *
from all_values
where value_field not in (
    'Infant','Toddler','Child','Adolescent','Adult','Older Adult'
)


