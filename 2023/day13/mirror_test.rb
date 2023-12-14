require "minitest/autorun"
require_relative "mirror"

class SpringTest < Minitest::Test
  INPUT = <<~HEREDOC
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
HEREDOC

  def test_reflection_summary
    assert_equal 405, Mirror.new(INPUT).reflection_summary
  end

  def test_check_v
    input_v = INPUT.split("\n\n")[0].split("\n")
    assert_equal 5, Mirror.new(INPUT).check_v(input_v)
  end

  def test_check_h
    input_h = INPUT.split("\n\n")[1].split("\n")
    assert_equal 400, Mirror.new(INPUT).check_h(input_h)
  end
end
