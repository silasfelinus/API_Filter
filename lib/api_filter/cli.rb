require_relative "./manager"


class API_Filter::CLI
  #CLI interface for the Source/Filter transaction
  attr_accessor :manager, :results


  def reset_variables
    @manager = API_Filter::Manager.new
    @results = []
  end

  def welcome_user
    #Welcome the user and list menu options
    system('clear')
    puts "Hello! I'm API Filter!"
    puts "I love taking in text from a variety of sources"
    puts "and running it through a filter."
    puts "(I'm still learning, so please be kind)."
    puts "Feedback can be sent to my friend"
    puts "Silas Knight at silasfelinus@gmail.com\n"
    puts "\n"
  end





  def get_integer(min, max)
    #asks user for input until receiving a valid integer
    user_input = nil
    until user_input.to_i.to_s == user_input && user_input.to_i <= max && user_input.to_i >= min
      puts "Please input an integer between #{min} and #{max}."
      user_input = gets.chomp
    end
    user_input.to_i
  end

  
  def display_text
    puts "**************************************\n"
    puts "CURRENT TEXT:\n\n"
    puts "#{@manager.current_text}\n\n"
    puts "**************************************\n"
  end

  def pause_for_effect
    #pause cli action until user presses any key
    puts "Press enter to continue"
    gets.chomp
    system('clear')
  end

  def select_source
    system('clear')
    puts "AVAILABLE APIS:\n"
    API_Filter::Manager.sources.each {|source| puts "#{source[0]} \n"}
    @source = API_Filter::Manager.sources[get_integer(1, API_Filter::Manager.sources.length()) - 1]
    puts "Your current source is #{@manager.source[0]}"
    pause_for_effect
  end

  def select_filter
    system('clear')
    puts "AVAILABLE FILTERS:\n"
    API_Filter::Manager.filters.each {|filter| puts "#{filter[0]}"}
    @filter = API_Filter::Manager.filters[get_integer(1, API_Filter::Manager.filters.length()) - 1]
    puts "Your current filter is #{@manager.filter[0]}"
    pause_for_effect
  end

  def get_new_text
    #Returns fresh text from Source
    system('clear')
    puts "[Source] = '#{@manager.source[0]}'\n\n"
    new_text = @manager.get_new_text
    puts "[Text Received]: \n\n'#{new_text}'\n\n"
    pause_for_effect
  end


  def send_current_text
    #Sends current text to Filter &
    #Returns filter's reply
    system('clear')
    puts "[Text Sent] = '#{@manager.current_text}'\n\n"
    new_text = @manager.send_current_text
    puts "[Text Received] = '#{new_text}'\n\n"
    pause_for_effect
  end


def call
  #Initialize variables and handles menu loop
  reset_variables
  welcome_user

  valid_answers = ["1", "2", "3", "4", "5"]

  we_are_done = false
  while we_are_done == false
    puts "1. Choose text SOURCE (CURRENTLY #{@manager.source[0]})"
    puts "2. Choose text FILTER (CURRENTLY #{@manager.filter[0]})"
    puts "3. Get new text from SOURCE"
    puts "4. Send current text to FILTER"
    puts "5. Quit\n"
    puts "\n"
    display_text
    selection = get_integer(1, valid_answers.length())
    case selection
    when 1
      select_source
    when 2
      select_filter
    when 3
      get_new_text
    when 4
      send_current_text
    when 5
    we_are_done = true
    end
  end
end

end