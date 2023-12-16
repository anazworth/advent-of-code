require_relative "beam"

input = File.read("input.txt")

beam = Beam.new input

puts "Part 1: #{beam.energized_count}"

puts "Part 2: #{beam.max_possible_energized}"
