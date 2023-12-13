require_relative "spring"

input = File.read("input.txt")

spring = Spring.new input

puts "Part 1: #{spring.sum_possible_arrangements}"

puts "Part 2: #{spring.sum_possible_arrangements_unfolded}"

