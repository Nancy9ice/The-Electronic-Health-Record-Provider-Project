WITH
    dates_raw AS (
        SELECT
            DATEADD(day, value, CAST('2018-01-01' AS DATE)) AS full_date
        FROM
            generate_series(0, DATEDIFF(day, '2018-01-01', GETDATE()), 1)
    ),
    days_info AS (
        SELECT
            full_date,
            CONVERT(VARCHAR(32), HASHBYTES('MD5', CONVERT(VARBINARY(MAX), COALESCE(full_date, '_dbt_utils_surrogate_key_null_'))), 2) AS date_key,
            CONVERT(VARCHAR(2), DATEPART(WEEKDAY, full_date)) AS day_of_week,
            CONVERT(VARCHAR(2), DATEPART(MONTH, full_date)) AS month,
            CONVERT(VARCHAR(2), DATEPART(QUARTER, full_date)) AS quarter,
            CONVERT(VARCHAR(3), DATEPART(DAYOFYEAR, full_date)) AS day_of_year,
            CONVERT(VARCHAR(4), DATEPART(YEAR, full_date)) AS year,
            CONVERT(VARCHAR(20), DATENAME(MONTH, full_date)) AS formatted_month_name,
            CONVERT(VARCHAR(10), RIGHT('0' + CONVERT(VARCHAR(2), DAY(full_date)), 2) + '-' + RIGHT('0' + CONVERT(VARCHAR(2), MONTH(full_date)), 2)) AS day_month
        FROM
            dates_raw
    ),
    days_named AS (
        SELECT
            *,
            CASE
                WHEN day_of_week = 1 THEN 'Sunday'
                WHEN day_of_week = 2 THEN 'Monday'
                WHEN day_of_week = 3 THEN 'Tuesday'
                WHEN day_of_week = 4 THEN 'Wednesday'
                WHEN day_of_week = 5 THEN 'Thursday'
                WHEN day_of_week = 6 THEN 'Friday'
                ELSE 'Saturday'
            END AS day_name,
            CASE
                WHEN month = 1 THEN 'January'
                WHEN month = 2 THEN 'February'
                WHEN month = 3 THEN 'March'
                WHEN month = 4 THEN 'April'
                WHEN month = 5 THEN 'May'
                WHEN month = 6 THEN 'June'
                WHEN month = 7 THEN 'July'
                WHEN month = 8 THEN 'August'
                WHEN month = 9 THEN 'September'
                WHEN month = 10 THEN 'October'
                WHEN month = 11 THEN 'November'
                ELSE 'December'
            END AS month_name,
            CASE
                WHEN quarter = 1 THEN '1st Quarter'
                WHEN quarter = 2 THEN '2nd Quarter'
                WHEN quarter = 3 THEN '3rd Quarter'
                ELSE '4th Quarter'
            END AS quarter_name
        FROM
            days_info
    )
SELECT
    date_key,
    full_date,
    day_of_week,
    day_name,
    month,
    month_name,
    quarter,
    quarter_name,
    day_of_year,
    year
FROM
    days_named;