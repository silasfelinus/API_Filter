require_relative "./source"

class API_Filter::Manager
  attr_accessor :name, :link, :current_text
  @@all = []
  @@sources = [["Joke a Day", "joke url", 1], ["Famous Quotes", "Famous Quotes URL", 2]]
  @@filters = [["Pirate Filter", "pirate filter url", 1], ["Meow Filter", "meow filter url", 2]]
  @@default_filter = @@filters[0]
  @@default_source = @@sources[0]
  @@current_text = "It was the best of times, it was the worst of times"
  @@text_history = [@@current_text]
  
  def initialize (name = "default", link = nil)
    @name = name
    @link = link
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