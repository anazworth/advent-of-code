require_relative "universe"

input = File.read("input.txt")

universe = Universe.new input

puts "Part 1: #{universe.sum_shortest_paths}"

puts "Part 2: #{universe.sum_shortest_paths(1_000_000)}"
