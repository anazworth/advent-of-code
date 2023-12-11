require_relative "maze"

input = File.read("input.txt")

maze = Maze.new input

puts "Part 1: #{maze.find_farthest_point}"
