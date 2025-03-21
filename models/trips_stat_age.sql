WITH age_trips AS (
    SELECT
        u.id AS user_id,
        DATE_PART('year', AGE(t.started_at, u.birth_date)) AS age,
        DATE(t.started_at) AS trip_date
    FROM
        scooters_raw.users u
    JOIN
        scooters_raw.trips t ON u.id = t.user_id
),
daily_trips AS (
    SELECT
        age,
        trip_date,
        COUNT(*) AS trips_count
    FROM
        age_trips
    GROUP BY
        age, trip_date
),
average_daily_trips AS (
    SELECT
        age,
        AVG(trips_count) AS avg_daily_trips
    FROM
        daily_trips
    GROUP BY
        age
)
SELECT
    age,
    avg_daily_trips as avg_trips
FROM
    average_daily_trips
ORDER BY
    age