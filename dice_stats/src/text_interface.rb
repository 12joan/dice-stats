require_relative 'main'

module TextInterface
  def self.probability_for(line)
    data = line.split(/(d|=|<|>)/)
    invalid_input_message = "usage: AdX(=|>|<)N"
    dice_count = data[0].to_i || (return invalid_input_message)
    dice_sides = data[2].to_i || (return invalid_input_message)
    comparison = data[3]      || (return invalid_input_message)
    target_val = data[4].to_i || (return invalid_input_message)

    cached = CacheDb.cache_set(Cache, CacheSet).exists?([dice_count, dice_sides])
    complexity = dice_sides ** dice_count

    if complexity > 61000000 and (not cached) then
      return "calculation too complex"
    end

    operation = case comparison
                when '=' 
                  lambda { |n| n == target_val }
                when '<' 
                  lambda { |n| n < target_val }
                when '>' 
                  lambda { |n| n > target_val }
                else
                  return invalid_input_message
                end

    d = DiceStats.distribution_for(dice_count, dice_sides)

    return d.probability { |n| operation.call(n) }
  end
end
