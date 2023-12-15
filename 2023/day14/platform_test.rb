require "minitest/autorun"
require_relative "platform"

class PlatformTest < Minitest::Test
  INPUT = <<~HEREDOC
    O....#....
    O.OO#....#
    .....##...
    OO.#O....O
    .O.....O#.
    O.#..O.#.#
    ..O..#O..O
    .......O..
    #....###..
    #OO..#....
    HEREDOC

  EXPECTED = <<~HEREDOC
    OOOO.#.O..
    OO..#....#
    OO..O##..O
    O..#.OO...
    ........#.
    ..#....#.#
    ..O..#.O.O
    ..O.......
    #....###..
    #....#....
    HEREDOC

  def test_calculate_total_load
    assert_equal 136, Platform.new(INPUT).calculate_total_load
  end

  def test_calculate_load_with_cycles
    # assert_equal 87, Platform.new(INPUT).calculate_load_with_cycles(1)
    # assert_equal 69, Platform.new(INPUT).calculate_load_with_cycles(2)
    # assert_equal 69, Platform.new(INPUT).calculate_load_with_cycles(3)
    assert_equal 64, Platform.new(INPUT).calculate_load_with_cycles(1_000_000_000)
  end

  def test_shift_load
    expected = EXPECTED.split("\n").map(&:chars)
    assert_equal expected, Platform.new(INPUT).shift_rocks(INPUT.split("\n").map(&:chars))
  end
end

