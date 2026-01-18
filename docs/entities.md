
# Entities and Relationships

## Entity Definitions

### 1. City
Represents a geographic location where theatres operate.

**Attributes:**
- `city_id` (INT, Primary Key, Auto Increment): Unique identifier
- `city_name` (VARCHAR(100), UNIQUE): Name of the city

**Purpose:** Allows filtering of theatres by location

**Example Data:**
| city_id | city_name |
|---------|-----------|
| 1 | Pune |
| 2 | Mumbai |
| 3 | Bangalore |

---

### 2. Theatre
Represents a movie theatre/cinema hall in a city.

**Attributes:**
- `theatre_id` (INT, Primary Key, Auto Increment): Unique identifier
- `theatre_name` (VARCHAR(150)): Name of the theatre
- `city_id` (INT, Foreign Key): References City table

**Purpose:** Stores theatre information and links to cities

**Example Data:**
| theatre_id | theatre_name | city_id |
|------------|--------------|---------|
| 1 | PVR Phoenix | 1 |
| 2 | Inox Vega | 1 |
| 3 | PVR Imax | 2 |

---

### 3. Screen
Represents an individual cinema screen within a theatre.

**Attributes:**
- `screen_id` (INT, Primary Key, Auto Increment): Unique identifier
- `screen_name` (VARCHAR(50)): Name/number of the screen
- `theatre_id` (INT, Foreign Key): References Theatre table
- `total_seats` (INT): Total number of seats in the screen

**Purpose:** Stores screen information for each theatre

**Example Data:**
| screen_id | screen_name | theatre_id | total_seats |
|-----------|-------------|-----------|------------|
| 1 | Screen 1 | 1 | 180 |
| 2 | Screen 2 | 1 | 200 |
| 3 | Screen 1 | 2 | 150 |

---

### 4. Language
Represents movie languages available.

**Attributes:**
- `language_id` (INT, Primary Key, Auto Increment): Unique identifier
- `language_name` (VARCHAR(50), UNIQUE): Name of the language

**Purpose:** Enables filtering shows by language preference

**Example Data:**
| language_id | language_name |
|------------|---------------|
| 1 | Hindi |
| 2 | English |
| 3 | Marathi |
| 4 | Tamil |

---

### 5. Format
Represents different movie formats available.

**Attributes:**
- `format_id` (INT, Primary Key, Auto Increment): Unique identifier
- `format_name` (VARCHAR(50), UNIQUE): Format type

**Purpose:** Enables filtering shows by format preference

**Example Data:**
| format_id | format_name |
|-----------|-------------|
| 1 | 2D |
| 2 | 3D |
| 3 | IMAX |
| 4 | 4DX |

---

### 6. Movie
Represents a movie with its properties.

**Attributes:**
- `movie_id` (INT, Primary Key, Auto Increment): Unique identifier
- `movie_name` (VARCHAR(150)): Name of the movie
- `duration_minutes` (INT): Duration in minutes
- `language_id` (INT, Foreign Key): References Language table
- `format_id` (INT, Foreign Key): References Format table

**Purpose:** Stores movie details and metadata

**Example Data:**
| movie_id | movie_name | duration_minutes | language_id | format_id |
|----------|------------|-----------------|------------|-----------|
| 1 | Dunki | 160 | 1 | 1 |
| 2 | Avatar | 192 | 2 | 3 |
| 3 | Fighter | 150 | 1 | 1 |

---

### 7. ShowDate
Represents dates on which shows can occur.

**Attributes:**
- `show_date_id` (INT, Primary Key, Auto Increment): Unique identifier
- `show_date` (DATE, UNIQUE): Date of the show

**Purpose:** Stores show dates to avoid date duplication

**Example Data:**
| show_date_id | show_date |
|------------|-----------|
| 1 | 2026-01-20 |
| 2 | 2026-01-21 |
| 3 | 2026-01-22 |

---

### 8. ShowDetails
Represents a specific show instance (movie at a specific time in a specific screen on a specific date).

**Attributes:**
- `show_id` (INT, Primary Key, Auto Increment): Unique identifier
- `movie_id` (INT, Foreign Key): References Movie table
- `screen_id` (INT, Foreign Key): References Screen table
- `show_date_id` (INT, Foreign Key): References ShowDate table
- `show_time` (TIME): Time the show starts

**Purpose:** Links movies to screens, dates, and times to create show instances

**Example Data:**
| show_id | movie_id | screen_id | show_date_id | show_time |
|---------|----------|-----------|-------------|-----------|
| 1 | 1 | 1 | 1 | 18:30:00 |
| 2 | 1 | 1 | 1 | 21:30:00 |
| 3 | 2 | 2 | 1 | 19:00:00 |

---

## Relationships

```
City (1) ──────── (M) Theatre
              │
              │
Theatre (1) ──────── (M) Screen
              │
              │
Screen (1) ──────── (M) ShowDetails
              │
Movie (1) ──────── (M) ShowDetails
              │
Language (1) ──────── (M) Movie
              │
Format (1) ──────── (M) Movie
              │
ShowDate (1) ──────── (M) ShowDetails
```

- One City can have multiple Theatres
- One Theatre can have multiple Screens
- One Screen can have multiple ShowDetails
- One Movie can be shown in multiple ShowDetails
- One Language can be used by multiple Movies
- One Format can be used by multiple Movies
- One ShowDate can have multiple ShowDetails
