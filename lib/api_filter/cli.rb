#require_relative "./source"

class API_Filter::CLI
  #CLI interface for the Source/Filter transaction
  attr_accessor :source, :filter, :loop_counter, :results
  

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

    puts "1. Choose API Source (CURRENTLY #{@source.name})"
    puts "2. Choose Filter (CURRENTLY #{@filter.name})"
    puts "3. Change Loop Amount (CURRENTLY #{@loop_counter})"
    puts "4. See What Happens\n"
    puts "5. Quit\n"
    puts "\n"
    puts "I want to help,"
  end


  def reset_variables
    #sets variables to default values
    @source = API_Filter::Source.new
    @filter = API_Filter::Source.new
    @loop_counter = 1
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


  def set_loop_counter
    #set Loop Counter based on user prompt
    system('clear')
    puts "How many times do you want to run the filter?"
    @loop_counter = get_integer(1, @source.max_loop_counter)
  end


  def call
    #Initialize variables and handles menu loop
    reset_variables
    welcome_user
    handle_input
  end


  def handle_input
    valid_answers = ["1", "2", "3", "4", "5"]
    selection = get_integer(1, valid_answers.length())

    #1 Choose API Source
    #2. Choose Filter
    #3. Change Loop Amount
    #4. Process Filter
    #5. Quit

    case selection
    when "1"
      Source.list_sources
      @source = Source.sources[get_integer(1, Source.sources.length())-1]
      puts "Your current source is #{@source.name}"
    when "2"
      Source.list_filters
      @filter = Source.filters[get_integer(1, Source.filters.length())-1]
      puts "Your current source is #{@filter.name}"
    when "3"
      set_loop_counter
    when "4"
      process_filter
    end
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