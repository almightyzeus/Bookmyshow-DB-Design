
# Database Normalization Analysis

This document explains how each table in the BookMyShow database design follows normalization rules: 1NF, 2NF, 3NF, and BCNF.

---

## Overview of Normalization Rules

### 1NF (First Normal Form)
- All attributes contain atomic (indivisible) values
- No repeating groups or arrays
- Each row is unique

### 2NF (Second Normal Form)
- Must satisfy 1NF
- All non-key attributes are fully functionally dependent on the entire primary key
- Remove partial dependencies

### 3NF (Third Normal Form)
- Must satisfy 2NF
- No transitive dependencies (non-key attributes should not depend on other non-key attributes)

### BCNF (Boyce-Codd Normal Form)
- Must satisfy 3NF
- For every functional dependency X → Y, X must be a candidate key
- Stricter than 3NF

---

## Table Analysis

### 1. City Table

```sql
CREATE TABLE City (
  city_id INT AUTO_INCREMENT PRIMARY KEY,
  city_name VARCHAR(100) UNIQUE
);
```

**Normalization Status: BCNF ✓**

- **1NF:** ✓ Both attributes are atomic. city_id and city_name contain single, indivisible values.
- **2NF:** ✓ Only one non-key attribute (city_name). No partial dependencies possible.
- **3NF:** ✓ No transitive dependencies. city_name depends only on city_id (primary key).
- **BCNF:** ✓ All functional dependencies: city_id → city_name where city_id is a candidate key.

---

### 2. Theatre Table

```sql
CREATE TABLE Theatre (
  theatre_id INT AUTO_INCREMENT PRIMARY KEY,
  theatre_name VARCHAR(150),
  city_id INT,
  FOREIGN KEY (city_id) REFERENCES City(city_id)
);
```

**Normalization Status: BCNF ✓**

- **1NF:** ✓ All attributes are atomic (theatre_id, theatre_name, city_id are all single values).
- **2NF:** ✓ theatre_name and city_id both depend on the full primary key (theatre_id).
- **3NF:** ✓ No transitive dependencies. theatre_name and city_id depend only on theatre_id.
- **BCNF:** ✓ All functional dependencies respect candidate keys. theatre_id → theatre_name, theatre_id → city_id.

---

### 3. Screen Table

```sql
CREATE TABLE Screen (
  screen_id INT AUTO_INCREMENT PRIMARY KEY,
  screen_name VARCHAR(50),
  theatre_id INT,
  total_seats INT,
  FOREIGN KEY (theatre_id) REFERENCES Theatre(theatre_id)
);
```

**Normalization Status: BCNF ✓**

- **1NF:** ✓ All attributes are atomic (screen_id, screen_name, theatre_id, total_seats are single values).
- **2NF:** ✓ All non-key attributes depend on the full primary key (screen_id).
- **3NF:** ✓ No transitive dependencies. screen_name, theatre_id, total_seats depend only on screen_id, not on each other.
- **BCNF:** ✓ All functional dependencies: screen_id → screen_name, screen_id → theatre_id, screen_id → total_seats.

---

### 4. Language Table

```sql
CREATE TABLE Language (
  language_id INT AUTO_INCREMENT PRIMARY KEY,
  language_name VARCHAR(50) UNIQUE
);
```

**Normalization Status: BCNF ✓**

- **1NF:** ✓ Both attributes are atomic (language_id and language_name are single values).
- **2NF:** ✓ Only one non-key attribute. No partial dependencies.
- **3NF:** ✓ No transitive dependencies. language_name depends only on language_id.
- **BCNF:** ✓ All functional dependencies: language_id → language_name where language_id is a candidate key.

---

### 5. Format Table

```sql
CREATE TABLE Format (
  format_id INT AUTO_INCREMENT PRIMARY KEY,
  format_name VARCHAR(50) UNIQUE
);
```

**Normalization Status: BCNF ✓**

- **1NF:** ✓ Both attributes are atomic (format_id and format_name are single values).
- **2NF:** ✓ Only one non-key attribute. No partial dependencies.
- **3NF:** ✓ No transitive dependencies. format_name depends only on format_id.
- **BCNF:** ✓ All functional dependencies: format_id → format_name where format_id is a candidate key.

---

### 6. Movie Table

