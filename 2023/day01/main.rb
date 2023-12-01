require_relative "calibrator"

input = File.read("input.txt")

cal = Calibrator.new input

puts "Part 1: ", cal.calibrate

puts "Part 2:", cal.calibrate_with_letters
