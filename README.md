
# BookMyShow Database Assignment

## Overview

This project implements a database design for the BookMyShow ticketing platform. It includes complete documentation for database entities, normalization analysis, and executable SQL queries.

## Problem Statement

BookMyShow is a ticketing platform where users can book tickets for movie shows. For a given theatre, users can view shows for the next 7 dates, and upon selecting a date, they see all shows running in that theatre along with show timings.

### P1 - Database Design
Create a database with all entities, attributes, and table structures following normalization rules (1NF, 2NF, 3NF, BCNF).

### P2 - Query Implementation
Write a query to list all shows on a given date at a given theatre with their respective show timings.

## Database Tables

### 1. City
- **city_id** (INT, PK, AUTO_INCREMENT): Unique identifier for city
- **city_name** (VARCHAR(100), UNIQUE): Name of the city

### 2. Theatre
- **theatre_id** (INT, PK, AUTO_INCREMENT): Unique identifier for theatre
- **theatre_name** (VARCHAR(150)): Name of the theatre
- **city_id** (INT, FK): Reference to City table

### 3. Screen
- **screen_id** (INT, PK, AUTO_INCREMENT): Unique identifier for screen
- **screen_name** (VARCHAR(50)): Name of the screen
- **theatre_id** (INT, FK): Reference to Theatre table
- **total_seats** (INT): Total number of seats in the screen

### 4. Language
- **language_id** (INT, PK, AUTO_INCREMENT): Unique identifier for language
- **language_name** (VARCHAR(50), UNIQUE): Name of the language

### 5. Format
- **format_id** (INT, PK, AUTO_INCREMENT): Unique identifier for format
- **format_name** (VARCHAR(50), UNIQUE): Format type (2D, 3D, IMAX, etc.)

### 6. Movie
- **movie_id** (INT, PK, AUTO_INCREMENT): Unique identifier for movie
- **movie_name** (VARCHAR(150)): Name of the movie
- **duration_minutes** (INT): Duration of the movie in minutes
- **language_id** (INT, FK): Reference to Language table
- **format_id** (INT, FK): Reference to Format table

### 7. ShowDate
- **show_date_id** (INT, PK, AUTO_INCREMENT): Unique identifier for show date
- **show_date** (DATE, UNIQUE): Date of the show

### 8. ShowDetails
- **show_id** (INT, PK, AUTO_INCREMENT): Unique identifier for show
- **movie_id** (INT, FK): Reference to Movie table
- **screen_id** (INT, FK): Reference to Screen table
- **show_date_id** (INT, FK): Reference to ShowDate table
- **show_time** (TIME): Time of the show

## Documentation Files

- **docs/entities.md** - Detailed entity definitions and relationships
- **docs/normalization.md** - Normalization analysis following 1NF, 2NF, 3NF, BCNF

## SQL Files

- **sql/schema.sql** - P1 Solution: Table creation SQL with normalization applied
- **sql/sample_data.sql** - Sample data entries for testing
- **sql/queries.sql** - P2 Solution: Query to list shows by theatre and date

## Getting Started

1. Create the database tables using `sql/schema.sql`
2. Insert sample data using `sql/sample_data.sql`
3. Execute queries using `sql/queries.sql`

All SQL queries are MySQL 8.0+ compatible and directly executable.
