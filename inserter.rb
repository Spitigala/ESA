require 'oauth'
require 'json'
require 'sqlite3'
require 'faker'
#Globals
$db = SQLite3::Database.open "suggest.db"

#Yelp Setup



def populate_places
  use_yelp = true
  consumer_key = 'kzajzRzpzOhkCl3LqsRgYQ'
  consumer_secret = 'SvKIsxzNtBmayayso7nsYawc_JU'
  token = 'UOlP_2aX5W3gZdIl32sPeAKMlLEo6Y8o'
  token_secret = 'x-VDajq6ItnVBUGrlFLmzGDKyyk'
  api_host = 'api.yelp.com'
  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
  access_token = OAuth::AccessToken.new(consumer, token, token_secret)
  path = "/v2/search?term=clubs&location=10005&sort=1"
  json =  access_token.get(path).body
  obj = JSON.parse(json)
  obj["businesses"].each do |place|
    #puts place.class, place.inspect
    newobj = { name: place["name"], address: place["location"]["display_address"].join(" "), category: rand(2) }
    place_insert_prepared = $db.prepare("INSERT INTO places (name, address, category_id )
                                         VALUES (:name, :address, :category)")
     place_insert_prepared.execute(newobj)
  end #each
end #populate

def populate_categories
  category_list = %w[ Bars Clubs Restaurants]
  category_list.each do |category|
   $db.execute("insert into place_categories(category_name) values ('#{category}');")
  end
end
def  populate_people(people_count)
  people_count.times do
  sql_insert = "INSERT INTO users
                  (username,
                   location)
                VALUES
                  ('#{Faker::Name.first_name}',
                   'NYC');"
  $db.execute (sql_insert)
  end #times
end #populate_people
def populate_ratings
  place_list = $db.execute("SELECT id FROM places")
  user_list = $db.execute("SELECT id FROM users")
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


populate_places
# populate_categories
# populate_people(20)
# populate_ratings

