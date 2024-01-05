
    
    

with all_values as (

    select
        admission_type as value_field,
        count(*) as n_records

    from "dbt-fabric project"."dbo_staging"."stg_admissions"
    group by admission_type

)

select *
from all_values
where value_field not in (
    'Elective','Emergency','Urgent'
)


