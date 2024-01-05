
    
    

select
    room_key as unique_field,
    count(*) as n_records

from "dbt-fabric project"."dbo_staging"."stg_ward_rooms"
where room_key is not null
group by room_key
having count(*) > 1


