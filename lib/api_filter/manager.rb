class API_Filter::Manager
  attr_accessor :source, :filter, :current_text
  @@sources = [["Joke a Day", "https://official-joke-api.appspot.com/random_joke", "JOKE"], ["Famous Quotes", "Famous Quotes URL", "QUOTE"]]
  @@filters = [["Pirate Filter", "pirate filter url"], ["Meow Filter", "meow filter url"]]
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

  def self.default_source
    @@default_source
  end

  def self.default_filter
    @@default_filter
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
  #This should probably be refactored later.
    case type
    when "JOKE"
      new_text = "#{data['setup']} \n#{data['punchline']}"
    when "QUOTE"
      binding.pry
    else
      new_text = data
    end
    @current_text = new_text
    @text_history << @current_text
    new_text
  end



  def send_current_text
    #run translate API
    @current_text = @current_text.upcase
  end

  def text_history
    @text_history
  end


end