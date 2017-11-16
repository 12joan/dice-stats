class CacheSet
  attr_reader :caches
  def initialize(caches)
    @caches = caches
  end

  def find(id)
    @caches.select { |c| c.id == id }.first
  end

  def exists?(id)
    not find(id).nil?
  end
end
