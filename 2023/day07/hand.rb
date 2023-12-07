class Hand
  attr_reader :cards, :bid, :cards_numeric, :cards_numeric_with_wildcard, :cards_numeric_with_wildcard_for_sorting

  def initialize(cards, bid)
    @cards = cards
    @bid = bid
    @cards_numeric = convert_card_value_to_numeric(cards)
    @cards_numeric_with_wildcard = convert_card_value_to_numeric_with_wildcard(cards)
    @cards_numeric_with_wildcard_for_sorting = convert_card_value_to_numeric_with_wildcard_for_sorting(@cards_numeric_with_wildcard)
  end

  private

  def convert_card_value_to_numeric(cards)
    cards.chars.map do |card|
      card.gsub(/[A-Z]/, "A" => "14", "T" => "10", "J" => "11", "Q" => "12", "K" => "13")
    end
  end

  def convert_card_value_to_numeric_with_wildcard(cards)
    cards.chars.map do |card|
      card.gsub(/[A-Z]/, "A" => "14", "T" => "10", "J" => "1", "Q" => "12", "K" => "13")
    end
  end

  def convert_card_value_to_numeric_with_wildcard_for_sorting(cards)
    if cards.include? "1"
      if cards.tally.sort.size == 5
        cards.map { |card| card.gsub(/\b1\b/, cards.map(&:to_i).max.to_s)}
      elsif cards.tally.sort.size == 1 && cards[0] == "1"
        cards.map { |card| card.gsub(/\b1\b/, "14") }
      else
        best_card = cards.select { |c| c != "1"}.tally.sort_by { |arr| arr[1] }.reverse[0][0]
        cards.map { |card| card.gsub(/\b1\b/, best_card) }
      end
    else
      cards
    end
  end
end
