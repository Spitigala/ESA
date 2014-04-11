#require_relative 'controller.rb'


class Interface
  def initialize
    @running = true

  end

  def self.who_are_you#(name)
    puts "Welcome to NYCSuggester!"
    puts "Create a new user with: new <username>"
    puts "Log in as a user with: login <username>"
    sign_in = gets.chomp
    Controller.authenticate(sign_in)
  end

  def self.prompt_user(message)
    puts "#{message}"
    input = gets.chomp
  end

  def self.menu_options#(menu_type)
    puts "What would you like to do?"
    puts "Add a new place to my own list: new"
    puts "Add/Rate a place I have visited: rate"
    puts "Randomly generate a place to visit: suggest"
    puts "Show all places: show all"
    puts "Show all places I have added: my list"
    puts "Show all places I have been to: visited"
    puts "Exit by typing: exit"
    choice = Interface.prompt_user("What would you like to do?:")
    if choice.match(/exit/i)
      Interface.end_app
    else
      Controller.menu_choice(choice)
    end
    puts "\n"
    Interface.menu_options
  end

  def your_list_of_places

  end

  # def prompt_user(message)
  #   puts "#{message}"
  #   input = gets.chomp
  # end

  def self.add_place
    name = prompt_user("Please input the name of the location:")
    address = prompt_user("Please enter the address of the location:")
    genre = prompt_user("What kind of place is this (please enter 1-3)?\n1. Bar\n2 .Restaurant\n3. Club")
    {name: name, address: address, genre: genre}
  end

  def self.rate_place
    name = prompt_user("What is the name of the location you'd like to rate?:")
    rating = prompt_user("What is the rating for this location between 1-5?:")
    {name: name, rating: rating}
  end

  def place_yet?(name)
  end

  def self.suggest_place
    puts "You should check <<<<this place>>>> out!!!"
  end

  def self.end_app
    puts "Have a good day! Eat more!"
    abort
  end

  def self.error
    puts "I'm sorry, there seemed to be a problem with your entry"
  end

  def delete_place(place)
  end

end

