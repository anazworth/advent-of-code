require_relative "scratchcard"

input = File.read("input.txt")

scratchcard = Scratchcard.new input

puts "Part 1: #{scratchcard.total_points}"

puts "Part 2: #{scratchcard.total_scratchcards}"
