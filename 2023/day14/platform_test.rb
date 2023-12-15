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

  def test_calculate_load
    assert_equal 136, Platform.new(INPUT).calculate_load
  end

  def test_shift_load
    expected = EXPECTED.split("\n")
    assert_equal expected, Platform.new(INPUT).shift_rocks(INPUT.split("\n"))
  end
end

