require_relative 'main'

module TextInterface
  def self.probability_for(line)
    data = line.split(/(d|=|<|>)/)
    invalid_input_message = "usage: AdX(=|>|<)N"
    dice_count = data[0].to_i || (return invalid_input_message)
    dice_sides = data[2].to_i || (return invalid_input_message)
    comparison = data[3]      || (return invalid_input_message)
    target_val = data[4].to_i || (return invalid_input_message)

    if dice_count > 10 or dice_sides > 20 then
      return "too many possible outcomes; cannot process"
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
