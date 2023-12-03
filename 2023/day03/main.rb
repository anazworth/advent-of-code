require_relative "schematic"

input = File.read("input.txt")

schematic = Schematic.new input

puts "Part 1: #{schematic.find_part_number}"

puts "Part 2: #{schematic.find_gear_ratio}"

