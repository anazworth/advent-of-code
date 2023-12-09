require_relative "predictor"

input = File.read("input.txt")

predictor = Predictor.new input

puts "Part 1: #{predictor.sum_extrapolated_values}"

puts "Part 2: #{predictor.sum_extrapolated_reverse_values}"
