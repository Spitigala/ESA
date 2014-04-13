require 'pg'
require 'faker'
require_relative 'get_places.rb'
class Populate
  def initialize(provider)
    @places = Get_places.get_google_places if provider == "google"
    @places = Get_places.get_yelp_places if provider == "yelp"
    @db_settings = {dbname: "suggester"}
    @dbconn = PGconn.connect(@db_settings)
  end
  def populate_categories
    category_list = %w[ Bars Clubs Restaurants]
    category_list.each do |category|
      @dbconn.exec("
        INSERT INTO place_categories(category_name)
        VALUES ('#{category}');")
    end
  end
  def populate_places
    @dbconn.prepare('statement',
      "INSERT INTO places (name, address, category_id)
      VALUES ($1, $2, $3);")
    @places.each do |place|
      @dbconn.exec_prepared('statement', [place[:name], place[:address], rand(2)])
  #    puts  [place[:name], place[:address], rand(2)]
    end#places.each
  end #populate_places

  def populate_people(people_count)
    @dbconn.prepare('statement1',
        "INSERT INTO users (username, location)
        VALUES ( $1, $2);")
    people_count.times do
      person = {name: Faker::Name.first_name.downcase + Faker::Name.last_name.downcase, location: "NYC"}
      @dbconn.exec_prepared( 'statement1', [person[:name], person[:location]])
    end #times
  end #populate_people
  def populate_ratings #must be executed after places and users are populated
    place_list = @dbconn.exec("SELECT id FROM places")
    user_list =  @dbconn.exec("SELECT id FROM users").to_a
    p place_list.inspect, user_list.inspect
    place_list.each do |place|
      myplace, myuser = place["id"].to_i, rand(user_list.length) #insert 1 vote per place, random user/rating
        query = ("INSERT INTO visit_ratings
                     (place_id,
                      user_id,
                      visited_on,
                      rating)
                  VALUES
                     (#{myplace},
                     #{myuser},
                     CURRENT_TIMESTAMP,
                     #{rand(5)});")
        @dbconn.exec(query)
      end
  end
  def populate_places_to_visit
    place_list = @dbconn.exec("SELECT id FROM places")
    user_list =  @dbconn.exec("SELECT id FROM users").to_a
    place_list.each do |place|
      myplace, myuser = place["id"].to_i, rand(user_list.length) #insert 1 vote per place, random user/rating
      query = ("INSERT INTO places_to_visit
                    (place_id,
                     user_id)
                 VALUES
                    (#{myplace},
                    #{myuser});")
      @dbconn.exec(query)
    end #place_list.each
  end #populate_places_to_visit
end #Populate class

# whee = Populate.new("yelp")
# whee.populate_categories
# whee.populate_people(200)
# whee.populate_places
# whee.populate_ratings
# whee.populate_places_to_visit
