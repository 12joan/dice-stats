require_relative 'main'
dice_count = 1
loop do 
  [4, 6, 8, 10, 12].each do |sides|
    puts "#{Time.now}\trolling #{dice_count}d#{sides}"
    results = DiceStats.roll(dice_count, sides)
  end
  dice_count += 1
end
