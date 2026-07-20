# 🎬 IMDb SQL Dataset

A structured SQL database containing IMDb movie-related information for practicing SQL queries, database design, data analysis, and relational database concepts.

## 📌 Overview

This project contains an SQL script that creates and populates a simplified version of the IMDb database. It is ideal for learning SQL fundamentals, database management, joins, aggregations, subqueries, and analytical queries.

The script automatically:

- Creates the database
- Creates all required tables
- Defines primary keys
- Inserts movie-related data into the tables

---

## 📂 Dataset File

```
IMDBdatasetimport.sql
```

---

## 🗃 Database Schema

The database contains the following tables:

| Table | Description |
|--------|-------------|
| **movie** | Movie information including title, release year, duration, language, country, and production company. |
| **genre** | Movie genres (Action, Drama, Comedy, etc.). |
| **director_mapping** | Maps movies to their directors. |
| **role_mapping** | Maps movies to actors, actresses, and other roles. |
| **names** | Information about people such as actors, actresses, and directors. |
| **ratings** | IMDb ratings, votes, and median ratings of movies. |

---

## 📊 Table Relationships

```
movie
 │
 ├──────── genre
 │
 ├──────── ratings
 │
 ├──────── director_mapping ───── names
 │
 └──────── role_mapping ───────── names
```

---

## 🧾 Main Columns

### Movie

- Movie ID
- Title
- Release Year
- Published Date
- Duration
- Country
- Worldwide Gross Income
- Languages
- Production Company

### Ratings

- Average Rating
- Total Votes
- Median Rating

### Names

- Person ID
- Name
- Height
- Date of Birth
- Known For Movies

### Genre

- Movie ID
- Genre

### Director Mapping

- Movie ID
- Director ID

### Role Mapping

- Movie ID
- Person ID
- Category

---

## 🚀 How to Use

### 1. Install MySQL

Download and install MySQL Server and MySQL Workbench.

### 2. Open the SQL File

Open

```
IMDBdatasetimport.sql
```

in MySQL Workbench.

### 3. Execute the Script

Run the complete SQL script.

The script will:

- Drop the existing database (if present)
- Create a new database named:

```
imdb
```

- Create all tables
- Import the dataset

---

## 📚 Skills You Can Practice

- SELECT statements
- WHERE clause
- ORDER BY
- GROUP BY
- HAVING
- Aggregate Functions
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- SELF JOIN
- CROSS JOIN
- Nested Queries
- Correlated Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- String Functions
- Date Functions
- Case Statements
- Views
- Indexes

---

## 📈 Example SQL Questions

- Find the highest-rated movies.
- List movies released after 2018.
- Find movies belonging to multiple genres.
- Count movies produced by each production company.
- Find directors with the highest average movie rating.
- Find actors who have appeared in the most movies.
- List movies with more than 10,000 votes.
- Find movies released in a particular country.
- Rank movies based on ratings.
- Find the average movie duration by genre.

---

## 💻 Technologies Used

- SQL
- MySQL
- MySQL Workbench

---

## 🎯 Learning Objectives

This dataset helps learners understand:

- Relational database concepts
- Primary keys
- Database normalization
- Table relationships
- SQL query writing
- Data aggregation
- Data filtering
- Database joins
- Analytical SQL queries

---

## 📖 Use Cases

- SQL Practice
- Database Assignments
- Data Analysis Projects
- SQL Interview Preparation
- College Mini Projects
- Learning Relational Databases

---

## 🤝 Contributing

Contributions are welcome!

You can contribute by:

- Adding advanced SQL queries
- Optimizing database schema
- Improving documentation
- Reporting issues

---

## 📄 License

This dataset is intended for educational and learning purposes.

---

## ⭐ If you found this repository useful

Please consider giving it a ⭐ on GitHub to support the project.
