
    
    

with child as (
    select diagnosis_key as from_field
    from "dbt-fabric project"."dbo_staging"."stg_diagnosis"
    where diagnosis_key is not null
),

parent as (
    select diagnosis_key as to_field
    from "dbt-fabric project"."dbo_healthcare"."fct_hospital_revenue"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


