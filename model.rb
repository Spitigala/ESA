#'setup.rb'

require 'sqlite3'

$db = SQLite3::Database.open "suggest.db"


class Users
  def initialize
  end

  def self.display_table
    puts "Users:"
    $db.execute( "select * from users" ) do |row|
    p row
    end
  end

  def self.add_user(args)
    add_user_prepared = $db.prepare("INSERT INTO users (username, location)
                                     VALUES(:username,:location)")
    add_user_prepared.execute(args)
  end

  def self.get_user(args)
    user_to_return = {}
    check_user = $db.prepare("SELECT username, location
                               FROM users
                               WHERE username = :username")
    match = check_user.execute(args)
    match.to_a.each { | username, location | user_to_return = { username: username, location: location}}
    user_to_return
  end

  def self.delete_user(args)
    delete = $db.prepare("DELETE FROM users
                          WHERE username = :username")
    delete.execute(args)
  end

  def self.update_user(args)
    #### WE CANNOT UPDATE A USER NAME UNLESS THE USER NAME IS UNIQUE
    #### ***************************************************************
    #### That's not the model's job. Check else where with Users.get_user(:username)
    #### ***************************************************************

    update = $db.prepare("UPDATE users
                          SET username = :new_username,
                          location= :new_location,
                          WHERE username = :username")
    update.execute(args)
  end
end

class Visited_places
  def self.display_books_published_at#(publisher)
    #@first_name = publisher
    $db.execute(
    "SELECT books.id, publishers.id, publishers.first_name
    FROM books
    INNER JOIN publishers
    ON books.publisher_id=publishers.id")
  end

end

class Places
end

class Catagories
end

class Ratings
end



class Database
  def self.display_all_tables
    puts "Authors:"
    $db.execute( "select * from authors" ) do |row|
       p row
    end
    puts "-----------"
    puts "Books:"
    $db.execute( "select * from books" ) do |row|
       p row
    end
    puts "---------------"
    puts "Publishers:"
    $db.execute( "select * from publishers" ) do |row|
       p row
    end
    puts "---------------"
    puts "Books and Authors"
    $db.execute( "select * from authors_books" ) do |row|
       p row
    end
  end
end

Users.add_user(username: "Johnathan", location:"DBCNYC")
p Users.get_user(username: "Johnathan")
Users.delete_user(username: "Johnathan")
p Users.get_user(username: "Johnathan")
