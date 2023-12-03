class Schematic
  def initialize(input)
    @input = input.split("\n")
  end

  def find_part_number
    @input.each_with_index.sum do |line, index|
      line_sum = 0
      part_nums = extract_by_pattern_with_index(line, /(\d+)/)

      part_nums.each do |num|
        line_length = line.length
        left_index = [num[:index] - 1, 0].max
        right_index = [left_index + num[:num].to_s.length + 1, line_length].min
        has_adj = false

        # Check left and right of part number
        has_adj = true if line.slice(left_index..right_index).match(/[^0-9.]/)

        # Check line above part number
        has_adj = true if index > 0 && @input[index - 1].slice(left_index..right_index).match(/[^0-9.]/)

        # Check line below part number
        has_adj = true if index < @input.length - 1 && @input[index + 1].slice(left_index..right_index).match(/[^0-9.]/)
        
        line_sum += num[:num].to_i if has_adj
      end
      line_sum
    end
  end

  def find_gear_ratio
    @input.each_with_index.sum do |line, index|
      line_sum = 0
      possible_gears = extract_by_pattern_with_index(line, /(\*)/)
      next 0 if possible_gears.length == 0 # Skip ahead if no gears are found
      pns_above = extract_by_pattern_with_index(@input[index - 1], /(\d+)/) unless index == 0
      pns_below = extract_by_pattern_with_index(@input[index + 1], /(\d+)/) unless index >= @input.length - 1
      pns_same_line = extract_by_pattern_with_index(line, /(\d+)/)

      pns_in_context = pns_same_line
      pns_in_context += pns_below if pns_below # The lines above/below might not exist
      pns_in_context += pns_above if pns_above

      possible_gears.each do |gear|
        adj_pns = []

        pns_in_context.each do |pn|
          adj_pns << pn[:num] if (pn[:index] - 1..pn[:index] + pn[:num].length).include?(gear[:index])
        end

        line_sum += adj_pns.map(&:to_i).inject(:*) if adj_pns.length == 2
      end
      line_sum
    end
  end

  private

  def extract_by_pattern_with_index(line, pattern)
    result = []

    line.scan(pattern) do |num_match|
      num = num_match.first
      left = Regexp.last_match.begin(0)

      # Indexes have to be saved in a hashmap with each number to avoid
      # the edge case of the same pattern occuring twice on one line.
      result << { num: num, index: left }
    end
    result
  end
end
