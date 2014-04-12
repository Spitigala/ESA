require 'rubygems'
require 'oauth'
require 'pp'
require 'json'
require 'sqlite3'
require 'faker'

def insert_yelp
#Yelp Setup
use_yelp = true
consumer_key = 'kzajzRzpzOhkCl3LqsRgYQ'
consumer_secret = 'SvKIsxzNtBmayayso7nsYawc_JU'
token = 'UOlP_2aX5W3gZdIl32sPeAKMlLEo6Y8o'
token_secret = 'x-VDajq6ItnVBUGrlFLmzGDKyyk'
api_host = 'api.yelp.com'
consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, token, token_secret)
path = "/v2/search?term=clubs&location=10005&sort=1"

#DB Setup
model = SQLite3::Database.new "destination_suggester.db"
  json =  access_token.get(path).body
  obj = JSON.parse(json)
  obj["businesses"].each do |x|
    name, location = x["name"].gsub(/'/, '\\\''),  x["location"]["display_address"]
    model.execute <<-SQL
    INSERT INTO places (
    name, address, category_id )
    VALUES
    ('#{name}', '#{location}', #{rand(2)} );
  SQL
  end
end

def populate_categories
  db = SQLite3::Database.new "destination_suggester.db"
  category_list = %w[ Bars Clubs Restaurants]
  category_list.each do |category|
   db.execute("insert into place_categories(category_name) values ('#{category}');")
  end
end
def  populate_people(people_count)
  db = SQLite3::Database.new "destination_suggester.db"
  people_count.times do
  sql_insert = "INSERT INTO users
                  (username,
                   location)
                VALUES
                  ('#{Faker::Name.first_name}',
                   'NYC');"

  db.execute (sql_insert)
  end #times
end #populate_people
def populate_ratings
  db = SQLite3::Database.new "destination_suggester.db"
  place_list = db.execute("SELECT id FROM places")
  user_list = db.execute("SELECT id FROM users")
  place_list.each do |place|
    myplace, myuser = place[0], user_list[0].sample #insert 1 vote per place, random user/rating
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
      db.execute(query)
      myplace, myuser = place_list[0].sample, user_list[0].sample
      db.execute(query)
    end
end


insert_yelp
populate_categories
populate_people(20)
populate_ratings

