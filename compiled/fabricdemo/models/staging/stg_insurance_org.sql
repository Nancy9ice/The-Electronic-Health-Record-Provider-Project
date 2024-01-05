WITH patients AS (
    SELECT * FROM "dbt-fabric project"."dbo_staging"."stg_healthcare_records"
)

SELECT
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(insurance_provider, '_dbt_utils_surrogate_key_null_'))), 2) AS insurance_key,
    insurance_provider
FROM patients
GROUP BY insurance_provider;