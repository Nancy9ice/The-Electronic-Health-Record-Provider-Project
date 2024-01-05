
    
    

select
    hospital_key as unique_field,
    count(*) as n_records

from "dbt-fabric project"."dbo_staging"."stg_hospitals"
where hospital_key is not null
group by hospital_key
having count(*) > 1


