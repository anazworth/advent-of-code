require_relative "platform"

input = File.read("input.txt")

platform = Platform.new input

puts "Part 1: #{platform.calculate_total_load}"

puts "Part 2: #{platform.calculate_load_with_cycles(1_000_000_000)}"
