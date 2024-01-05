
    
    

with all_values as (

    select
        test_results as value_field,
        count(*) as n_records

    from "dbt-fabric project"."dbo_staging"."stg_test_results"
    group by test_results

)

select *
from all_values
where value_field not in (
    'Inconclusive','Abnormal','Normal'
)


