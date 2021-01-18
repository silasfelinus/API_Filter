class API_Filter::Source
  attr_accessor :name, :link, :max_loop_counter, :default_source, :default_filter
  attr_reader :loop_counter
  @@all = []
  @@filters = ["Pirate Filter", "pirate filter url", 1]
  @@sources = ["Joke a Day", "joke url", 1]
  @@default_filter = @@filters[0]
  @@default_source = @@sources[0]
  LOOP_CEILING = 999
  
  def initialize (name = "default", link = nil, loop_counter = 1, max_loop_counter = LOOP_CEILING)
    @name = name
    @link = link
    @loop_counter = loop_counter
    @max_loop_counter = max_loop_counter
    save
  end

  def self.all
    @@all

  end

  def save
    @@all << self
  end

  def list_filters
    @@filters.each {|filter| filter}
  end

  def list_sources
    @@sources.each {|source| source}
  end



  def loop_counter=(value)
    if value <= 1
      @loop_counter = 1
    elsif value > @max_loop_counter
      @loop_counter = @max_loop_counter
    else
      @loop_counter = value
    end
    @loop_counter
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