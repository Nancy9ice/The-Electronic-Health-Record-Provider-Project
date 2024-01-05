
    
    

with all_values as (

    select
        patient_blood_type as value_field,
        count(*) as n_records

    from "dbt-fabric project"."dbo_staging"."stg_patient_details"
    group by patient_blood_type

)

select *
from all_values
where value_field not in (
    'O+','O-','A-','A+','AB-','AB+','B-','B+'
)


