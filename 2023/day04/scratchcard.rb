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

  def total_scratchcards
    cards = Array.new(@input.length, 0)
    total_cards = 0

    @input.each_with_index do |line, index|
      winning_nums, scratched_nums = line.gsub(/Card\s*\d*:\s*/, "").split("|")
      winning_nums = winning_nums.split.map(&:to_i).to_h { |num| [num, true] }
      scratched_nums = scratched_nums.split.map(&:to_i).to_set

      count = (cards[index] + 1)
      total_cards += count
      num_winners = 0

      scratched_nums.each do |num|
        if winning_nums.include? num
          num_winners += 1
          cards[index + num_winners] += count
        end
      end
    end
    total_cards
  end
end
