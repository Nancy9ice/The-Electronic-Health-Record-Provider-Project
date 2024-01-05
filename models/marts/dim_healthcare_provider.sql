WITH patients AS (
    SELECT * FROM {{ ref("stg_healthcare_records")}}
), 
hospital_details AS (
    SELECT * FROM {{ ref("stg_hospitals")}}
)

-- It's possible to have multiple doctors and multiple rooms in a hospital

SELECT  hospital_key,
        CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(doctor, '_dbt_utils_surrogate_key_null_'))), 2) AS doctor_key,
        CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(room_number, '_dbt_utils_surrogate_key_null_'))), 2) AS room_key,
        hospital_name
FROM patients
RIGHT JOIN hospital_details
ON patients.hospital = hospital_details.hospital_name
GROUP BY hospital_key,
        CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(doctor, '_dbt_utils_surrogate_key_null_'))), 2),
        CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(room_number, '_dbt_utils_surrogate_key_null_'))), 2),
        hospital_name