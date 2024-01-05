
    
    

with child as (
    select room_key as from_field
    from "dbt-fabric project"."dbo_staging"."stg_ward_rooms"
    where room_key is not null
),

parent as (
    select room_key as to_field
    from "dbt-fabric project"."dbo_healthcare"."dim_healthcare_provider"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


