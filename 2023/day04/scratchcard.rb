class Scratchcard
  def initialize(input)
    @input = input.split("\n")
  end

  def total_points
    points = 0
    @input.each do |line|
      line.gsub!(/Card\s*\d*:\s*/, "")
      winning_nums, scratched_nums = line.split("|")
      winning_nums = winning_nums.split.map(&:to_i).to_h { |num| [num, true] }
      scratched_nums = scratched_nums.split.map(&:to_i).to_set

      matches = scratched_nums.each.sum do |num|
        next 0 unless winning_nums.include? num
        1
      end

      points += 2**(matches-1) if matches > 1
      points += 1 if matches == 1
    end
    points
  end
end
