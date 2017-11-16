require_relative "cache"
require_relative "cache_db"
require_relative "cache_set"
require_relative "caching_roller"
require_relative "distribution"
require_relative "roller"

module DiceStats
  def self.distribution_for(dice_count, dice_sides, cache_results = true)
    data = roll(dice_count, dice_sides, cache_results)
    Distribution.new(data)
  end

  def self.roll(dice_count, dice_sides, cache_results = true)
    results = roller.roll(dice_count, dice_sides)

    if cache_results then
      cache = Cache.new( [dice_count, dice_sides], results )
      CacheDb.save_cache cache, Cache
    end

    return results
  end

  private

  def self.roller
    CachingRoller.new(Roller, cache_set)
  end

  def self.cache_set
    CacheDb.cache_set(Cache, CacheSet)
  end
end
