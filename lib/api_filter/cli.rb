require_relative "./api_filter/source"

class API_Filter::CLI
  #CLI interface for the Source/Filter transaction
  attr_accessor :default_source, :current_source, 
                :default_filter, :current_filter, 
                :default_loop_counter, :current_loop_counter
                :results
  
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
    puts "3. Change Loop Amount (CURRENTLY #{@current_loop_counter})"
    puts "4. See What Happens\n"
    puts "\n"
    puts "I want to help,"
  end


  def set_defaults
    #sets default values
    @default_source = Source.new
    @default_filter = Filter.new
    @default_loop_counter = 1
    @results = []
  end


  def reset_variables
    #resets variables to default values
    @source = @default_source
    @filter = @default_filter
    @loop_counter = @default_loop_counter
  end

  def reset_results
    @results = []
  end



  def set_loop_counter
    #set Loop Counter based on user prompt
    system('clear')
    puts "How many times do you want to run the filter?"
    user_input = nil
    until user_input.to_i.to_s == user_input && user_input.to_i <= @source.max_loop_counter.to_i && user_input.to_i > 0
      puts "Please input an integer between 1 and #{@source.max_loop_counter}."
      user_input = gets.chomp
    end
    @loop_counter = user_input
  end


  def set_default(object)
    #displays a list of objects and selects the default option
    object.list_options
    user_input = nil
    until object.is_valid?(user_input)
      puts "Please choose an integer between 1 and #{object.all.length()}"
      user_input = gets.chomp
    end

    object.set_default(user_input)

  end




  def call
    #Initialize variables and handles menu loop
    set_defaults
    reset_variables

    welcome_user
    handle_input
  end


  def handle_input
    valid_answers = ["1", "2", "3", "4"]
    user_input = nil
    until valid_answers.include?(user_input)
      puts "please input a number between 1 and #{valid_answers.length()}."
      user_input = gets.chomp
    end

    #1 Choose API Source
    #2. Choose Filter
    #3. Change Loop Amount
    #4. Process Filter

    case user_input  
    when "1"
      set_default(@source)
    when "2"
      set_default()
    when "3"
      set_loop_counter
    when "4"
      process_filter
    end
  end

  end


  def process_filter
    #gets the text(s) from source and translation(s) from the filter
    texts = @source.request(@loop_counter)
    results = @filter.translate(texts)
    output_results(results)
  end


  def output_results(results)
    results.each do {|result| puts result}
  end


end
