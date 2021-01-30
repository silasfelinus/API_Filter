# frozen_string_literal: true

require_relative "./matchmaker"

module Matchmaker
  class CLI
    # CLI interface for the Source/Filter transaction
    attr_accessor :matchmaker, :results

    def reset_variables
      @matchmaker = Matchmaker::Matchmaker.new
      @results = []
    end

    def welcome_user
      # Welcome the user and list menu options
      system("clear")
      puts "Hello! I'm Matchmaker!"
      puts "I love helping two or more APIs make a connection"
      puts "Right now my specialty is text, but I also support braille"
      puts "and I'm really interested in anything I can do to"
      puts "help the digital and physical worlds talk to one another."
      puts "Feedback can be sent to my friend Silas Knight "
      puts "at silasfelinus@gmail.com\n"
      puts "\n"
    end

    def get_integer(min, max)
      # asks user for input until receiving a valid integer
      user_input = nil
      until user_input.to_i.to_s == user_input && user_input.to_i <= max &&
            user_input.to_i >= min
        puts "Please input an integer between #{min} and #{max}."
        user_input = gets.chomp
      end
      user_input.to_i
    end

    def display_text
      puts "**************************************\n"
      puts "CURRENT TEXT:\n\n"
      puts "#{@matchmaker.current_text}\n\n"
      puts "**************************************\n"
    end

    def pause_for_effect
      # pause cli action until user presses any key
      puts "Press enter to continue"
      gets.chomp
      system("clear")
    end

    def select_source
      system("clear")
      puts "AVAILABLE APIS:\n"
      Matchmaker::Matchmaker.sources.each_with_index do |source, index|
        puts "#{index + 1} - #{source[0]} \n"
      end
      matchmaker.source = Matchmaker::Matchmaker.sources[
        get_integer(1, Matchmaker::Matchmaker.sources.length) - 1]
      puts "Your current source is #{@matchmaker.source[0]}"
      pause_for_effect
    end

    def select_filter
      system("clear")
      puts "AVAILABLE FILTERS:\n"
      Matchmaker::Matchmaker.filters.each_with_index do |filter, index|
        puts "#{index + 1} - #{filter[0]}"
      end
      @matchmaker.filter = Matchmaker::Matchmaker.filters[
        get_integer(1, Matchmaker::Matchmaker.filters.length) - 1]
      puts "Your current filter is #{@matchmaker.filter[0]}"
      pause_for_effect
    end

    def get_new_text
      # Returns fresh text from Source
      system("clear")
      puts "[Source] = '#{@matchmaker.source[0]}'\n\n"
      new_text = @matchmaker.fetch_me_a_text
      puts "[Text Received]: \n\n'#{new_text}'\n\n"
      pause_for_effect
    end

    def send_current_text
      # Sends current text to Filter &
      # Returns filter's reply
      system("clear")
      puts "[Text Sent] = '#{@matchmaker.current_text}'\n\n"
      new_text = @matchmaker.make_me_a_match
      puts "[Text Received] = '#{new_text}'\n\n"
      pause_for_effect
    end

    def call
      # Initialize variables and handles menu loop
      reset_variables
      welcome_user
      valid_answers = %w[1 2 3 4 5]
      we_are_done = false

      while we_are_done == false
        puts "1. Choose text SOURCE (CURRENTLY #{@matchmaker.source[0]})"
        puts "2. Choose text FILTER (CURRENTLY #{@matchmaker.filter[0]})"
        puts "3. Get new text from SOURCE"
        puts "4. Send current text to FILTER"
        puts "5. Quit\n"
        puts "\n"
        display_text
        selection = get_integer(1, valid_answers.length)
        case selection
        when 1
          select_source
        when 2
          select_filter
        when 3
          fetch_me_a_text
        when 4
          make_me_a_match
        when 5
          we_are_done = true
        end
      end
    end
  end
end
