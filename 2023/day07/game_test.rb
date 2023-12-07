require "minitest/autorun"
require_relative "game"

class GameTest < Minitest::Test
  INPUT = <<-HEREDOC
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
HEREDOC

  def test_total_winnings
    assert_equal 6440, Game.new(INPUT).total_winnings
  end

  def test_total_winnings_with_joker
    assert_equal 5905, Game.new(INPUT).total_winnings_with_joker
  end
end
