
    
    

with child as (
    select doctor_key as from_field
    from "dbt-fabric project"."dbo_staging"."stg_doctors"
    where doctor_key is not null
),

parent as (
    select doctor_key as to_field
    from "dbt-fabric project"."dbo_healthcare"."fct_patient_stay"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


