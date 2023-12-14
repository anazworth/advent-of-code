require_relative "mirror"

input = File.read("input.txt")

mirror = Mirror.new input

puts "Part 1: #{mirror.reflection_summary}"
