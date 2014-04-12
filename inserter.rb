require 'oauth'
require 'json'
require 'sqlite3'
require 'faker'
require 'open-uri'
#Globals
$db = SQLite3::Database.open "suggest.db"

#Yelp Setup

def get_google_places
  places_key = "AIzaSyCJ3E7eEVg63hGSyKwdo8vr_-SUt_ySpLA"
  dbc_longlat = "40.7061,-74.0089"
  places_query = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{dbc_longlat}&radius=2000&types=food&sensor=false&key=#{places_key}"
  uri = URI.parse(places_query)
  json = uri.open.read
  parsed_json = JSON.parse(json)
  puts parsed_json["results"][0]["name"]
  parsed_json["results"].each do |place|
  puts place["name"], place["vicinity"]
end
end


def populate_places
  consumer_key = 'kzajzRzpzOhkCl3LqsRgYQ'
  consumer_secret = 'SvKIsxzNtBmayayso7nsYawc_JU'
  token = 'UOlP_2aX5W3gZdIl32sPeAKMlLEo6Y8o'
  token_secret = 'x-VDajq6ItnVBUGrlFLmzGDKyyk'
  api_host = 'api.yelp.com'
  consumer = OAuth::Consumer.new(consumer_key,
                                 consumer_secret,
                                 {:site => "http://#{api_host}"})
  access_token = OAuth::AccessToken.new(consumer, token, token_secret)
  path = "/v2/search?term=clubs&location=10005&sort=1"
  json =  access_token.get(path).body
  obj = JSON.parse(json)
  obj["businesses"].each do |place|
    newobj = { name: place["name"],
               address: place["location"]["display_address"].join(" "),
               category: rand(2) }
    place_insert_prepared = $db.prepare("
                              INSERT INTO places (name, address, category_id )
                              VALUES (:name, :address, :category)")
    place_insert_prepared.execute(newobj)
  end #each
end #populate

def populate_categories
  category_list = %w[ Bars Clubs Restaurants]
  category_list.each do |category|
    $db.execute("INSERT INTO place_categories(category_name)
                 VALUES ('#{category}');")
  end
end
def  populate_people(people_count)
  people_count.times do
  person = {name: Faker::Name.first_name.downcase + Faker::Name.last_name.downcase , location: "NYC"}
  people_insert_prepared = $db.prepare("INSERT INTO users (username, location)
                                        VALUES ( :name, :location)")
  people_insert_prepared.execute (person)
  end #times
end #populate_people
def populate_ratings #must be executed after places and users are populated
  place_list = $db.execute("SELECT id FROM places")
  user_list =  $db.execute("SELECT id FROM users")
  place_list.each do |place|
    myplace, myuser = place[0], user_list.sample[0] #insert 1 vote per place, random user/rating
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
      $db.execute(query)
    end
end
def populate_places_to_visit
  place_list = $db.execute("SELECT id FROM places")
  user_list =  $db.execute("SELECT id FROM users")
  place_list.each do |place|
    myplace, myuser = place[0], user_list.sample[0] #insert 1 vote per place, random user/rating
    query = ("INSERT INTO places_to_visit
                  (place_id,
                   user_id)
               VALUES
                  (#{myplace},
                  #{myuser});")
    $db.execute(query)
  end #place_list.each
end #populate_places_to_visit



populate_places
populate_categories
populate_people(200)
populate_ratings
populate_places_to_visit
#get_google_places
