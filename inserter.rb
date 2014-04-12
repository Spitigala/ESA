require 'rubygems'
require 'oauth'
require 'pp'
require 'json'
require 'sqlite3'

#Yelp Setup
consumer_key = 'kzajzRzpzOhkCl3LqsRgYQ'
consumer_secret = 'SvKIsxzNtBmayayso7nsYawc_JU'
token = 'UOlP_2aX5W3gZdIl32sPeAKMlLEo6Y8o'
token_secret = 'x-VDajq6ItnVBUGrlFLmzGDKyyk'
api_host = 'api.yelp.com'
consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, token, token_secret)
path = "/v2/search?term=clubs&location=10005&sort=1&radius_filter=100"

#DB Setup
model = SQLite3::Database.new "nyc_suggester.db"
json =  access_token.get(path).body
 obj = JSON.parse(json)
# json_file = File.new("clubs.json", "w")
# json_file.syswrite(obj)
#json = File.read("test.json")
#obj = JSON.parse(json)
#pp obj
obj["businesses"].each do |x|
  name, location = x["name"].gsub(/'/, ''),  x["location"]["display_address"]
  model.execute <<-SQL
  INSERT INTO places (
  name, address, category_id )
  VALUES
  ('#{name}', '#{location}', 3);
SQL
end
