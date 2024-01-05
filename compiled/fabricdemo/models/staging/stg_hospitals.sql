WITH patients AS (
    SELECT * FROM "dbt-fabric project"."dbo_staging"."stg_healthcare_records"
)

-- Assuming that multiple hospitals cannot have the same name
select
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(hospital, '_dbt_utils_surrogate_key_null_'))), 2) AS hospital_key,
    hospital as hospital_name
from patients
group by hospital