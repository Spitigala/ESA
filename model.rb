#'setup.rb'

require 'sqlite3'

$db = SQLite3::Database.open "suggest.db"


class Users

  def self.display_table
    puts "Users:"
    $db.execute( "select * from users" ) do |row|
    p row
    end
  end

  def self.add_user(args)
    add_user_prepared = $db.prepare("INSERT INTO users (id, username, location)
                                     VALUES(:id, :username,:location)")
    add_user_prepared.execute(args)
  end

  def self.get_user(args)
    user_to_return = {}
    check_user = $db.prepare("SELECT id, username, location
                               FROM users
                               WHERE username = :username")
    match = check_user.execute(args)
    match.to_a.each { | id, username, location | user_to_return = { id: id, username: username, location: location}}
    user_to_return
  end

  def self.delete_user(args)
    delete = $db.prepare("DELETE FROM users
                          WHERE username = :username")
    delete.execute(args)
  end

  def self.update_user(args)
    update = $db.prepare("UPDATE users
                          SET username = :new_username,
                          location= :new_location,
                          WHERE username = :username")
    update.execute(args)
  end
end

class PlacesToVisit
  def self.display_books_published_at#(publisher)
    #@first_name = publisher
    $db.execute(
    "SELECT books.id, publishers.id, publishers.first_name
    FROM books
    INNER JOIN publishers
    ON books.publisher_id=publishers.id")
  end

end

# SQL statements we need:
# return/show all restaurants that a user wants to go to (added to "places to go")
# return/show all restaurants that a user has been to
# return/show all restaurants (regardless of status) of a user


class Places
  def self.display_table
    puts "Places:"
    $db.execute( "select * from users" ) do |row|
    p row
    end
  end

  def self.add_place(args)
    add_place_prepared = $db.prepare( "INSERT INTO places ( id, name, address, catagory_id)
                                       VALUES(:id, :name, :address, :catagory_id )")
    add_place_prepared.execute(args)
  end

  # def self.get_place(args)
  #   place_to_return = {}
  #   check_place = $db.prepare( "SELECT id, name, address
  #                               FROM places
  #                               WHERE name = :username
  #                               OR")
  #   match = check_user.execute(args)
  #   match.to_a.each { | id, username, location | user_to_return = { id: id, username: username, location: location}}
  #   user_to_return
  # end

  def self.delete_place(args)
    delete = $db.prepare("DELETE FROM places
                          WHERE name = :name")
    delete.execute(args)
  end

  def self.update_place(args)
    update = $db.prepare("UPDATE places
                          SET name = :name,
                          address = :address,
                          WHERE name = :new_name 
                          AND address = :address")
    update.execute(args)
  end

end

class PlaceCategories
  def self.display_table
    puts "PlaceCatagories:"
    $db.execute( "select * from place_categories" ) do |row|
    p row
    end
  end

  def self.add_place_category(args)
    add_place_prepared = $db.prepare("INSERT INTO place_categories (id, company_name)
                                     VALUES(:id,:company_name)")
    add_place_prepared.execute(args)
  end

  def self.delete_place_catagory(args)
    delete = $db.prepare("DELETE FROM place_categories
                          WHERE category_name = :category_name")
    delete.execute(args)
  end

end

class VisitRatings
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



class Database
  def self.display_all_tables
    puts "Users:"
    $db.execute( "select * from users" ) do |row|
       p row
    end
    puts "-----------"
    puts "Visit_ratings:"
    $db.execute( "select * from visit_ratings" ) do |row|
       p row
    end
    puts "---------------"
    puts "Places:"
    $db.execute( "select * from places" ) do |row|
       p row
    end
    puts "---------------"
    puts "Place categories"
    $db.execute( "select * from place_categories" ) do |row|
       p row
    end
    puts "---------------"
    puts "Places to visit"
    $db.execute( "select * from places_to_visit" ) do |row|
       p row
    end
  end
end

Users.add_user(username: "Johnathan", location:"DBCNYC")
p Users.get_user(username: "Johnathan")
Users.delete_user(username: "Johnathan")
p Users.get_user(username: "Johnathan")
