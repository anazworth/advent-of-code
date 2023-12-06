require_relative "mapper"

input = File.read("input.txt")

mapper = Mapper.new input

puts "Part 1: #{mapper.lowest_location}"

puts "Part 2: #{mapper.lowest_location_range}"
