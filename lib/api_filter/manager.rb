class API_Filter::Manager
  attr_accessor :name, :link, :current_text
  @@sources = [["Joke a Day", "joke url"], ["Famous Quotes", "Famous Quotes URL"]]
  @@filters = [["Pirate Filter", "pirate filter url"], ["Meow Filter", "meow filter url"]]
  @@default_text = "It was the best of times, it was the worst of times"
  @@all = []
  
  def initialize (current_text = @@default_text, source = @@sources[0], filter = @@filters[0])
    @current_text = current_text
    @source = source
    @filter = filter
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

  def request(counter)
    #Run Source API
    #counter.times {"API Source Text"}
    "API Source text"
  end

  def translate(text)
    #run translate API
    text.upcase
  end

end