WITH source AS (
    SELECT * FROM {{ source('healthcare_records', 'healthcare_data') }}
)

-- Duplicates were removed from the source data
select DISTINCT
    Name as name, 
    cast(Age AS int) as age, 
    "Gender" as gender, 
    "Blood Type" as blood_type,
    "Medical Condition" as medical_condition, 
    convert(date, "Date of Admission") as admission_date,
    Doctor as doctor,
    Hospital as hospital,
    "Insurance Provider" as insurance_provider,
    cast("Billing Amount" as float) as "billing_amount",
    "Room Number" as room_number,
    "Admission Type" as admission_type,
    convert(date, "Discharge Date") as discharge_date,
    Medication as medication,
    "Test Results" as test_results
from source