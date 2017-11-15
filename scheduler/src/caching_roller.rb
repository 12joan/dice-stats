class CachingRoller
  def initialize(roller, cache_set)
    @roller = roller
    @cache_set = cache_set
  end

  def roll(count, sides)
    id = [count, sides]
    if @cache_set.exists?(id) then
      @cache_set.find(id).results
    else
      @roller.roll(count, sides)
    end
  end
end
