require 'pg'
class Init_db
  def initialize(db_settings)
  #Hash should contain {dbname: "blah", host: "blah", etc}
    @db_settings = db_settings
    @dbconn = PGconn.connect(db_settings)
    @tables = %w[users visit_ratings places places_to_visit place_categories]
  end #initialize
  def wipe_db
    @tables.each do |table|
      @dbconn.exec("DROP TABLE IF EXISTS #{table};")
      "Dropping table #{table}"
    end #tables.each
  end
  def create_users
    create_users_prepared = @dbconn.exec("
      CREATE TABLE users (
      id SERIAL,
      username VARCHAR(30),
      location VARCHAR(30) );")
      "Creating table users"
  end #create_users
  def create_visit_ratings
    @dbconn.exec("
      CREATE TABLE visit_ratings (
      id SERIAL,
      place_id INTEGER,
      user_id INTEGER,
      visited_on TIMESTAMP,
      rating INTEGER NOT NULL);")
      "Creating table visit_ratings"
  end #create_visit_ratings
  def create_places_to_visit
    @dbconn.exec("
      CREATE TABLE places_to_visit (
      id SERIAL,
      user_id INTEGER,
      place_id INTEGER);")
      "creating table places_to_visit"
  end #create_places_to_visit
  def create_places
    @dbconn.exec("
      CREATE TABLE places (
      id SERIAL,
      name VARCHAR(30),
      address VARCHAR(30),
      category_id INTEGER);")
      "Creating table places"
  end #create_places
  def create_place_categories
    @dbconn.exec("
      CREATE TABLE place_categories (
      id SERIAL,
      category_name VARCHAR(30)) ;")
      "Creating table place_categories"
  end #create_place_categories
  def init_all
    self.wipe_db
    self.create_users
    self.create_visit_ratings
    self.create_places_to_visit
    self.create_places
    self.create_place_categories
  end #init_all

end #Init_db class

suggester_settings = {dbname: "suggester"}
sugdb = Init_db.new(suggester_settings)
#puts sugdb.init_all
sugdb.init_all
