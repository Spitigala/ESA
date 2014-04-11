#'setup.rb'

require 'sqlite3'

$db = SQLite3::Database.new "database.db"

variable = hello


class Users
  def initialize
  end

  def self.display_table
    puts "Users:"
    $db.execute( "select * from users" ) do |row|
    p row
    end
  end


  def self.add_user(*args)
    username = args[:username]
    location = args[:location]
     # add username only if it doesn't exist already
    $db.execute(
      "INSERT INTO users(username, location)
      VALUES(\"#{username}\",\"#{location}\"")
  end

  def self.delete_user(*args)
    username = args[:username]
    $db.execute(
    "DELETE FROM users
    WHERE username = \"#{username}\"")
  end

  def self.update_user(*args)
    #### WE CANNOT UPDATE A USER NAME UNLESS THE USER NAME IS UNIQUE
    username = args[:username]
    location = args[:location]
    new_username = args[:new_username]
    new_location = args[:new_location]

    ## to make sure a username is suplicated, we have to go in to the DB, pull up
    ## all the usernames, check to see if the new name matches a record already
    ## in the DB, and if so, raise an error. So first, we have to ask the user to
    ## input their current user name.
    # username_list=[]
    # $db.execute( "select username from users" ) do |username|
    #   username_list << username
    # end
    # username_list.include?(new_username)



    $db.execute(
      "UPDATE users
      SET username=\"#{new_username}\",location=\"#{new_location}\"
      WHERE username = \"#{username}\" AND location = \"#{location}\"")
  end
end

class Publishers
  def self.display_books_published_at#(publisher)
    #@first_name = publisher
    $db.execute(
    "SELECT books.id, publishers.id, publishers.first_name
    FROM books
    INNER JOIN publishers
    ON books.publisher_id=publishers.id")
  end

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

#test = Authors.new
#Authors.add_author("Shaun","coolest")
# Authors.display_table
#Authors.display_table
# Authors.delete_author("Shaun","coolest")
# #Authors.delete_author("@new_first","@new_last")
# #Authors.display_table
# #Authors.update_author("Shaun","coolest","Insung","not coolest")
# Authors.delete_author("Insung","not coolest")
# Authors.delete_author("Insung","not coolest")
# Authors.display_table

Database.display_all_tables
p Publishers.display_books_published_at


# class Books
#   def initialize
#     puts "-----------"
#     puts "Books:"
#     $db.execute( "select * from books" ) do |row|
#     p row
#     end
#   end

#   def add_author
      # $db.execute(
      #   "INSERT INTO books(author_id, book_id)
      #   VALUES(#{[*1..10].sample}, #{i} )")
#   end

#   def delete_author

#   end

#   def update_author

#   end
# end

# class Publishers
#   def initialize
#     puts "Publishers:"
#     $db.execute( "select * from publishers" ) do |row|
#     p row
#     end
#   end

#   def add_author
      # $db.execute(
      #   "INSERT INTO publishers(author_id, book_id)
      #   VALUES(#{[*1..10].sample}, #{i} )")
#   end

#   def delete_author

#   end

#   def update_author

#   end
# end

#  # Find a few rows
#  puts "Authors:"
# db.execute( "select * from authors" ) do |row|
#    p row
# end
# puts "-----------"
# puts "Books:"
# db.execute( "select * from books" ) do |row|
#    p row
# end
# puts "---------------"
# puts "Publishers:"
# db.execute( "select * from publishers" ) do |row|
#    p row
# end
# puts "---------------"
# puts "Books and Authors"
# db.execute( "select * from authors_books" ) do |row|
#    p row
# end
