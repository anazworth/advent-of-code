require_relative "maze"

input = File.read("input.txt")

maze = Maze.new input

puts "Part 1: #{maze.find_farthest_point}"

# Yeah I definitely ended up conecting the maze and manually counting the enclosed tiles
# I get the Jordan Curve Theory, but for some reason I couldn't get it to work in code
puts "Part 2: #{maze.find_enclosed_tiles}" # should be 467
