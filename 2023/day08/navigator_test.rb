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

  INPUT_THREE = <<-HEREDOC
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
HEREDOC

  def test_calculate_steps
    assert_equal 2, Navigator.new(INPUT_ONE).calculate_steps
    assert_equal 6, Navigator.new(INPUT_TWO).calculate_steps
  end

  def test_calculate_steps_by_last
    assert_equal 6, Navigator.new(INPUT_THREE).calculate_steps_by_last
  end
end
