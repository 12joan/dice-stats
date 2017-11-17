require_relative 'main'
dice_count = 1
loop do 
  puts "#{Time.now}\trolling #{dice_count}d6"
  results = DiceStats.roll(dice_count, 6)
  dice_count += 1
end
