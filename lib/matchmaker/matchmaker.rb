# frozen_string_literal: true

module Matchmaker
  class Matchmaker
    attr_accessor :source, :filter, :current_text
    attr_reader :text_history, :sources, :filters

    def initialize()
      @sources = [["Official Joke API", 'https://official-joke-api.appspot.com/random_joke', "JOKE"],
                  ["Chuck Norris Jokes", 'https://api.chucknorris.io/jokes/random', "CHUCK"],
                  ["Quotes (Forismatic.com)", 'https://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json', "QUOTE"],
                  ["Random Facts", 'https://api.fungenerators.com', "FACTOID"],
                  ["'Poem of the Day' from Poems One", "https://api.poems.one/pod", "POEM"],
                  ["Custom Text", nil, "CUSTOM"]]
      @filters = [["Braille Translator", 'https://fastbraille.com/api/', "BRAILLE"],
                  ["Klingon Translator", 'https://api.funtranslations.com/translate/klingon.json?text=', "TRANSLATIONS"],
                  ["Russian Accent", 'https://api.funtranslations.com/translate/russian-accent.json?text=', "TRANSLATIONS"],
                  ["Pirate Translator", 'https://api.funtranslations.com/translate/pirate.json?text=', "TRANSLATIONS"]]
      @source = @sources[0]
      @filter = @filters[0]
      @text_history = []
      @current_text = fetch_me_a_text
    end

    def filters
      @filters
    end

    def sources
      @sources
    end

    def add_filter(filter)
      @filters << filter
    end

    def add_source(source)
      @sources << source
    end


    def fetch_me_a_text
      # processes data according to API type.
      # This should probably be refactored so 
      # any customization requirements are handled 
      # when the apis are declared
      case  @source[2]
      when "JOKE"
        new_data = HTTParty.get(@source[1])
        new_text = "#{new_data["setup"]} \n#{new_data["punchline"]}"
      when "CHUCK"
        new_data = HTTParty.get(@source[1])
        new_text = (new_data["value"]).to_s
      when "FACTOID"
        new_data = HTTParty.get(@source[1])
        new_text = (new_data["fact"]).to_s
      when "QUOTE"
        new_data = HTTParty.get(@source[1])
        new_text = "#{new_data["quoteText"]} \n-#{new_data["quoteAuthor"]}"
      when "POEM"
        new_data = HTTParty.get(@source[1])
        binding.pry
        poem_data = new_data["contents"]["poems"]
        title = poem_data[0]["poem"]["title"].to_s
        poet = poem_data[0]["poem"]["author"].to_s
        poem = poem_data[0]["poem"]["poem"].to_s
        new_text = "#{title}\n#{poem}\n\n -#{poet}"
      when "CUSTOM"
        puts "Please input your custom text:"
        new_text = gets.chomp
      else
        new_text = new_data
      end
      update_text(new_text)
    end

    def make_me_a_match
      # match source to filter
      # support for multiple filter matchups expected in future revision
      converted_text = @current_text.gsub(" ", "%20").to_s
      new_url = @filter[1] + converted_text
      new_data = HTTParty.get(new_url)
      new_text = case @filter[2]
                 when "BRAILLE"
                   (new_data["braille"]).to_s
                 when "TRANSLATIONS"
                   (new_data["contents"]["translated"]).to_s
                 else
                   "Something went wrong. I don't have that filter configured properly"
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
