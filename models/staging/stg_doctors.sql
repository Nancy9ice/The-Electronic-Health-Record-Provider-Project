WITH patients AS (
    SELECT * FROM {{ ref("stg_healthcare_records")}}
)

--  Assuming that one doctor cannot work in multiple hospitals
SELECT
    CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(doctor, '_dbt_utils_surrogate_key_null_'))), 2) AS doctor_key,
    doctor_first_name,
    doctor_last_name
FROM (
    SELECT
        doctor,
        CASE WHEN CHARINDEX(' ', COALESCE(CONVERT(VARCHAR(100), doctor), '')) > 0 THEN SUBSTRING(COALESCE(CONVERT(VARCHAR(100), doctor), ''), 1, CHARINDEX(' ', COALESCE(CONVERT(VARCHAR(100), doctor), '')) - 1) ELSE COALESCE(CONVERT(VARCHAR(100), doctor), '') END AS doctor_first_name,
        CASE WHEN CHARINDEX(' ', COALESCE(CONVERT(VARCHAR(100), doctor), '')) > 0 THEN SUBSTRING(COALESCE(CONVERT(VARCHAR(100), doctor), ''), CHARINDEX(' ', COALESCE(CONVERT(VARCHAR(100), doctor), '')) + 1, LEN(COALESCE(CONVERT(VARCHAR(100), doctor), '')) - CHARINDEX(' ', COALESCE(CONVERT(VARCHAR(100), doctor), ''))) ELSE NULL END AS doctor_last_name,
        hospital
    FROM patients
) AS subquery
GROUP BY doctor, doctor_first_name, doctor_last_name;