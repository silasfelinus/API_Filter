# frozen_string_literal: true

module Matchmaker
  class Matchmaker
    attr_accessor :source, :filter, :current_text
    @@sources = [["Official Joke API",
                  "https://official-joke-api.appspot.com/random_joke", "JOKE"],
                 ["Chuck Norris Jokes",
                  "https://api.chucknorris.io/jokes/random", "CHUCK"],
                 ["Forismatic.com (Quotes)", "https://api.forismatic.com/api/1.0
                  /?method=getQuote&lang=en&format=json", "QUOTE"],
                 ["Custom Text", nil, "CUSTOM"]]
    @@filters = [["Braille Translator",
                  "https://fastbraille.com/api/", "BRAILLE"],
                 ["Klingon Translator",
                  "https://api.funtranslations.com/translate/klingon.json?text="
                  , "TRANSLATIONS"],
                 ["Russian Accent",
                  "https://api.funtranslations.com/translate/russian-accent.json
                  ?text=", "TRANSLATIONS"],
                 ["Pirate Translator",
                  "https://api.funtranslations.com/translate/pirate.json?text=",
                   "TRANSLATIONS"]]
    @@all = []

    def initialize(_current_text = nil, source = @@sources[0],
       filter = @@filters[0])
      @source = source
      @filter = filter
      @text_history = []
      @current_text = fetch_me_a_text
      @text_history << @current_text
      save
    end

    def self.all
      @@all
    end

    def self.filters
      @@filters
    end

    def self.sources
      @@sources
    end

    attr_reader :text_history

    def save
      @@all << self
    end

    def fetch_me_a_text
      # fetch fresh text from the current source
      new_data = HTTParty.get(@source[1])
      process_data(new_data, @source[2])
    end

    def make_me_a_match
      # match source to filter
      # support for multiple filter matchups expected in future revision
      converted_text = @current_text.gsub(" ", "%20").to_s
      new_url = filter[1] + converted_text
      new_data = HTTParty.get(new_url)
      new_text = case @filter[2]
                 when "BRAILLE"
                   (new_data["braille"]).to_s
                 when "TRANSLATIONS"
                   (new_data["contents"]["translated"]).to_s
                 else
                   "Something went wrong. 
                   I don't have that filter configured properly"
                 end
      update_text(new_text)
    end

    private

    def process_data(data, type)
      # processes data according to API type.
      # This should probably be refactored so any customization requirements
      # are handled when the apis are declared
      case type
      when "JOKE"
        new_text = "#{data["setup"]} \n#{data["punchline"]}"
      when "CHUCK"
        new_text = (data["value"]).to_s
      when "QUOTE"
        new_text = "#{data["quoteText"]} \n-#{data["quoteAuthor"]}"
      when "CUSTOM"
        puts "Please input your custom text:"
        new_text = gets.chomp
      else
        new_text = data
      end
      update_text(new_text)
    end

    def update_text(new_text)
      @current_text = new_text
      @text_history << @current_text
      new_text
    end
  end
end
