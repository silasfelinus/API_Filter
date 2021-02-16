# frozen_string_literal: true

module Matchmaker
  class Matchmaker
    attr_accessor :source, :filter, :current_text
    attr_reader :text_history

    def initialize()
      @source = sources[0]
      @filter = filters[0]
      @text_history = []
      @current_text = fetch_me_a_text
    end
    
    def sources
      # Default text source APIs
      # this will look better building a hash from an outside file
      [["Official Joke API", 'https://official-joke-api.appspot.com/random_joke', "JOKE"],
        ["Chuck Norris Jokes", 'https://api.chucknorris.io/jokes/random', "CHUCK"],
        ["Quotes (Forismatic.com)", 'https://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json', "QUOTE"],
        ["Random Facts", 'https://api.fungenerators.com', "FACTOID"],
        ["'Poem of the Day' from Poems One", "https://api.poems.one/pod", "POEM"],
        ["Custom Text", nil, "CUSTOM"]]
    end

    def filters
      # Default text filter APIs
      # this will look better building a hash from an outside file
      [["Braille Translator", 'https://fastbraille.com/api/', "BRAILLE"],
      ["Klingon Translator", 'https://api.funtranslations.com/translate/klingon.json?text=', "TRANSLATIONS"],
      ["Russian Accent", 'https://api.funtranslations.com/translate/russian-accent.json?text=', "TRANSLATIONS"],
      ["Pirate Translator", 'https://api.funtranslations.com/translate/pirate.json?text=', "TRANSLATIONS"]]
    end


    def add_source(source)
      @sources << source
    end

    def add_filter(filter)
      @filters << filter
    end


    def fetch_me_a_text
      # Grabs new text from the source API
      if @source[2] == "CUSTOM"
        puts "Please input your custom text:"
        new_text = gets.chomp
      else
        new_data = HTTParty.get(@source[1])
        if new_data["error"]
          someone_sent_me_an_error
        else
          new_text = parse_data(new_data)
        end
      end
      update_text(new_text)
    end

    def parse_data(new_data)
      # Processes the data based on the API formatting
      # This is prime candidate for automating
      # through an array of keyword
      case  @source[2]
      when "JOKE"
        new_text = "#{new_data["setup"]} \n#{new_data["punchline"]}"
      when "CHUCK"
        new_text = (new_data["value"]).to_s
      when "FACTOID"
        new_text = (new_data["fact"]).to_s
      when "QUOTE"
        new_text = "#{new_data["quoteText"]} \n-#{new_data["quoteAuthor"]}"
      when "POEM"
        poem_data = new_data["contents"]["poems"]
        title = poem_data[0]["poem"]["title"].to_s
        poet = poem_data[0]["poem"]["author"].to_s
        poem = poem_data[0]["poem"]["poem"].to_s
        new_text = "#{title}\n#{poem}\n\n -#{poet}"
      else
        new_text = new_data
      end
      new_text
    end

    def make_me_a_match
      # Sends current text to the filter API
      # and updates the current text with the response
      if @filter[2] == "BRAILLE"
        converted_text = ERB::Util.url_encode(current_text.gsub("\r", ""))
      else
        converted_text = ERB::Util.url_encode(current_text.gsub("\r", "").gsub("\n", " "))
      end
      converted_url = @filter[1] + converted_text

      # Checks for filter response, or returns an error message
      begin
        new_data = HTTParty.get(converted_url.to_s)
        if new_data["error"]
          someone_sent_me_an_error
        else
          new_text = case @filter[2]
                    when "BRAILLE"
                      (new_data["braille"]).to_s
                    when "TRANSLATIONS"
                      (new_data["contents"]["translated"]).to_s
                    # when NEWCODEGOESHERE
                    else
                      "Something went wrong. I don't have that filter configured properly"
                    end
                    
          update_text(new_text)
        end
      rescue => error_message
        puts "*************************"
        puts "Something went wrong."
        puts "If you are accessing a free API, they may be rate-limited"
        puts "Maybe this error message will help:"
        puts error_message
        puts "*************************"
        puts "\n\n"
      end

    end

    private
    def update_text(new_text)
      # Updates the current text
      @current_text = new_text
      @text_history << @current_text
      new_text
    end

    def someone_sent_me_an_error
      #Handles error responses from APIs
      puts "I'm sorry, the API returned an error:"
      if new_data["error"]["message"]
        puts new_data["error"]["message"]
      end
    end

  end
end
