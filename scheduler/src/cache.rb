class Cache
  attr_reader :id, :results
  def initialize(id, results)
    @id = id
    @results = results
  end

  def ==(other)
    return false if not other.is_a?(Cache) 
    return @id == other.id
  end
end
