class Cache
  attr_reader :id, :results
  def initialize(id, results)
    @id = id
    @results = results
  end

  def ==(other)
    @id == other.id
  end
end
