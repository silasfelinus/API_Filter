require_relative "./source"
require_relative "./manager"


class API_Filter::CLI
  #CLI interface for the Source/Filter transaction
  attr_accessor :source, :filter, :manager, :results
  @@text = "It was the best of times, it was the worst of times"
  

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


  def reset_variables
    #sets variables to default values
    @source = API_Filter::Source.default_source
    @filter = API_Filter::Source.default_filter
    @manager = API_Filter::Manager.new
    @results = []
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


  def call
    #Initialize variables and handles menu loop
    reset_variables
    welcome_user

    valid_answers = ["1", "2", "3", "4", "5"]

    we_are_done = false
    while we_are_done == false
      system('clear')

      puts "1. Choose text SOURCE (CURRENTLY #{@source[0]})"
      puts "2. Choose text FILTER (CURRENTLY #{@filter[0]})"
      puts "3. Get new text from SOURCE."
      puts "4. Send current text to FILTER"
      puts "5. Quit\n"
      puts "\n"
      display_text
      selection = get_integer(1, valid_answers.length())


      case selection
      when 1
        puts "Available APIs:"
        API_Filter::Source.sources.each {|source| puts "#{source[0]} \n"}
        @source = API_Filter::Source.sources[get_integer(1, API_Filter::Source.sources.length()) - 1]
        puts "Your current source is #{@source[0]}"
        pause_for_effect
      when 2
        puts "Available filters:"
        API_Filter::Source.filters.each {|filter| puts "#{filter[0]}"}
        @filter = API_Filter::Source.filters[get_integer(1, API_Filter::Source.filters.length()) - 1]
        puts "Your current filter is #{@filter[0]}"
        pause_for_effect

      when 3
        set_loop_counter
      when 4
        process_filter
      when 5
      we_are_done = true
      end
    end
  end

  def pause_for_effect
    #pause cli action until user presses any key
    puts "Press any key to continue"
    gets.chomp
  end

  def display_text
    puts "**************************************\n"
    puts "**************************************\n"
    puts "**************************************\n"
    puts "\n"
    puts "CURRENT TEXT:\n"
    puts "\n"
    puts "#{@manager.current_text}\n"
    puts "\n\n"
    puts "**************************************\n"
    puts "**************************************\n"
    puts "**************************************\n"
  end



  def process_filter
    #gets the text(s) from source and translation(s) from the filter
    texts = @source.request(@loop_counter)
    results = @filter.translate(texts)
    output_results(results)
  end


  def output_results(results)
    results.each {|result| puts result}
  end
end