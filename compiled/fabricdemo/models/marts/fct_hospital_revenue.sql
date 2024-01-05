WITH patients AS (
    SELECT * FROM "dbt-fabric project"."dbo_staging"."stg_healthcare_records"
),
date_cte AS (
    SELECT * FROM "dbt-fabric project"."dbo_healthcare"."dim_date"
)

SELECT
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(hospital, '_dbt_utils_surrogate_key_null_'))), 2) AS hospital_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(doctor, '_dbt_utils_surrogate_key_null_'))), 2) AS doctor_key,
    date_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(admission_type, '_dbt_utils_surrogate_key_null_'))), 2) AS admission_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medical_condition, '_dbt_utils_surrogate_key_null_'))), 2) AS diagnosis_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(insurance_provider, '_dbt_utils_surrogate_key_null_'))), 2) AS insurance_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medication, '_dbt_utils_surrogate_key_null_'))), 2) AS medication_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(test_results, '_dbt_utils_surrogate_key_null_'))), 2) AS result_key,
    full_date as date,
    hospital,
    ROUND(SUM(patients.billing_amount), 2) AS total_revenue
FROM patients
LEFT JOIN date_cte ON patients.admission_date = date_cte.full_date
GROUP BY 
        CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(hospital, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(doctor, '_dbt_utils_surrogate_key_null_'))), 2),
    date_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(admission_type, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medical_condition, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(insurance_provider, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medication, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(test_results, '_dbt_utils_surrogate_key_null_'))), 2),
    full_date,
    hospital