require_relative "race"

input = File.read("input.txt")

race = Race.new input

puts "Part 1: #{race.margin_of_error}"

puts "Part 2: #{race.margin_of_error_single}"


