require_relative "workflow"

input = File.read("input.txt")

workflow = Workflow.new input

puts "Part 1: #{workflow.accepted_sum}"

