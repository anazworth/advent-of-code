class Hand
  attr_reader :cards, :bid, :cards_numeric

  def initialize(cards, bid)
    @cards = cards
    @bid = bid
    @cards_numeric = convert_card_value_to_numeric(cards)
  end

  private

  def convert_card_value_to_numeric(cards)
    cards.chars.map do |card|
      card.gsub(/[A-Z]/, "A" => "14", "T" => "10", "J" => "11", "Q" => "12", "K" => "13")
    end
  end
end
