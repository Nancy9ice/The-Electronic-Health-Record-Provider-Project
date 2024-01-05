WITH patients AS (
    SELECT * FROM "dbt-fabric project"."dbo_staging"."stg_healthcare_records"
)

SELECT
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(room_number, '_dbt_utils_surrogate_key_null_'))), 2) AS room_key,
    room_number
FROM patients
GROUP BY CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(room_number, '_dbt_utils_surrogate_key_null_'))), 2), 
        room_number;