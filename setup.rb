require 'faker'
require 'sqlite3'


`rm destination_suggester.db`

model = SQLite3::Database.new "destination_suggester.db"

rows = model.execute <<-SQL
  CREATE TABLE users (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     username VARCHAR(30),
     location VARCHAR(30)
    );
SQL

model.execute <<-SQL
  CREATE TABLE visit_ratings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    place_id INTEGER,
    user_id INTEGER,
    visited_on TIMESTAMP,
    rating INTEGER(2) NOT NULL
    );
SQL

model.execute <<-SQL
  CREATE TABLE places_to_visit (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    place_id INTEGER
    );
SQL

model.execute <<-SQL
  CREATE TABLE places (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30),
    address VARCHAR(30),
    category_id INTEGER
    );
SQL

model.execute <<-SQL
  CREATE TABLE place_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name VARCHAR(30)
    );
SQL
