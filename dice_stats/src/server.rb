require_relative 'main'
require 'socket'

server = TCPServer.open(8000)
n = 0
loop do
  Thread.start(server.accept) do |client|
    n += 1

    line = client.gets("\0")

    data = line.split(/(d|=|<|>)/)
    dice_count = data[0].to_i || break
    dice_sides = data[2].to_i || break
    comparison = data[3]      || break
    target_val = data[4].to_i || break

    if dice_count > 10 or dice_sides > 20 then
      break
    end

    operation = case comparison
                when '=' 
                  lambda { |n| n == target_val }
                when '<' 
                  lambda { |n| n < target_val }
                when '>' 
                  lambda { |n| n > target_val }
                else
                  break
                end

    d = DiceStats.distribution_for(dice_count, dice_sides)

    probability = d.probability { |n| operation.call(n) }
    client.print probability.to_s + "\0"

    client.close
  end
end
