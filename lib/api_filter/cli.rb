require_relative "./api_filter/filter"
require_relative "./api_filter/source"

class API_Filter::CLI
  #CLI interface for the Source/Filter transaction
  attr_accessor :default_source, :current_source, 
                :default_filter, :current_filter, 
                :default_loop_counter, :current_loop_counter
  
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

    puts "1. Choose API Source (CURRENTLY #{@default_source.name})"
    puts "2. Choose Filter (CURRENTLY #{@default_filter.name})"
    puts "3. Change Loop Amount (CURRENTLY 1)"
    puts "4. See What Happens\n"
    puts "\n"
    puts "I want to help,"
  end

  def set_defaults
    #sets default values
    @default_source = Source.new
    @default_filter = Filter.new
    @default_loop_counter = 1
  end

  def reset_variables
    #resets variables to default values
    @source = @default_source
    @filter = @default_filter
    @loop_counter = @default_loop_counter
  end

    

  def call

    #Initialize variables
    set_defaults
    reset_variables

    #Welcome user and get input
    welcome_user
    valid_answers = ["1", "2", "3", "4"]
    user_input = nil
    until valid_answers.include?(user_input)
      puts "please input a number between 1 and #{valid_answers.length()}."
      user_input = gets.chomp
    end

    case user_input
        
    when "1"
      #Choose API Sources 

    when "2"
      #Choose Filter

    when "3"
      #Change Loop Toggle

    when "4"
      #Run Filter

    end
  end


end
