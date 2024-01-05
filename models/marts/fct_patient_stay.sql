WITH patients AS (
    SELECT * FROM {{ ref("stg_healthcare_records")}}
),
date_cte AS (
    SELECT * FROM {{ ref("dim_date")}}
)

SELECT
    COALESCE(CONVERT(VARCHAR(100), name), '') + '-' +
    CAST(age AS VARCHAR(10)) + '-' +
    COALESCE(CONVERT(VARCHAR(10), gender), '') + '-' +
    COALESCE(CONVERT(VARCHAR(10), blood_type), '') AS patient_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(doctor, '_dbt_utils_surrogate_key_null_'))), 2) AS doctor_key,
    date_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(admission_type, '_dbt_utils_surrogate_key_null_'))), 2) AS admission_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medical_condition, '_dbt_utils_surrogate_key_null_'))), 2) AS diagnosis_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(insurance_provider, '_dbt_utils_surrogate_key_null_'))), 2) AS insurance_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medication, '_dbt_utils_surrogate_key_null_'))), 2) AS medication_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(test_results, '_dbt_utils_surrogate_key_null_'))), 2) AS result_key,
    admission_date,
    discharge_date,
    DATEDIFF(day, admission_date, discharge_date) AS "length_of_stay (in days)"
FROM patients
INNER JOIN date_cte ON patients.admission_date = date_cte.full_date
GROUP BY 
    COALESCE(CONVERT(VARCHAR(100), name), '') + '-' +
    CAST(age AS VARCHAR(10)) + '-' +
    COALESCE(CONVERT(VARCHAR(10), gender), '') + '-' +
    COALESCE(CONVERT(VARCHAR(10), blood_type), ''),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(doctor, '_dbt_utils_surrogate_key_null_'))), 2),
    date_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(admission_type, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medical_condition, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(insurance_provider, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medication, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(test_results, '_dbt_utils_surrogate_key_null_'))), 2),
    admission_date,
    discharge_date,
    DATEDIFF(day, admission_date, discharge_date)