
-- ============================================================================
-- BookMyShow Database Schema (P1 Solution)
-- ============================================================================
-- This schema implements the complete database design for BookMyShow
-- All tables follow 1NF, 2NF, 3NF, and BCNF normalization rules
-- Database: MySQL 8.0+
-- ============================================================================

CREATE DATABASE IF NOT EXISTS bookmyshow;
USE bookmyshow;

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS ShowDetails;
DROP TABLE IF EXISTS ShowDate;
DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS Format;
DROP TABLE IF EXISTS Language;
DROP TABLE IF EXISTS Screen;
DROP TABLE IF EXISTS Theatre;
DROP TABLE IF EXISTS City;

-- ============================================================================
-- Table 1: City
-- Purpose: Stores cities where theatres operate
-- ============================================================================
CREATE TABLE City (
  city_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for city',
  city_name VARCHAR(100) UNIQUE NOT NULL COMMENT 'Name of the city'
) COMMENT='Stores geographic locations where theatres operate';

-- ============================================================================
-- Table 2: Theatre
-- Purpose: Stores theatre/cinema information
-- Relationships: Belongs to a City
-- ============================================================================
CREATE TABLE Theatre (
  theatre_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for theatre',
  theatre_name VARCHAR(150) NOT NULL COMMENT 'Name of the theatre',
  city_id INT NOT NULL COMMENT 'Reference to City table',
  FOREIGN KEY (city_id) REFERENCES City(city_id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT='Stores theatre/cinema hall information';

-- ============================================================================
-- Table 3: Screen
-- Purpose: Stores screen/auditorium information within theatres
-- Relationships: Belongs to a Theatre
-- ============================================================================
CREATE TABLE Screen (
  screen_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for screen',
  screen_name VARCHAR(50) NOT NULL COMMENT 'Name or number of the screen',
  theatre_id INT NOT NULL COMMENT 'Reference to Theatre table',
  total_seats INT NOT NULL COMMENT 'Total number of seats in the screen',
  FOREIGN KEY (theatre_id) REFERENCES Theatre(theatre_id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT='Stores individual screen/auditorium information within theatres';

-- ============================================================================
-- Table 4: Language
-- Purpose: Stores available movie languages
-- ============================================================================
CREATE TABLE Language (
  language_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for language',
  language_name VARCHAR(50) UNIQUE NOT NULL COMMENT 'Name of the language (e.g., Hindi, English)'
) COMMENT='Stores movie language options';

-- ============================================================================
-- Table 5: Format
-- Purpose: Stores available movie formats
-- ============================================================================
CREATE TABLE Format (
  format_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for format',
  format_name VARCHAR(50) UNIQUE NOT NULL COMMENT 'Format type (e.g., 2D, 3D, IMAX, 4DX)'
) COMMENT='Stores movie format options';

-- ============================================================================
-- Table 6: Movie
-- Purpose: Stores movie information with metadata
-- Relationships: Uses Language and Format tables
-- ============================================================================
CREATE TABLE Movie (
  movie_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for movie',
  movie_name VARCHAR(150) NOT NULL COMMENT 'Name of the movie',
  duration_minutes INT NOT NULL COMMENT 'Duration of the movie in minutes',
  language_id INT NOT NULL COMMENT 'Reference to Language table',
  format_id INT NOT NULL COMMENT 'Reference to Format table',
  FOREIGN KEY (language_id) REFERENCES Language(language_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (format_id) REFERENCES Format(format_id) ON DELETE RESTRICT ON UPDATE CASCADE
) COMMENT='Stores movie information with language and format details';

-- ============================================================================
-- Table 7: ShowDate
-- Purpose: Stores unique dates for which shows are scheduled
-- ============================================================================
CREATE TABLE ShowDate (
  show_date_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for show date',
  show_date DATE UNIQUE NOT NULL COMMENT 'Date of the show (YYYY-MM-DD)'
) COMMENT='Stores unique show dates to avoid duplication';

-- ============================================================================
-- Table 8: ShowDetails
-- Purpose: Junction table representing a specific show instance
-- Relationships: Links Movie, Screen, and ShowDate with show timing
-- ============================================================================
CREATE TABLE ShowDetails (
  show_id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique identifier for show instance',
  movie_id INT NOT NULL COMMENT 'Reference to Movie table',
  screen_id INT NOT NULL COMMENT 'Reference to Screen table',
  show_date_id INT NOT NULL COMMENT 'Reference to ShowDate table',
  show_time TIME NOT NULL COMMENT 'Time the show starts (HH:MM:SS)',
  FOREIGN KEY (movie_id) REFERENCES Movie(movie_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (screen_id) REFERENCES Screen(screen_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (show_date_id) REFERENCES ShowDate(show_date_id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE KEY unique_show (screen_id, show_date_id, show_time) COMMENT 'Ensure no duplicate shows in same screen/date/time'
) COMMENT='Stores specific show instances linking movies to screens with dates and times';

-- ============================================================================
-- Create Indexes for Performance
-- ============================================================================
CREATE INDEX idx_theatre_city ON Theatre(city_id);
CREATE INDEX idx_screen_theatre ON Screen(theatre_id);
CREATE INDEX idx_movie_language ON Movie(language_id);
CREATE INDEX idx_movie_format ON Movie(format_id);
CREATE INDEX idx_showdetails_movie ON ShowDetails(movie_id);
CREATE INDEX idx_showdetails_screen ON ShowDetails(screen_id);
CREATE INDEX idx_showdetails_date ON ShowDetails(show_date_id);
CREATE INDEX idx_showdate ON ShowDate(show_date);

-- ============================================================================
-- Schema Creation Complete
-- All tables follow 1NF, 2NF, 3NF, and BCNF normalization rules
-- ============================================================================
