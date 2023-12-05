require_relative "mapper"

input = File.read("input.txt")

mapper = Mapper.new input

puts "Part 1: #{mapper.lowest_location}"
