
    
    

select
    doctor_key as unique_field,
    count(*) as n_records

from "dbt-fabric project"."dbo_staging"."stg_doctors"
where doctor_key is not null
group by doctor_key
having count(*) > 1


