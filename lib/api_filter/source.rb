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


  def loop_counter = (integer)
    if integer <= 1
      @loop_counter = 1
    elsif integer > @max_loop_counter
      @loop_counter = @max_loop_counter
    else
      @loop_counter = integer
    end
    @loop_counter
  end

  def request(counter)
    #Run Source API
    counter.times {"API Source Text"}
  end

  def translate(text)
    #run translate API
    text.upcase
  end





end