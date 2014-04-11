require 'faker'
require 'sqlite3'


`rm suggest.db`

model = SQLite3::Database.new "destination_suggester.db"
model.execute("PRAGMA foreign_keys = ON;")

rows = model.execute <<-SQL
  CREATE TABLE users (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     username VARCHAR(30),
     location VARCHAR(30)
    );
SQL

model.execute <<-SQL
  CREATE TABLE ratings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    place_id INTEGER,
    user_id INTEGER,
    visited_on TIMESTAMP,
    rating INTEGER(2) NOT NULL,
    FOREIGN KEY(place_id) REFERENCES places(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
    );
SQL

model.execute <<-SQL
  CREATE TABLE visits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    place_id INTEGER,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(place_id) REFERENCES places(id)
    );
SQL

model.execute <<-SQL
  CREATE TABLE places (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30),
    address VARCHAR(30),
    category_id INTEGER,
    FOREIGN KEY(category_id) REFERENCES categories(id)
    );
SQL

model.execute <<-SQL
  CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_name VARCHAR(30)
    );
SQL
