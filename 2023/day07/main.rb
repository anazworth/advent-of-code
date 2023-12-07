require_relative "game"

input = File.read("input.txt")

game = Game.new input

puts "Part 1: #{game.total_winnings}"

puts "Part 2: #{game.total_winnings_with_joker}"

