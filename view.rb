class Interface
  def initialize
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
      puts "Add a new place to your list with: add \"<place_name>\""
      puts "Rate a place you've been to with: rate \"<place_name>\""
      puts "Get a random suggestion with: suggest"
      puts "Show all places with: show all"
    end
  end

  def your_list_of_places
  end

  def prompt_user(message)
  end

  def add_place(place)
  end

  def rate_place(place)
  end

  def random_place
  end

  def suggested_place
  end

  def end_app?
  end

  def delete_place(place)
  end

end
