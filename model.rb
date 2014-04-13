#'setup.rb'

require 'sqlite3'

$db = SQLite3::Database.open "destination_suggester.db"


class Users

  def self.display_table
    user_table = []
    $db.execute( "select * from users" ) do |id, name, location|
      user_table << {id: id, name: name, location: location}
    end
    user_table
  end

  def self.add_user(args) # {id: 0, username: "Johnathan", location: "DBC NYC"}
    add_user_prepared = $db.prepare("INSERT INTO users (username, location)
                                     VALUES(:username, :location)")
    add_user_prepared.execute(args)
  end

  def self.get_user(args) # {username: "Johnathan"}
    user_to_return = {}
    check_user = $db.prepare("SELECT id, username, location
                               FROM users
                               WHERE username = :username")
    match = check_user.execute(args)
    match.to_a.each { | id, username, location | user_to_return = { id: id, username: username, location: location}}
    user_to_return
  end

  def self.delete_user(args) # {username: "Johnathan"}
    delete = $db.prepare("DELETE FROM users
                          WHERE username = :username")
    delete.execute(args)
  end

  def self.update_user(args) # {new_username: "Johnathanw", username: "Johnathan", new_location: "DBC SF"}
    update = $db.prepare("UPDATE users
                          SET username = :new_username,
                          location= :new_location,
                          WHERE username = :username")
    update.execute(args)
  end
  # return/show all restaurants that a user wants to go to (added to "places to go")
  def self.places_to_go(args) # pass {username: "Johnathan"} get [{name: "Burger King", address: "Wall Street"}]
    user_wants_to_go = []
    prepared = $db.prepare("SELECT places.name, places.address
                            FROM users
                            JOIN places_to_visit
                                ON users.id = places_to_visit.user_id
                            JOIN places
                                ON places.id = places_to_visit.place_id
                            WHERE users.name = :username")
    places_list = prepared.execute(args)
    places_list.each{|name,address|
      user_wants_to_go << {name: name, address: address}
    }
    user_wants_to_go
  end

  def self.user_has_been_to(args)
    has_been_to = []
    prepared = $db.prepare("SELECT places.name, places.address
                            FROM users
                            JOIN places_to_visit
                                ON users.id = visit_ratings.user_id
                            JOIN places
                                ON places.id = visit_ratings.place_id
                            WHERE users.name = :username")
    places_list = prepared.execute(args)
    places_list.each{|name,address|
      has_been_to << {name: name, address: address}
    }
    has_been_to
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

class Places
  def self.display_table
    places_to_return = []
    $db.execute( "select * from Places" ) do |id, name, address, category_id|
      places_to_return << {id: id, name: name, address: address, category_id: category_id}
    end
    places_to_return
  end

  def self.add_place(args)
    add_place_prepared = $db.prepare( "INSERT INTO places
                                      ( name, address, category_id)
                                       VALUES
                                      (:name, :address, :category_id )")
    add_place_prepared.execute(args)
  end

  def self.get_place(args)
    place_to_return = {}
    check_place = $db.prepare( "SELECT id, name, address
                                FROM places
                                WHERE name = :name
                                OR address = :address")
    match = check_place.execute(args)
    match.to_a.each { | id, name, address | place_to_return = { id: id, name: name, address: address}}
    place_to_return
  end

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

  def self.add_place_category(args)
    add_place_prepared = $db.prepare("INSERT INTO place_categories (name)
                                     VALUES(:name)")
    add_place_prepared.execute(args)
  end

  def self.delete_place_category(args)
    delete = $db.prepare("DELETE FROM place_categories
                          WHERE category_name = :category_name")
    delete.execute(args)
  end

end

class VisitRatings
  def self.display_table
    ratings_to_return=[]
    $db.execute( "select * from visit_ratings" ) do |id, place_id, user_id, visited_on, rating|
      ratings_to_return << {id: id, place_id: place_id, user_id: user_id, visited_on: visited_on, rating: rating}
    end
    ratings_to_return
  end

  def self.rate_place(args)
    add_user_prepared = $db.prepare("INSERT INTO visit_ratings (place_id, user_id, visited_on, rating)
                                     VALUES(:place_id, :user_id, :visited_on, :rating)")
    add_user_prepared.execute(args)
  end

  def self.get_visit_rating(args) #Pass {place_id: 3, user_id: 2} to get one match of visit_rating info
    rating_to_return = {}
    check_visit = $db.prepare("SELECT id, place_id, user_id, visited_on, rating
                               FROM visit_ratings
                               WHERE place_id = :place_id
                               AND user_id = :user_id")
    match = check_visit.execute(args)
    match.to_a.each { | id, place_id, user_id, visited_on, rating |
      rating_to_return = { id: id, place_id: place_id, user_id: user_id, visited_on: visited_on, rating: rating}
    }
    user_to_return
  end

  def self.delete_rating(args)
    delete = $db.prepare("DELETE FROM visit_ratings
                          WHERE place_id = :place_id
                          AND user_id = :user_id")
    delete.execute(args)
  end

  def self.update_rating(args)
    update = $db.prepare("UPDATE visit_ratings
                          SET rating = :rating,
                          WHERE user_id = :user_id
                          AND place_id = :place_id")
    update.execute(args)
  end
end

Users.add_user(username: "Johnathan", location:"DBCNYC")
p Users.get_user(username: "Johnathan")
Users.display_table
Users.delete_user(username: "Johnathan")
p Users.get_user(username: "Johnathan")
