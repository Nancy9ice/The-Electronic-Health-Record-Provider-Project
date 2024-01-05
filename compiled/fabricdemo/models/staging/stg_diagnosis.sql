with patients as (
    select * from "dbt-fabric project"."dbo_staging"."stg_healthcare_records"
)

select
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medical_condition, '_dbt_utils_surrogate_key_null_'))), 2) AS diagnosis_key,
    medical_condition as diagnosis
from patients
group by CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medical_condition, '_dbt_utils_surrogate_key_null_'))), 2), 
        medical_condition