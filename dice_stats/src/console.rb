require_relative 'text_interface'

loop do
  print "> "
  line = gets.chomp
  puts TextInterface.probability_for(line)
end
