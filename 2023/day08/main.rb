require_relative "navigator"

input = File.read("input.txt")

navigator = Navigator.new input

puts "Part 1: #{navigator.calculate_steps}"
