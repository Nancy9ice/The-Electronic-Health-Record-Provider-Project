WITH patients AS (
    SELECT * FROM "dbt-fabric project"."dbo_staging"."stg_healthcare_records"
), 
patient_details AS (
    SELECT * FROM "dbt-fabric project"."dbo_staging"."stg_patient_details"
),
date_cte AS (
    SELECT * FROM "dbt-fabric project"."dbo_healthcare"."dim_date"
),
hospitals AS (
    SELECT * FROM "dbt-fabric project"."dbo_healthcare"."dim_healthcare_provider"
)

-- Assuming that there can be patients that could visit the hospital more than once
SELECT  
    patient_key,
    hospital_key,
    date_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(admission_type, '_dbt_utils_surrogate_key_null_'))), 2) AS admission_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medical_condition, '_dbt_utils_surrogate_key_null_'))), 2) AS diagnosis_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(insurance_provider, '_dbt_utils_surrogate_key_null_'))), 2) AS insurance_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medication, '_dbt_utils_surrogate_key_null_'))), 2) AS medication_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(test_results, '_dbt_utils_surrogate_key_null_'))), 2) AS result_key,
    patient_first_name,
    patient_last_name,
    patient_age,
    patient_age_category,
    patient_gender,
    patient_blood_type,
    admission_date,
    discharge_date
FROM patients
INNER JOIN date_cte ON date_cte.full_date = patients.admission_date
RIGHT JOIN patient_details ON patients.name = patient_details.patient_full_name
INNER JOIN hospitals ON patients.hospital = hospitals.hospital_name
GROUP BY  
    patient_key,
    hospital_key,
    date_key,
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(admission_type, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medical_condition, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(insurance_provider, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medication, '_dbt_utils_surrogate_key_null_'))), 2),
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(test_results, '_dbt_utils_surrogate_key_null_'))), 2),
    patient_first_name,
    patient_last_name,
    patient_age,
    patient_age_category,
    patient_gender,
    patient_blood_type,
    admission_date,
    discharge_date