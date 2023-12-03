class Schematic
  def initialize(input)
    @input = input
  end

  def find_part_number
    @input.split("\n").each_with_index.sum do |line, index|
      line_sum = 0
      part_nums = []

      line.scan(/(\d+)/) do |num_match|
        num = num_match.first.to_i
        left = Regexp.last_match.begin(0)
        right = Regexp.last_match.end(0) - 1

        # Indexes have to be saved in a hashmap with each number to avoid
        # the edge case of the same number occuring twice on one line.
        part_nums << { num: num, left_index: left, right_index: right }
      end

      part_nums.each do |num|
        line_length = line.length
        left_index = [num[:left_index] - 1, 0].max
        right_index = [left_index + num[:num].to_s.length + 1, line_length].min
        has_adj = false

        # Check left and right of part number
        if line.slice(left_index..right_index).match(/[^0-9.]/)
          has_adj = true
        end

        # Check line above part number
        if index > 0 && @input.split("\n")[index - 1].slice(left_index..right_index).match(/[^0-9.]/)
          has_adj = true
        end

        # Check line below part number
        if index < @input.split("\n").length - 1 && @input.split("\n")[index + 1].slice(left_index..right_index).match(/[^0-9.]/)
          has_adj = true
        end
        
        line_sum += num[:num].to_i if has_adj
      end
      line_sum
    end
  end
end
