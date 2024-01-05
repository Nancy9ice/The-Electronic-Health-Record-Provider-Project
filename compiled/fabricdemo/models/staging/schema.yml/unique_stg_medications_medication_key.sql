
    
    

select
    medication_key as unique_field,
    count(*) as n_records

from "dbt-fabric project"."dbo_staging"."stg_medications"
where medication_key is not null
group by medication_key
having count(*) > 1


