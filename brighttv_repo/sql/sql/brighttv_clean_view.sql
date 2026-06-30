-- ============================================================================
-- BrightTV Viewership Analytics — Final Clean View
-- Author: Charlotte Turya
-- Purpose: Single source-of-truth view joining viewership transactions with
--          user profiles, with UTC → SAST conversion and all derived fields
--          needed for the BrightTV EDA dashboard.
-- Platform: Databricks SQL
-- ============================================================================

CREATE OR REPLACE VIEW workspace.default.brighttv_clean AS

WITH user_profiles AS (
  SELECT
    UserID,
    -- Region cleaning
    CASE
      WHEN Province = ''     THEN 'Uncategorized'
      WHEN Province = 'None' THEN 'Uncategorized'
      ELSE Province
    END                                                AS region,
    Age,
    -- Age grouping
    CASE
      WHEN Age BETWEEN 0  AND 2  THEN 'Infants'
      WHEN Age BETWEEN 3  AND 12 THEN 'Kids'
      WHEN Age BETWEEN 13 AND 18 THEN 'Teenager'
      WHEN Age BETWEEN 19 AND 35 THEN 'Young Adult'
      WHEN Age BETWEEN 36 AND 64 THEN 'Middle Aged Adult'
      WHEN Age >= 65             THEN 'Senior'
      ELSE 'Unknown'
    END                                                AS age_group,
    -- Email flag
    CASE
      WHEN Email IS NOT NULL
       AND Email <> ''
       AND Email <> 'None' THEN 1
      ELSE 0
    END                                                AS email_flag,
    -- Social media flag
    CASE
      WHEN `Social Media Handle` IS NOT NULL
       AND `Social Media Handle` <> ''
       AND `Social Media Handle` <> 'None' THEN 1
      ELSE 0
    END                                                AS social_media_flag,
    -- Race cleaning
    CASE
      WHEN Race ILIKE '%other%' THEN 'None'
      WHEN Race = ''            THEN 'None'
      ELSE Race
    END                                                AS race,
    -- Gender cleaning
    CASE
      WHEN Gender = ''     THEN 'Unknown'
      WHEN Gender = 'None' THEN 'Unknown'
      ELSE Gender
    END                                                AS gender
  FROM workspace.default.bright_tv_users_profiles
),

-- Step 1: raw viewership with UTC → SAST conversion
viewership_raw AS (
  SELECT
    COALESCE(UserID0, userid4, 'Unknown')              AS UserID,

    -- UTC → SAST (+2 hours)
    DATEADD(HOUR, 2, RecordDate2)                      AS record_date_sast,

    -- Date fields
    DATE_FORMAT(
      DATEADD(HOUR, 2, RecordDate2), 'yyyy-MM')        AS month_id,
    DATE(DATEADD(HOUR, 2, RecordDate2))                AS watch_date,
    DATE_FORMAT(
      DATEADD(HOUR, 2, RecordDate2), 'HH:mm:ss')       AS watch_time,

    -- Day fields
    DAYNAME(DATEADD(HOUR, 2, RecordDate2))             AS day_name,
    DATE_FORMAT(
      DATEADD(HOUR, 2, RecordDate2), 'DD')             AS day_of_month,
    HOUR(DATEADD(HOUR, 2, RecordDate2))                AS hour_of_day,

    -- Month
    MONTHNAME(DATEADD(HOUR, 2, RecordDate2))           AS month_name,

    -- Channel cleaning
    CASE
      WHEN Channel2 IN ('SawSee', 'Sawsee')
        THEN 'SawSee'
      WHEN Channel2 IN (
        'SuperSport Live Events', 'Supersport Live Events',
        'DSTV Events 1', 'Live on SuperSport', 'Live Events'
      )
        THEN 'Live Events'
      ELSE Channel2
    END                                                AS tv_channel,

    -- Screen time (duration as string)
    DATE_FORMAT(`Duration 2`, 'HH:mm:ss')             AS screen_time,

    -- Screen time as decimal minutes (for SUM/AVG calculations)
    ROUND(
      (HOUR(`Duration 2`) * 60) +
       MINUTE(`Duration 2`) +
      (SECOND(`Duration 2`) / 60.0)
    , 2)                                               AS screen_time_minutes

  FROM workspace.default.bright_tv_viewership
),

