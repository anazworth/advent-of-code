require "minitest/autorun"
require_relative "block"

class BlockTest < Minitest::Test
  INPUT = <<~HEREDOC
    2413432311323
    3215453535623
    3255245654254
    3446585845452
    4546657867536
    1438598798454
    4457876987766
    3637877979653
    4654967986887
    4564679986453
    1224686865563
    2546548887735
    4322674655533
    HEREDOC

  INPUT_TWO = <<~HEREDOC
    111111111111
    999999999991
    999999999991
    999999999991
    999999999991
    HEREDOC

  def test_cheapest_route
    assert_equal 102, Block.new(INPUT).cheapest_route
  end

  def test_cheapest_route__ultra
    assert_equal 94, Block.new(INPUT).cheapest_route_ultra
    assert_equal 71, Block.new(INPUT_TWO).cheapest_route_ultra
  end
end

