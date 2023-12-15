WITH patients AS (
    SELECT * FROM {{ ref("stg_healthcare_records")}}
)

-- Assuming that there could be different patients with the same name. The primary key was generated from name, age, gender, and blood_type
SELECT
    COALESCE(CONVERT(VARCHAR(100), name), '') + '-' +
    CAST(age AS VARCHAR(10)) + '-' +
    COALESCE(CONVERT(VARCHAR(10), gender), '') + '-' +
    COALESCE(CONVERT(VARCHAR(10), blood_type), '') AS patient_key,
    name as patient_full_name,
    SUBSTRING(name, 1, CHARINDEX(' ', name + ' ') - 1) AS patient_first_name,
    REVERSE(SUBSTRING(REVERSE(name), 1, CHARINDEX(' ', REVERSE(name)) - 1)) AS patient_last_name,
    age AS patient_age,
    CASE
        WHEN age < 1 THEN 'Infant'
        WHEN age BETWEEN 1 AND 5 THEN 'Toddler'
        WHEN age BETWEEN 6 AND 12 THEN 'Child'
        WHEN age BETWEEN 13 AND 17 THEN 'Adolescent'
        WHEN age BETWEEN 18 AND 64 THEN 'Adult'
        WHEN age > 64 THEN 'Older Adult'
    END AS patient_age_category,
    gender AS patient_gender,
    blood_type AS patient_blood_type
FROM patients
GROUP BY name,
        age, 
        gender, 
        blood_type