-- ============================================================================
-- BrightTV Viewership Analytics — Exploratory SQL Queries
-- Author: Charlotte Turya
-- Purpose: Initial data exploration queries used to understand the dataset
--          before building the final clean view (see brighttv_clean_view.sql)
-- Platform: Databricks SQL
-- ============================================================================

-- Checking tv_viewership dataset to understand the data
SELECT * FROM workspace.default.bright_tv_viewership LIMIT 10;

-- Checking size of dataset using coalesce to predict the UserID
SELECT
  COUNT(*) AS number_of_rows,
  COUNT(DISTINCT COALESCE(UserID0, userid4)) AS number_of_viewers
FROM workspace.default.bright_tv_viewership;
-- Result: 4,386 distinct viewers in the dataset, in 10,000 rows

-- Checking duplicate viewership records
SELECT
  COALESCE(UserID0, userid4) AS user_id,
  Channel2,
  RecordDate2,
  COUNT(*) AS record_count
FROM workspace.default.bright_tv_viewership
GROUP BY COALESCE(UserID0, userid4), Channel2, RecordDate2
HAVING COUNT(*) > 1;
-- Result: 7 duplicate records found

-- Check missing values
SELECT
  COUNT(*) AS total_rows,
  COUNT(COALESCE(UserID0, userid4)) AS user_count,
  COUNT(Channel2) AS channel_count,
  COUNT(RecordDate2) AS date_count
FROM workspace.default.bright_tv_viewership;
-- Result: No missing values

-- Checking active subscriptions vs active users
SELECT
  COUNT(*) AS num_rows,
  COUNT(COALESCE(UserID0, userid4)) AS active_subs,
  COUNT(DISTINCT COALESCE(UserID0, userid4)) AS active_users
FROM workspace.default.bright_tv_viewership;

-- Checking number of channels (after standardisation)
SELECT DISTINCT
  CASE
    WHEN Channel2 IN ('SawSee', 'Sawsee') THEN 'SawSee'
    WHEN Channel2 IN (
      'SuperSport Live Events', 'Supersport Live Events',
      'DSTV Events 1', 'Live on SuperSport', 'Live Events'
    ) THEN 'Live Events'
    ELSE Channel2
  END AS TV_Channel
FROM workspace.default.bright_tv_viewership;
-- Result: 18 distinct channels after standardisation

-- Understand date range
SELECT
  MIN(RecordDate2) AS first_session,
  MAX(RecordDate2) AS last_session
FROM workspace.default.bright_tv_viewership;

-- Check UTC → South Africa Time conversion
SELECT
  RecordDate2,
  RecordDate2 + INTERVAL 2 HOURS AS sast_time
FROM workspace.default.bright_tv_viewership
LIMIT 10;

-- Find top content (by raw session count)
SELECT
  Channel2,
  COUNT(*) AS views
FROM workspace.default.bright_tv_viewership
GROUP BY Channel2
ORDER BY views DESC
LIMIT 10;
-- Result: SuperSport Live Events leads (1,638), followed by ICC Cricket
-- World Cup 2011 (1,465), then Channel O (1,051)

-- Check viewing by day
SELECT
  DAYNAME(RecordDate2) AS weekday,
  COUNT(*) AS sessions
FROM workspace.default.bright_tv_viewership
GROUP BY weekday
ORDER BY sessions DESC;
-- Result: Saturday has the highest session count in the week

-- Total viewer consumption
SELECT
  SUM(HOUR(`Duration 2`) + MINUTE(`Duration 2`) / 60.0 + SECOND(`Duration 2`) / 3600.0) AS total_watch_time_hours,
  SUM(HOUR(`Duration 2`) * 60 + MINUTE(`Duration 2`) + SECOND(`Duration 2`) / 60.0)     AS total_watch_time_minutes,
  SUM(HOUR(`Duration 2`) * 3600 + MINUTE(`Duration 2`) * 60 + SECOND(`Duration 2`))     AS total_watch_time_seconds
FROM workspace.default.bright_tv_viewership;

-- Average session length
SELECT
  AVG(HOUR(`Duration 2`) * 60 + MINUTE(`Duration 2`) + SECOND(`Duration 2`) / 60.0) AS avg_session_minutes
FROM workspace.default.bright_tv_viewership;

-- Average sessions per user
SELECT
  AVG(session_count) AS avg_sessions_per_user
FROM (
  SELECT
    COALESCE(UserID0, userid4) AS UserID,
    COUNT(*) AS session_count
  FROM workspace.default.bright_tv_viewership
  GROUP BY COALESCE(UserID0, userid4)
) t;
-- Result: 2.28 sessions per user on average

-- Consumption by day of the week (with SAST conversion applied)
SELECT
  DAYNAME(RecordDate2 + INTERVAL 2 HOURS) AS day_name,
  COUNT(*) AS sessions
FROM workspace.default.bright_tv_viewership
GROUP BY day_name
ORDER BY sessions DESC;
-- Result: Friday has the most sessions once converted to SAST
