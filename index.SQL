SELECT
  *
FROM
  `sql-project-1-427723.SQL_Dataset.Cleaned Up Data`

--How many states?--
SELECT Count(DISTINCT State) as distinct_count
From `SQL_Dataset.Cleaned Up Data`

--What was the average time of men vs. women?--
SELECT 
  Division, 
  ROUND(AVG(Total_minutes)) AS avg_time
FROM `SQL_Dataset.Cleaned Up Data`
GROUP BY Division;

--What were the youngest and oldest runners in the race?--
SELECT Division, Min(age) as youngest, Max(age) as oldest
FROM `sql-project-1-427723.SQL_Dataset.Cleaned Up Data`
group by Division

--What was the average time for each age group?--
WITH age_buckets AS (
  SELECT 
    total_minutes,
    CASE 
      WHEN age < 30 THEN 'age_20-29'
      WHEN age < 40 THEN 'age_30-39'
      WHEN age < 50 THEN 'age_40-49'
      WHEN age < 60 THEN 'age_50-59'
      ELSE 'age_60+' 
    END AS age_group
  FROM `SQL_Dataset.Cleaned Up Data`
)
SELECT 
  age_group, 
  ROUND(AVG(total_minutes)) AS avg_race_time
FROM age_buckets
GROUP BY age_group;

-- Top 3 males & females
WITH gender_rank AS (
  SELECT 
    RANK() OVER (PARTITION BY Division ORDER BY total_minutes ASC) AS rank,
    fullname,
    Division,
    total_minutes
  FROM `SQL_Dataset.Cleaned Up Data`
)

SELECT * 
FROM gender_rank
WHERE rank < 4
ORDER BY total_minutes;