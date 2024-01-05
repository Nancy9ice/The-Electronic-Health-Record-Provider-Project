
    
    

select
    result_key as unique_field,
    count(*) as n_records

from "dbt-fabric project"."dbo_staging"."stg_test_results"
where result_key is not null
group by result_key
having count(*) > 1


