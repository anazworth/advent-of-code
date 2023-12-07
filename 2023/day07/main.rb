require_relative "game"

input = File.read("input.txt")

game = Game.new input

puts "Part 1: #{game.total_winnings}"

