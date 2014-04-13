require_relative 'view.rb'
require_relative 'model.rb'

class Controller
  def initialize
    @time = Time.new
    p @time.strftime("%Y-%m-%d %H:%M:%S")
    control_flow
  end

  def control_flow
    Interface.who_are_you
  end

  def self.authenticate(sign_in)
    if sign_in.match(/new/)
      @username, @location = Interface.ask_for_new_credentials
      Controller.username_already_exists?({username: @username})
    elsif sign_in.match(/login/)
      @username = Interface.ask_for_credentials
      Controller.verify_user({username: @username})
    else
      Interface.error
      Interface.who_are_you
    end
    Interface.menu_options
  end


  def self.username_already_exists?(user_info)
    if Users.get_user(user_info[:username]).empty?
      Users.add_user(user_info)
    else
      @username, @location = Interface.user_error
      Controller.username_already_exists?({username: @username, location: @location})
    end
  end

  def self.verify_user(user_info)
    if Users.get_user(user_info[:username]).empty?
      @username = Interface.sign_in_error
      Controller.verify_user({username: @username})
    end
    @username
  end

  def self.verify_credentials(credentials)
    @username, @location = credentials
    return true
    ##Interface.username == something
  end

  def self.verify_place(args)
    p args[:name]
    if (Places.get_place(args[:name])).empty?
      Interface.place_error
    else
      true
    end
  end


  def self.menu_choice(choice)
    case choice
      when /new/i
        Places.add_place(Interface.add_place)
      when /rate/i
        p rating_info = Interface.rate_place
        user_id  = Users.get_user({username: @username})
        place_info = Places.get_place(rating_info[:name])
        p place_info
        Controller.verify_place(place_info)
        place_id = place_info[:id]
        rating_hash = {user_id: user_id[:id], place_id: place_id, visited_on: (Time.new.strftime("%Y-%m-%d %H:%M:%S")), rating: rating_info[:rating]}
        p rating_hash
        VisitRatings.rate_place(rating_hash)
      when /show ratings/
        Interface.display_table(VisitRatings.display_table)
      when /show all/i
        Interface.display_table(Places.display_table)
      when /my list/i
        Interface.display_table
        #Interface.display_table(Model.show_my_places)
      when /suggest/i
        #new_place = (Model.get_place_i_havent_been_to).sample
        #Interface.suggest_place(new_place)
      when /show_all_users/
        Interface.display_table(Users.display_table)
      when /delete_user/
        Users.delete_user({username: @username})
        Interface.end_app
      when /dance/i
        counter = 0
        while counter < 20
          puts " / 0 /"
          puts "   |  PUMP UP THE JAM"
          puts "  / \\"
          puts "  |  | "
          sleep(0.2)
          system("tput bel")
          system("clear")
          puts " \\ 0 \\"
          puts "   |  PUMP UP THE JAM"
          puts "  / \\"
          puts " /  | "
          sleep(0.2)
          system("tput bel")
          system("clear")
          counter += 1
        end
      when /visited/i
        Interface.display_table
       # Interface.display_table(Model.show_visited)
      when
        Interface.error
    end

  end




end

Controller.new
