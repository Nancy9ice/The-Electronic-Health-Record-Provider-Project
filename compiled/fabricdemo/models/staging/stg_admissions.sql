WITH patients AS (
    SELECT * FROM "dbt-fabric project"."dbo_staging"."stg_healthcare_records"
)

SELECT
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(admission_type, '_dbt_utils_surrogate_key_null_'))), 2) AS admission_key,
    admission_type
FROM patients
GROUP BY admission_type;