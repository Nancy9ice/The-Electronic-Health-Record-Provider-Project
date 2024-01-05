
    
    

with child as (
    select hospital_key as from_field
    from "dbt-fabric project"."dbo_staging"."stg_hospitals"
    where hospital_key is not null
),

parent as (
    select hospital_key as to_field
    from "dbt-fabric project"."dbo_healthcare"."dim_healthcare_provider"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


