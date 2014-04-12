require_relative 'view.rb'

class Controller
  def initialize
    control_flow
  end

  def control_flow
    Interface.who_are_you
  end

  def self.authenticate(sign_in)
    if sign_in.match(/new/)
      puts "make this do something"
      # if Model.get_username(username)==nil
      #   Model.add_user(username)
      # else
      #   Controller.authenticate(Interface.user_error)
      # end
    elsif sign_in.match(/login/)
      Interface.sign_in_error unless Controller.verify_credentials(Interface.ask_for_credentials)
    else
      Interface.error
      Interface.who_are_you
    end
    Interface.menu_options
  end

  def self.verify_credentials(credentials)
    return true
    ##Interface.username == something
  end




  def self.menu_choice(choice)
    case choice
      when /new/i
        Interface.add_place
        #Model.add_place(Interface.add_place)
      when /rate/i
        Interface.rate_place
        #Model.rate_place(Interface.rate_place)
      when /suggest/i
        #new_place = (Model.get_place_i_havent_been_to).sample
        #Interface.suggest_place(new_place)
      when /show all/i
        Interface.display_table
        #Interface.display_table(Model.show_all_places) ############
      when /my list/i
        Interface.display_table
        #Interface.display_table(Model.show_my_places)
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
