
    
    

select
    insurance_key as unique_field,
    count(*) as n_records

from "dbt-fabric project"."dbo_staging"."stg_insurance_org"
where insurance_key is not null
group by insurance_key
having count(*) > 1


