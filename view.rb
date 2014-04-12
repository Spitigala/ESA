#require_relative 'controller.rb'


class Interface    ###Display
  attr_reader :username, :password
  def initialize
    #@running = true

  end

  def self.who_are_you#(name)
    puts "Welcome to NYCSuggester!"
    puts "Create a new user with: new" #<username>"
    puts "Log in as a user with: login" # <username>"
    sign_in = gets.chomp
    Controller.authenticate(sign_in)
  end

  def self.ask_for_credentials
    @username = Interface.prompt_user("Please enter your username:")
    @password = Interface.prompt_user("Please enter your password:")
  end

  def self.prompt_user(message)
    puts "#{message}"
    input = gets.chomp
  end

  def self.menu_options#(menu_type)
    puts "\n"
    puts "Here are your options #{@username}:"
    puts "Add a new place to my own list: new"
    puts "Add/Rate a place I have visited: rate"
    puts "Randomly generate a place to visit: suggest"
    puts "Show all places in NYC: show all"
    puts "Show all places I have added: my list"
    puts "Show all places I have been to: visited"
    puts "Exit by typing: exit"
    choice = Interface.prompt_user("What would you like to do?:")
    if choice.match(/exit/i)
      Interface.end_app
    else
      Controller.menu_choice(choice)
    end
    Interface.menu_options
  end

  # def your_list_of_places

  # end

  # def prompt_user(message)
  #   puts "#{message}"
  #   input = gets.chomp
  # end

  def self.add_place
    puts "\n"
    name = prompt_user("Please input the name of the location:")
    address = prompt_user("Please enter the address of the location:")
    genre = prompt_user("What kind of place is this (please enter 1-3)?\n1. Bar\n2 .Restaurant\n3. Club")
    {name: name, address: address, genre: genre}
  end

  def self.rate_place
    puts "\n"
    name = prompt_user("What is the name of the location you'd like to rate?:")
    rating = prompt_user("What is the rating for this location between 1-5?:")
    {name: name, rating: rating}
  end

  def place_yet?(name)
  end

  def self.suggest_place(arg)
    puts "\n"
    puts "You should check #{arg} out!!!"
  end

  def self.display_table(*args)
    puts "\n"
    puts "print table here"
    #args.each{ |item| puts item}
  end

  def self.end_app
    puts "\n"
    puts "Have a good day, #{@username}! Eat more!"
    abort
  end

  def self.user_error
    puts "I'm sorry, there seemed to a user with that username and/or password."
    prompt_user("Please try again.")
  end

  def self.sign_in_error
    puts "I'm sorry, there seemed to a problem with that username and/or password."
    prompt_user("Please try again.")
  end

  def self.error
    puts "\n"
    puts "I'm sorry, there seemed to a problem with that input."
    puts "\n"
    #Interface.menu_options
  end

  def delete_place(place)
  end

end

