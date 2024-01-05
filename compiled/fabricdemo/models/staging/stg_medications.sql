WITH patients AS (
    SELECT * FROM "dbt-fabric project"."dbo_staging"."stg_healthcare_records"
)

SELECT
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(medication, '_dbt_utils_surrogate_key_null_'))), 2) AS medication_key,
    medication, 
    CASE
        WHEN medication = 'Penicillin' THEN 'Antibiotics'
        WHEN medication = 'Lipitor' THEN 'Antihyperlipidemics'
        WHEN medication = 'Aspirin' THEN 'Analgesics'
        WHEN medication = 'Ibuprofen' THEN 'Analgesics'
        WHEN medication = 'Paracetamol' THEN 'Analgesics'
    END AS drug_category
FROM patients
GROUP BY medication;