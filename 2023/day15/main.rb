require_relative "lens"

input = File.read("input.txt")

lens = Lens.new input

puts "Part 1: #{lens.hash_sum}"

puts "Part 2: #{lens.focus_power_sum}"

