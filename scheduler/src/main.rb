require_relative "cache"
require_relative "cache_db"
require_relative "cache_set"
require_relative "caching_roller"
require_relative "distribution"
require_relative "roller"

dice_count = 10
dice_sides = 6
target = 50

cache_set = CacheDb.cache_set(Cache, CacheSet)
roller = CachingRoller.new(Roller, cache_set)

results = roller.roll(dice_count, dice_sides)
distribution = Distribution.new(results)

cache = Cache.new( [dice_count, dice_sides], results )
CacheDb.save_cache cache, Cache

puts distribution.probability_of(target)