```sql
CREATE TABLE Movie (
  movie_id INT AUTO_INCREMENT PRIMARY KEY,
  movie_name VARCHAR(150),
  duration_minutes INT,
  language_id INT,
  format_id INT,
  FOREIGN KEY (language_id) REFERENCES Language(language_id),
  FOREIGN KEY (format_id) REFERENCES Format(format_id)
);
```

**Normalization Status: BCNF ✓**

- **1NF:** ✓ All attributes are atomic (movie_id, movie_name, duration_minutes, language_id, format_id are all single values).
- **2NF:** ✓ All non-key attributes depend on the full primary key (movie_id). No partial dependencies.
- **3NF:** ✓ No transitive dependencies. movie_name, duration_minutes, language_id, format_id depend only on movie_id, not on each other.
  - While language_id and format_id are foreign keys, they are stored as identifiers, not their dependent values.
- **BCNF:** ✓ All functional dependencies: movie_id → movie_name, movie_id → duration_minutes, movie_id → language_id, movie_id → format_id.

---

### 7. ShowDate Table

```sql
CREATE TABLE ShowDate (
  show_date_id INT AUTO_INCREMENT PRIMARY KEY,
  show_date DATE UNIQUE
);
```

**Normalization Status: BCNF ✓**

- **1NF:** ✓ Both attributes are atomic (show_date_id and show_date are single values).
- **2NF:** ✓ Only one non-key attribute. No partial dependencies.
- **3NF:** ✓ No transitive dependencies. show_date depends only on show_date_id.
- **BCNF:** ✓ All functional dependencies: show_date_id → show_date where show_date_id is a candidate key.

**Design Note:** ShowDate was created as a separate table to normalize dates and avoid duplication across multiple show instances.

---

### 8. ShowDetails Table

```sql
CREATE TABLE ShowDetails (
  show_id INT AUTO_INCREMENT PRIMARY KEY,
  movie_id INT,
  screen_id INT,
  show_date_id INT,
  show_time TIME,
  FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
  FOREIGN KEY (screen_id) REFERENCES Screen(screen_id),
  FOREIGN KEY (show_date_id) REFERENCES ShowDate(show_date_id)
);
```

**Normalization Status: BCNF ✓**

- **1NF:** ✓ All attributes are atomic (show_id, movie_id, screen_id, show_date_id, show_time are all single values).
- **2NF:** ✓ All non-key attributes depend on the full primary key (show_id). No partial dependencies.
- **3NF:** ✓ No transitive dependencies. movie_id, screen_id, show_date_id, show_time depend only on show_id, not on each other.
  - Foreign key references do not create transitive dependencies as they are identifiers only.
- **BCNF:** ✓ All functional dependencies: show_id → movie_id, show_id → screen_id, show_id → show_date_id, show_id → show_time.

**Design Note:** This is a junction table that represents the composite entity "Show" linking Movie, Screen, ShowDate, and show_time.

---

## Summary

| Table | 1NF | 2NF | 3NF | BCNF |
|-------|-----|-----|-----|------|
| City | ✓ | ✓ | ✓ | ✓ |
| Theatre | ✓ | ✓ | ✓ | ✓ |
| Screen | ✓ | ✓ | ✓ | ✓ |
| Language | ✓ | ✓ | ✓ | ✓ |
| Format | ✓ | ✓ | ✓ | ✓ |
| Movie | ✓ | ✓ | ✓ | ✓ |
| ShowDate | ✓ | ✓ | ✓ | ✓ |
| ShowDetails | ✓ | ✓ | ✓ | ✓ |

**All tables achieve BCNF normalization, which is the highest level of database normalization.**

---

## Key Design Principles Applied

1. **Atomicity:** Each attribute contains only indivisible values.
2. **Foreign Keys:** Used to maintain referential integrity and establish relationships.
3. **Unique Constraints:** Applied to prevent duplicate entries (city_name, language_name, format_name, show_date).
4. **Primary Keys:** Auto-increment integers for efficient indexing and relationships.
5. **Separation of Concerns:** Related data is separated into distinct tables (e.g., Movie metadata from Show scheduling).
6. **Avoid Redundancy:** Dates, languages, and formats are stored once and referenced multiple times.
7. **Data Integrity:** Foreign key constraints ensure referential integrity across all relationships.
