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
      #if Model.get_username(username)==nil
        #Model.add_user(username)
      #else
        #Interface.error
        #Interface.prompt_user
      #end
    end
    Interface.menu_options
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
        Interface.suggest_place
        #Model.rate_place(Interface.suggest.place)
      when /show all/i
        puts "show"
        ##add show feature
      when /exit/i
        return
    end

  end




end

Controller.new
