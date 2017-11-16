class Distribution
  attr_reader :raw_data
  def initialize(raw_data)
    @raw_data = raw_data
  end

  def paths_to(total)
    parsed_data[total] || 0
  end

  def outcomes
    parsed_data.inject :+
  end

  def probability &block
    parsed_data.select.with_index { |paths, total|
      block.call(total)
    }.inject(:+).to_f / outcomes.to_f
  end

  def probability_of(total)
    paths_to(total).to_f / outcomes.to_f
  end

  def parsed_data
    raw_data.split("\n").map { |n| n.to_i }
  end
end
