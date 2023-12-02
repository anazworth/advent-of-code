require_relative "game"

input = File.read("input.txt")

game = Game.new input

puts "Part 1: ", game.check

puts "Part 2: ", game.check_minimum
