require_relative "hand"

class Game
  def initialize(input)
    @set = parse_input(input)
  end

  def total_winnings
    sorted_by_strength = Array.new([])

    # High Card
    sorted_by_strength[0] = @set.select { |hand| hand.cards_numeric.tally.sort.length == 5 }
    # One Pair
    sorted_by_strength[1] = @set.select { |hand| hand.cards_numeric.tally.sort.length == 4 }
    # Two Pair
    sorted_by_strength[2] = @set.select do |hand|
      hand.cards_numeric.tally.sort.length == 3 && hand.cards_numeric.tally.sort_by { |arr| arr[1] }[1][1] == 2
    end
    # Three of a Kind
    sorted_by_strength[3] = @set.select do |hand|
      hand.cards_numeric.tally.sort.length == 3 && hand.cards_numeric.tally.sort_by { |arr| arr[1] }[2][1] == 3
    end
    # Full House
    sorted_by_strength[4] = @set.select do |hand|
      hand.cards_numeric.tally.sort.length == 2 && hand.cards_numeric.tally.sort_by { |arr| arr[1] }[0][1] == 2
    end
    # Four of a Kind
    sorted_by_strength[5] = @set.select do |hand|
      hand.cards_numeric.tally.sort.length == 2 && hand.cards_numeric.tally.sort_by { |arr| arr[1] }[0][1] == 1
    end
    # Five of a Kind
    sorted_by_strength[6] = @set.select { |hand| hand.cards_numeric.tally.sort.length == 1 }

    final_sorted = []

    sorted_by_strength.each do |arr|
      final_sorted << arr.sort_by { |hand| hand.cards_numeric.map(&:to_i) }
    end

    sum = final_sorted.flatten.each_with_index.inject(0) do |sum, (hand, index)|
      sum += hand.bid.to_i * (index + 1)
    end

    sum
  end

  def total_winnings_with_joker
    sorted_by_strength = Array.new([])

    # High Card
    sorted_by_strength[0] = @set.select { |hand| hand.cards_numeric_with_wildcard_for_sorting.tally.sort.length == 5 }
    # One Pair
    sorted_by_strength[1] = @set.select { |hand| hand.cards_numeric_with_wildcard_for_sorting.tally.sort.length == 4 }
    # Two Pair
    sorted_by_strength[2] = @set.select do |hand|
      hand.cards_numeric_with_wildcard_for_sorting.tally.sort.length == 3 && hand.cards_numeric_with_wildcard_for_sorting.tally.sort_by { |arr| arr[1] }[1][1] == 2
    end
    # Three of a Kind
    sorted_by_strength[3] = @set.select do |hand|
      hand.cards_numeric_with_wildcard_for_sorting.tally.sort.length == 3 && hand.cards_numeric_with_wildcard_for_sorting.tally.sort_by { |arr| arr[1] }[2][1] == 3
    end
    # Full House
    sorted_by_strength[4] = @set.select do |hand|
      hand.cards_numeric_with_wildcard_for_sorting.tally.sort.length == 2 && hand.cards_numeric_with_wildcard_for_sorting.tally.sort_by { |arr| arr[1] }[0][1] == 2
    end
    # Four of a Kind
    sorted_by_strength[5] = @set.select do |hand|
      hand.cards_numeric_with_wildcard_for_sorting.tally.sort.length == 2 && hand.cards_numeric_with_wildcard_for_sorting.tally.sort_by { |arr| arr[1] }[0][1] == 1
    end
    # Five of a Kind
    sorted_by_strength[6] = @set.select { |hand| hand.cards_numeric_with_wildcard_for_sorting.tally.sort.length == 1 }

    final_sorted = []

    sorted_by_strength.each do |arr|
      final_sorted << arr.sort_by { |hand| hand.cards_numeric_with_wildcard.map(&:to_i) }
    end

    sum = final_sorted.flatten.each_with_index.inject(0) do |sum, (hand, index)|
      sum += hand.bid.to_i * (index + 1)
    end

    sum
  end

  private

  def parse_input(input)
    set = []
    input.split("\n").map do |line|
      hand = line.split(" ")
      set << Hand.new(hand[0], hand[1])
    end
    set
  end
end
