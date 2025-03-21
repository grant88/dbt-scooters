SELECT 
    COUNT(*) AS trips,
    COUNT(DISTINCT user_id) AS users,
    AVG(EXTRACT(EPOCH FROM (finished_at - started_at)) / 60) AS avg_duration_m,
    SUM(price) AS revenue_rub,
    (COUNT(*) FILTER (WHERE price = 0) * 100.0 / COUNT(*)) AS free_trips_pct
FROM 
    scooters_raw.trips