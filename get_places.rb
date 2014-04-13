require 'oauth'
require 'json'
require 'open-uri'

class Get_places
#returns an array of hashes [{name: "derpys", address:"1234 derpy lane"}]
  def self.get_google_places
    google_places = []
    places_key = "AIzaSyCJ3E7eEVg63hGSyKwdo8vr_-SUt_ySpLA"
    beg_uri = "/maps/api/place/nearbysearch/json?"
    longlat = "location=40.7061,-74.0089"
    area = "&radius=500"
    type = "&types=food"
    api_host = "https://maps.googleapis.com"
    end_uri = "&sensor=false&key=#{places_key}"
    places_query = api_host + beg_uri + longlat + area + type + end_uri
    uri = URI.parse(places_query)
    json = uri.open.read
    parsed_json = JSON.parse(json)
    parsed_json["results"].each do |place|
      google_places << {name: place["name"], address: place["vicinity"]}
    end #parse_json.each
    #need to add "next_page_token" functionality
    google_places
  end #get_google_places
  def self.get_yelp_places
    yelp_places = []
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
      yelp_places << { name: place["name"], address: place["location"]["display_address"].join(" ") }
    end #obj.each
    yelp_places
  end #get_yelp
end #class Get_places