-- Step 2: derived columns that depend on watch_time & day_name
viewership_enriched AS (
  SELECT
    *,
    -- Weekend vs weekday
    CASE
      WHEN day_name IN ('Saturday', 'Sunday') THEN 'Weekend'
      ELSE 'Weekday'
    END                                                AS day_classification,

    -- Day sort order (for correct chart ordering)
    CASE day_name
      WHEN 'Monday'    THEN 1
      WHEN 'Tuesday'   THEN 2
      WHEN 'Wednesday' THEN 3
      WHEN 'Thursday'  THEN 4
      WHEN 'Friday'    THEN 5
      WHEN 'Saturday'  THEN 6
      WHEN 'Sunday'    THEN 7
    END                                                AS day_sort,

    -- Month sort order
    CASE month_name
      WHEN 'January'   THEN 1
      WHEN 'February'  THEN 2
      WHEN 'March'     THEN 3
      WHEN 'April'     THEN 4
      WHEN 'May'       THEN 5
      WHEN 'June'      THEN 6
      WHEN 'July'      THEN 7
      WHEN 'August'    THEN 8
      WHEN 'September' THEN 9
      WHEN 'October'   THEN 10
      WHEN 'November'  THEN 11
      WHEN 'December'  THEN 12
    END                                                AS month_sort,

    -- Time of day bucket
    CASE
      WHEN watch_time BETWEEN '00:00:00' AND '05:59:59' THEN 'Midnight'
      WHEN watch_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
      WHEN watch_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
      WHEN watch_time BETWEEN '18:00:00' AND '23:59:59' THEN 'Evening'
      ELSE 'Unknown'
    END                                                AS time_of_day,

    -- Screen time bucket
    CASE
      WHEN screen_time BETWEEN '00:00:00' AND '00:30:00' THEN '01. Low Usage'
      WHEN screen_time BETWEEN '00:30:01' AND '00:59:59' THEN '02. Med Usage'
      WHEN screen_time > '00:59:59'                      THEN '03. High Usage'
      ELSE 'Unknown'
    END                                                AS screen_bucket

  FROM viewership_raw
)

-- Final: join viewership to user profiles
SELECT
  -- Viewership fields
  v.UserID,
  v.record_date_sast,
  v.month_id,
  v.month_name,
  v.month_sort,
  v.watch_date,
  v.watch_time,
  v.day_name,
  v.day_sort,
  v.day_of_month,
  v.day_classification,
  v.hour_of_day,
  v.time_of_day,
  v.tv_channel,
  v.screen_time,
  v.screen_time_minutes,
  v.screen_bucket,

  -- User profile fields
  u.region,
  u.age,
  u.age_group,
  u.gender,
  u.race,
  u.email_flag,
  u.social_media_flag

FROM viewership_enriched     AS v
LEFT JOIN user_profiles      AS u
  ON v.UserID = u.UserID;


-- ============================================================================
-- Example dashboard queries built on top of brighttv_clean
-- ============================================================================

-- Top channels by watch time
-- SELECT tv_channel, SUM(screen_time_minutes) AS total_watch_minutes
-- FROM workspace.default.brighttv_clean
-- GROUP BY tv_channel
-- ORDER BY total_watch_minutes DESC
-- LIMIT 10;

-- Sessions by day of week (correctly ordered)
-- SELECT day_name, day_sort, COUNT(*) AS sessions
-- FROM workspace.default.brighttv_clean
-- GROUP BY day_name, day_sort
-- ORDER BY day_sort;

-- Gender breakdown
-- SELECT gender, COUNT(*) AS sessions
-- FROM workspace.default.brighttv_clean
-- GROUP BY gender;
