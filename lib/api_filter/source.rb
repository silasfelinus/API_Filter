class API_Filter::Source
  attr_accessor :name, :link, max_loop_counter
  @@all = []
  
  def initialize (name = "default", link = nil, max_loop_counter = 10)
    @name = name
    @link = link
    @max_loop_counter = max_loop_counter
    @@all << self
  end

end