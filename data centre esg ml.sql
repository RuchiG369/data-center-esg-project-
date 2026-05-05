Q1 --Have the required project tables been loaded correctly into PostgreSQL?
SELECT 
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT 
    'data_center_daily' AS table_name,
    COUNT(*) AS row_count
FROM data_center_daily

UNION ALL

SELECT 
    'site_priority_score' AS table_name,
    COUNT(*) AS row_count
FROM site_priority_score;

Q2--Which data center is losing the most money due to energy waste and SLA penalties?
SELECT
    site_name,
    city,
    cooling_type,
    ROUND(SUM(revenue_leakage_usd)::numeric, 2) AS total_revenue_leakage_usd,
    ROUND(AVG(revenue_leakage_percent)::numeric, 2) AS avg_revenue_leakage_percent,
    ROUND(AVG(pue)::numeric, 2) AS avg_pue,
    ROUND(AVG(gross_margin_percent)::numeric, 2) AS avg_gross_margin_percent
FROM data_center_daily
GROUP BY site_name, city, cooling_type
ORDER BY total_revenue_leakage_usd DESC;

Q3--Which data center has the worst PUE and weakest energy efficiency?
SELECT
    site_name,
    city,
    cooling_type,
    ROUND(AVG(pue)::numeric, 2) AS avg_pue,
    ROUND(AVG(pue_gap)::numeric, 2) AS avg_pue_gap,
    ROUND(SUM(total_facility_energy_kwh)::numeric, 2) AS total_energy_kwh,
    ROUND(SUM(cooling_cost_usd)::numeric, 2) AS total_cooling_cost_usd
FROM data_center_daily
GROUP BY site_name, city, cooling_type
ORDER BY avg_pue DESC;

Q4-- Which data center creates the highest Scope 2 emissions?
SELECT
    site_name,
    city,
    cooling_type,
    ROUND(SUM(scope_2_emissions_tco2e)::numeric, 2) AS total_scope_2_emissions_tco2e,
    ROUND(SUM(total_facility_energy_kwh)::numeric, 2) AS total_energy_kwh,
    ROUND(AVG(actual_renewable_share_percent)::numeric, 2) AS avg_renewable_share_percent,
    ROUND(AVG(actual_fossil_share_percent)::numeric, 2) AS avg_fossil_share_percent
FROM data_center_daily
GROUP BY site_name, city, cooling_type
ORDER BY total_scope_2_emissions_tco2e DESC;

Q5--Which cooling type performs best from an efficiency and profitability perspective?
SELECT
    cooling_type,
    COUNT(DISTINCT site_name) AS number_of_sites,
    ROUND(AVG(pue)::numeric, 2) AS avg_pue,
    ROUND(AVG(cooling_energy_share_percent)::numeric, 2) AS avg_cooling_energy_share_percent,
    ROUND(SUM(cooling_cost_usd)::numeric, 2) AS total_cooling_cost_usd,
    ROUND(SUM(revenue_leakage_usd)::numeric, 2) AS total_revenue_leakage_usd,
    ROUND(AVG(gross_margin_percent)::numeric, 2) AS avg_gross_margin_percent
FROM data_center_daily
GROUP BY cooling_type
ORDER BY avg_pue ASC;

Q6--Which month has the highest energy cost and seasonal cost pressure?
SELECT
    month,
    month_name,
    ROUND(SUM(total_facility_energy_kwh)::numeric, 2) AS total_energy_kwh,
    ROUND(SUM(energy_cost_usd)::numeric, 2) AS total_energy_cost_usd,
    ROUND(SUM(cooling_cost_usd)::numeric, 2) AS total_cooling_cost_usd,
    ROUND(SUM(revenue_leakage_usd)::numeric, 2) AS total_revenue_leakage_usd,
    ROUND(AVG(pue)::numeric, 2) AS avg_pue
FROM data_center_daily
GROUP BY month, month_name
ORDER BY total_energy_cost_usd DESC;

Q7--Does higher temperature increase cooling cost and energy inefficiency?
SELECT
    CASE
        WHEN temperature_celsius < 25 THEN 'Below 25C'
        WHEN temperature_celsius >= 25 AND temperature_celsius < 30 THEN '25C to 30C'
        WHEN temperature_celsius >= 30 AND temperature_celsius < 35 THEN '30C to 35C'
        ELSE 'Above 35C'
    END AS temperature_band,
    ROUND(AVG(cooling_energy_kwh)::numeric, 2) AS avg_cooling_energy_kwh,
    ROUND(AVG(cooling_cost_usd)::numeric, 2) AS avg_cooling_cost_usd,
    ROUND(AVG(pue)::numeric, 2) AS avg_pue,
    COUNT(*) AS record_count
FROM data_center_daily
GROUP BY temperature_band
ORDER BY avg_cooling_cost_usd DESC;

Q8--Which sites have high idle server rates and high energy waste cost?
SELECT
    site_name,
    city,
    cooling_type,
    ROUND(AVG(server_utilization_rate_percent)::numeric, 2) AS avg_server_utilization_percent,
    ROUND(AVG(idle_server_rate_percent)::numeric, 2) AS avg_idle_server_rate_percent,
    ROUND(AVG(energy_per_active_server_kwh)::numeric, 2) AS avg_energy_per_active_server_kwh,
    ROUND(SUM(energy_waste_cost_usd)::numeric, 2) AS total_energy_waste_cost_usd,
    ROUND(SUM(revenue_leakage_usd)::numeric, 2) AS total_revenue_leakage_usd
FROM data_center_daily
GROUP BY site_name, city, cooling_type
ORDER BY total_energy_waste_cost_usd DESC;

Q9--Which data center should management fix first?
SELECT
    site_name,
    city,
    cooling_type,
    ROUND(avg_pue::numeric, 2) AS avg_pue,
    ROUND(total_revenue_leakage_usd::numeric, 2) AS total_revenue_leakage_usd,
    ROUND(total_scope_2_emissions_tco2e::numeric, 2) AS total_scope_2_emissions_tco2e,
    ROUND(avg_gross_margin::numeric, 2) AS avg_gross_margin,
    priority_score
FROM site_priority_score
ORDER BY priority_score ASC;

Q10--How many high-risk operating days does each site have?
SELECT
    site_name,
    city,
    cooling_type,
    COUNT(*) AS high_risk_days,
    ROUND(SUM(revenue_leakage_usd)::numeric, 2) AS high_risk_revenue_leakage_usd,
    ROUND(AVG(pue)::numeric, 2) AS avg_high_risk_pue,
    ROUND(AVG(gross_margin_percent)::numeric, 2) AS avg_high_risk_margin
FROM data_center_daily
WHERE risk_level = 'High'
GROUP BY site_name, city, cooling_type
ORDER BY high_risk_days DESC;






