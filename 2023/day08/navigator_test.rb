require "minitest/autorun"
require_relative "navigator"

class NavigatorTest < Minitest::Test
  INPUT_ONE = <<-HEREDOC
RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)
HEREDOC

  INPUT_TWO = <<-HEREDOC
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
HEREDOC

  def test_calculate_steps
    assert_equal 2, Navigator.new(INPUT_ONE).calculate_steps
    assert_equal 6, Navigator.new(INPUT_TWO).calculate_steps
  end
end
