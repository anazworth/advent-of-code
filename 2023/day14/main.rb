require_relative "platform"

input = File.read("input.txt")

platform = Platform.new input

puts "Part 1: #{platform.calculate_load}"
