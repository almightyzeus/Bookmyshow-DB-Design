
-- ============================================================================
-- BookMyShow Sample Data
-- ============================================================================

CREATE DATABASE IF NOT EXISTS bookmyshow;
USE bookmyshow;
-- ============================================================================
-- Insert Cities
INSERT INTO City (city_name) VALUES ('Pune');
INSERT INTO City (city_name) VALUES ('Mumbai');
INSERT INTO City (city_name) VALUES ('Bangalore');

-- Insert Theatres
INSERT INTO Theatre (theatre_name, city_id) VALUES ('PVR Phoenix', 1);
INSERT INTO Theatre (theatre_name, city_id) VALUES ('Inox Vega', 1);
INSERT INTO Theatre (theatre_name, city_id) VALUES ('PVR Imax', 2);

-- Insert Screens
INSERT INTO Screen (screen_name, theatre_id, total_seats) VALUES ('Screen 1', 1, 180);
INSERT INTO Screen (screen_name, theatre_id, total_seats) VALUES ('Screen 2', 1, 200);
INSERT INTO Screen (screen_name, theatre_id, total_seats) VALUES ('Screen 3', 1, 150);
INSERT INTO Screen (screen_name, theatre_id, total_seats) VALUES ('Screen 1', 2, 220);
INSERT INTO Screen (screen_name, theatre_id, total_seats) VALUES ('Screen 1', 3, 300);

-- Insert Languages
INSERT INTO Language (language_name) VALUES ('Hindi');
INSERT INTO Language (language_name) VALUES ('English');
INSERT INTO Language (language_name) VALUES ('Marathi');
INSERT INTO Language (language_name) VALUES ('Tamil');

-- Insert Formats
INSERT INTO Format (format_name) VALUES ('2D');
INSERT INTO Format (format_name) VALUES ('3D');
INSERT INTO Format (format_name) VALUES ('IMAX');
INSERT INTO Format (format_name) VALUES ('4DX');

-- Insert Movies
INSERT INTO Movie (movie_name, duration_minutes, language_id, format_id) VALUES ('Dunki', 160, 1, 1);
INSERT INTO Movie (movie_name, duration_minutes, language_id, format_id) VALUES ('Avatar: The Way of Water', 192, 2, 3);
INSERT INTO Movie (movie_name, duration_minutes, language_id, format_id) VALUES ('Fighter', 150, 1, 1);
INSERT INTO Movie (movie_name, duration_minutes, language_id, format_id) VALUES ('Oppenheimer', 180, 2, 1);
INSERT INTO Movie (movie_name, duration_minutes, language_id, format_id) VALUES ('Jhimma', 138, 3, 1);

-- Insert Show Dates
INSERT INTO ShowDate (show_date) VALUES ('2026-01-20');
INSERT INTO ShowDate (show_date) VALUES ('2026-01-21');
INSERT INTO ShowDate (show_date) VALUES ('2026-01-22');
INSERT INTO ShowDate (show_date) VALUES ('2026-01-23');
INSERT INTO ShowDate (show_date) VALUES ('2026-01-24');
INSERT INTO ShowDate (show_date) VALUES ('2026-01-25');
INSERT INTO ShowDate (show_date) VALUES ('2026-01-26');

-- Insert ShowDetails (Shows at PVR Phoenix for 2026-01-20)
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (1, 1, 1, '09:30:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (1, 1, 1, '12:30:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (1, 1, 1, '15:30:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (1, 1, 1, '18:30:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (1, 1, 1, '21:30:00');

-- Insert ShowDetails (Different movie, same date, different screen)
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (2, 2, 1, '10:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (2, 2, 1, '13:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (2, 2, 1, '16:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (2, 2, 1, '19:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (2, 2, 1, '22:00:00');

-- Insert ShowDetails (Another movie on same date)
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (3, 3, 1, '11:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (3, 3, 1, '14:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (3, 3, 1, '17:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (3, 3, 1, '20:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (3, 3, 1, '23:00:00');

-- Insert ShowDetails for 2026-01-21
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (1, 1, 2, '09:30:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (1, 1, 2, '18:30:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (4, 2, 2, '10:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (4, 2, 2, '19:00:00');

-- Insert ShowDetails for Inox Vega theatre
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (5, 4, 1, '09:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (5, 4, 1, '12:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (5, 4, 1, '15:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (5, 4, 1, '18:00:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (2, 4, 1, '20:30:00');

-- Insert ShowDetails for PVR Imax theatre
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (2, 5, 1, '10:30:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (2, 5, 1, '13:30:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (2, 5, 1, '16:30:00');
INSERT INTO ShowDetails (movie_id, screen_id, show_date_id, show_time) VALUES (2, 5, 1, '19:30:00');
