
-- ============================================================================
-- BookMyShow Database Queries
-- ============================================================================

-- P1: TABLE CREATION (See schema.sql for complete table definitions)
-- All tables are created with proper normalization (1NF, 2NF, 3NF, BCNF)
-- Refer to schema.sql for the complete P1 solution

-- ============================================================================
-- P2: Query to list all shows on a given date at a given theatre 
--     along with their respective show timings
-- ============================================================================

-- This query fulfills the P2 requirement:
-- "Write a query to list down all the shows on a given date at a given theatre 
--  along with their respective show timings."
--
-- TWO APPROACHES PROVIDED BELOW:
-- 1. VERSION 1 (RAW DATA FORMAT) - Returns one row per show
--    Use for: Data APIs, reports, analysis tools
-- 2. VERSION 2 (UI-OPTIMIZED FORMAT) - Groups shows by movie
--    Use for: Mobile/web UI rendering, user-facing applications

-- ============================================================================
-- P2 VERSION 1: RAW DATA FORMAT (One Row Per Show)
-- ============================================================================
-- Returns individual show listings with all attributes
-- Best for: APIs, databases, general purpose data retrieval
-- Format: Each show appears as a separate row with complete details

SELECT 
  m.movie_name,
  lang.language_name,
  fmt.format_name,
  sc.screen_name,
  TIME_FORMAT(s.show_time, '%h:%i %p') AS 'Show Time',
  t.theatre_name,
  sd.show_date,
  m.duration_minutes
FROM ShowDetails s
JOIN Movie m ON s.movie_id = m.movie_id
JOIN Language lang ON m.language_id = lang.language_id
JOIN Format fmt ON m.format_id = fmt.format_id
JOIN Screen sc ON s.screen_id = sc.screen_id
JOIN Theatre t ON sc.theatre_id = t.theatre_id
JOIN ShowDate sd ON s.show_date_id = sd.show_date_id
WHERE t.theatre_name = 'PVR Phoenix'
  AND sd.show_date = '2026-01-20'
ORDER BY m.movie_name, s.show_time ASC;

-- ============================================================================
-- P2 VERSION 2: UI-OPTIMIZED FORMAT (Grouped by Movie)
-- ============================================================================
-- Returns movies grouped with all show timings aggregated together
-- Best for: Mobile/web UI, user interfaces, client applications
-- Format: Matches BookMyShow UI layout - one movie row with multiple timings
-- Example output: Dunki | 1:20 PM IST, 4:00 PM IST, 7:00 PM IST | Hindi - 2D

SELECT 
  m.movie_name AS 'Movie Name',
  GROUP_CONCAT(
    CONCAT(TIME_FORMAT(s.show_time, '%h:%i %p'), ' IST') 
    SEPARATOR ', '
  ) AS 'Show Timings',
  CONCAT(lang.language_name, ' - ', fmt.format_name) AS 'Language & Format',
  m.duration_minutes AS 'Duration (min)',
  COUNT(s.show_id) AS 'Total Shows'
FROM ShowDetails s
JOIN Movie m ON s.movie_id = m.movie_id
JOIN Screen sc ON s.screen_id = sc.screen_id
JOIN Theatre t ON sc.theatre_id = t.theatre_id
JOIN ShowDate sd ON s.show_date_id = sd.show_date_id
JOIN Language lang ON m.language_id = lang.language_id
JOIN Format fmt ON m.format_id = fmt.format_id
WHERE t.theatre_name = 'PVR Phoenix'
  AND sd.show_date = '2026-01-20'
GROUP BY m.movie_id, m.movie_name, lang.language_id, fmt.format_id, m.duration_minutes
ORDER BY MIN(s.show_time) ASC;

-- ============================================================================
-- PARAMETERIZED P2 QUERY
-- ============================================================================
-- Use these parameter placeholders for dynamic queries in your application:
-- Replace @theatre_name with actual theatre name
-- Replace @show_date with actual date (YYYY-MM-DD format)

-- SELECT 
--   m.movie_name AS 'Movie Name',
--   s.show_time AS 'Show Time',
--   sc.screen_name AS 'Screen Name',
--   t.theatre_name AS 'Theatre Name',
--   sd.show_date AS 'Show Date',
--   CONCAT(lang.language_name, ' - ', fmt.format_name) AS 'Language & Format',
--   m.duration_minutes AS 'Duration (min)'
-- FROM ShowDetails s
-- JOIN Movie m ON s.movie_id = m.movie_id
-- JOIN Screen sc ON s.screen_id = sc.screen_id
-- JOIN Theatre t ON sc.theatre_id = t.theatre_id
-- JOIN ShowDate sd ON s.show_date_id = sd.show_date_id
-- JOIN Language lang ON m.language_id = lang.language_id
-- JOIN Format fmt ON m.format_id = fmt.format_id
-- WHERE t.theatre_name = @theatre_name
--   AND sd.show_date = @show_date
-- ORDER BY s.show_time ASC;

-- ============================================================================
-- ADDITIONAL USEFUL QUERIES
-- ============================================================================

-- Query 1: List all theatres in a city
-- SELECT t.theatre_name, c.city_name
-- FROM Theatre t
-- JOIN City c ON t.city_id = c.city_id
-- WHERE c.city_name = 'Pune'
-- ORDER BY t.theatre_name;

-- Query 2: Get upcoming shows in next 7 days for a theatre
-- SELECT 
--   m.movie_name,
--   s.show_time,
--   sc.screen_name,
--   sd.show_date
-- FROM ShowDetails s
-- JOIN Movie m ON s.movie_id = m.movie_id
-- JOIN Screen sc ON s.screen_id = sc.screen_id
-- JOIN ShowDate sd ON s.show_date_id = sd.show_date_id
-- JOIN Theatre t ON sc.theatre_id = t.theatre_id
-- WHERE t.theatre_name = 'PVR Phoenix'
--   AND sd.show_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
-- ORDER BY sd.show_date, s.show_time;

-- Query 3: Count shows per movie on a specific date
-- SELECT 
--   m.movie_name,
--   COUNT(s.show_id) AS 'Total Shows',
--   t.theatre_name,
--   sd.show_date
-- FROM ShowDetails s
-- JOIN Movie m ON s.movie_id = m.movie_id
-- JOIN Theatre t ON (SELECT theatre_id FROM Screen WHERE screen_id = s.screen_id) = t.theatre_id
-- JOIN ShowDate sd ON s.show_date_id = sd.show_date_id
-- WHERE t.theatre_name = 'PVR Phoenix' AND sd.show_date = '2026-01-20'
-- GROUP BY m.movie_id, m.movie_name, t.theatre_id, t.theatre_name, sd.show_date;
