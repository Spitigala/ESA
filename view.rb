class Interface
  def initialize
    @running = true

  end
  
  def who_are_you(name)
    puts "Welcome to NYCSuggester"
  end

  def menu_options(menu_type)
    puts "Your options are:"
    case menu_type
    when :start
      puts "Create a new user with: new <username>"
      puts "Log in as a user with: login <username>"
    when :logged_in
      puts "Add a new place to your list with: add"
      puts "Rate a place you've been to with: rate"
      puts "Get a random suggestion with: suggest"
      puts "Show all places with: show all"
    end
    puts "Exit by typing: exit"
    choice = prompt_user("What would you like to do?:")
  end

  def your_list_of_places

  end

  def prompt_user(message)
    puts "#{message}"
    input = gets.chomp
  end

  def add_place(place)
    name = prompt_user("Please input the name of the location:")
    address = prompt_user("Please enter the address of the location:")
    genre = prompt_user("What kind of place is this (please enter 1-3)?\n1. Bar\n2 .Restaurant\n3. Club")
    {name: name, address: address, genre: genre}
  end

  def rate_place(place)
    name = prompt_user("What is the name of the location you'd like to rate?:")
    rating = prompt_user("What is the rating for this location between 1-5?:")
    {name: name, rating: rating}
  end

  def place_yet?(name)
  end

  def suggested_place
  end

  def end_app?

  end

  def delete_place(place)
  end

end
