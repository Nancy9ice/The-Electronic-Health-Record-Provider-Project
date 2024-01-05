
    
    

select
    patient_key as unique_field,
    count(*) as n_records

from "dbt-fabric project"."dbo_staging"."stg_patient_details"
where patient_key is not null
group by patient_key
having count(*) > 1


