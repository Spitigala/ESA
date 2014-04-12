require 'sqlite3'
require 'Faker'

def populate_users(people_count)
  db = SQLite3::Database.new "destination_suggester.db"
  people_count.times do
  sql_insert = "INSERT INTO users_db
                  (username,
                   location)
                VALUES
                  ('#{Faker::Name.first_name}',
                   'NYC');"

  db.execute (sql_insert)
  end #times
end #populate_authors



def populate_categories
  db = SQLite3::Database.new "destination_suggester.db"
  category_list = %w[ Bars Clubs Restaurants]
  sql_insert = "INSERT INTO place_categories
                  ( category_name )
                VALUES
                  ( #{rand(4)} );"
  category_list.each do |category|
   db.execute("insert into place_categories(category_name) values ('#{category}');")

sql_create_authors = "CREATE TABLE 'authors' (
                      'id' INTEGER PRIMARY KEY NOT NULL,
                      'first_name' VARCHAR(50),
                      'last_name' VARCHAR(50),
                      'created_at' DATETIME,
                      'updated_at' DATETIME);"

sql_create_books = "CREATE TABLE 'books' (
                    'id' INTEGER PRIMARY KEY NOT NULL,
                    'title' VARCHAR(50),
                    'published_at' DATETIME,
                    'created_at' DATETIME,
                    'updated_at' DATETIME );"

sql_create_authors_books = "CREATE TABLE 'authors_books' (
                            'id' INTEGER PRIMARY KEY NOT NULL,
                            'author_id' INT,
                            'book_id' INT);"


  db = SQLite3::Database.new "books"
  sql_drop_authors = "DROP TABLE IF EXISTS 'authors';"
  sql_drop_books = "DROP TABLE IF EXISTS 'books';"
  sql_drop_authors_books = "DROP TABLE IF EXISTS 'authors_books';"
  db.execute(sql_drop_authors)
  db.execute(sql_drop_books)
  db.execute(sql_drop_authors_books)
  db.execute(sql_create_authors_books)
  db.execute(sql_create_authors)
  db.execute(sql_create_books)
  populate_authors(100)
  populate_books(50)
# "CREATE TABLE `books` (
#   `id` INTEGER NULL DEFAULT NULL,
#   `title` VARCHAR(50) NULL DEFAULT NULL COMMENT '50 characters http://stackoverflow.com/questions/8078939/wha',
#   `published_at` DATETIME NULL DEFAULT NULL,
#   `created_at` DATETIME NULL DEFAULT NULL,
#   `updated_at` DATETIME NULL DEFAULT NULL,
#   PRIMARY KEY (`id`)
# );"
