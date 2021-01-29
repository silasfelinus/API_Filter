class API_Filter::Manager
  attr_accessor :source, :filter, :current_text
  @@sources = [["Official Joke API", "https://official-joke-api.appspot.com/random_joke", "JOKE"], 
               ["Chuck Norris Jokes", "https://api.chucknorris.io/jokes/random", "CHUCK"], 
               ["Forismatic.com (Quotes)", "https://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json", "QUOTE"],
               ["Custom Text", nil, "CUSTOM"]
              ]
  @@filters = [["Braile Translator", 'https://fastbraille.com/api/{#{@current_text}}', "BRAILLE"], 
               ["Meow Filter", "meow filter url", "MEOW"],
               ["Last Filter", "last_url", "FINAL"]
              ]
  @@default_text = "It was the best of times, it was the worst of times"
  @@all = []
  
  def initialize (current_text = @@default_text, source = @@sources[0], filter = @@filters[0])
    @current_text = current_text
    @source = source
    @filter = filter
    @text_history = []
    @text_history << @text
    save
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.filters
    @@filters
  end

  def self.sources
    @@sources
  end


  def get_new_text
    #fetch fresh text from the current source
    new_data = HTTParty.get(@source[1])
    process_data(new_data, @source[2])
  end

  def process_data(data, type)
  #processes data according to API type.
  #This should be refactored so any customization requirements 
  #are handled when the apis are declared
    case type
    when "JOKE"
      new_text = "#{data['setup']} \n#{data['punchline']}"
    when "CHUCK"
      new_text = "#{data['value']}"
    when "QUOTE"
      new_text = "#{data['quoteText']} \n-#{data['quoteAuthor']}"
    when "CUSTOM"
      puts "Please input your custom text:"
      new_text = gets.chomp
    else
      new_text = data
    end
    update_text(new_text)
  end



  def send_current_text
    #run translate API
    case @filter[2]
    when "BRAILLE"
      #This currently requires custom url generation,because
      #I didn't want to fiddle with getting the string to translate
      #maybe I should learn how to do it and make a blog post about it.
      converted_text = @current_text.gsub(" ", "%20")
      new_url = 'https://fastbraille.com/api/' + converted_text.to_s
      new_data = HTTParty.get(new_url)
      new_text = "#{new_data['braille']}"
      binding.pry
    else
      new_text = "Something went wrong. I don't have that filter configured properly"
    end
    update_text(new_text)
  end

  def update_text(new_text)
    @current_text = new_text
    @text_history << @current_text
    new_text
  end



  def text_history
    @text_history
  end


end