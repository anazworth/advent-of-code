require_relative "trench"

input = File.read("input.txt")

trench = Trench.new input

puts "Part 1: #{trench.trench_area}"

