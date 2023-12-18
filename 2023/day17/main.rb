require_relative "block"

input = File.read("input.txt")

block = Block.new input

puts "Part 1: #{block.cheapest_route}"

puts "Part 2: #{block.cheapest_route_ultra}"
