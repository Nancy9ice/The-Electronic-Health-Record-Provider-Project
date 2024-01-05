
    
    

select
    admission_key as unique_field,
    count(*) as n_records

from "dbt-fabric project"."dbo_staging"."stg_admissions"
where admission_key is not null
group by admission_key
having count(*) > 1


