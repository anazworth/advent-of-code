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
INPUT2 = <<~HEREDOC
#..#..##.#.
#..#..##.#.
......#..##
##########.
..####.#.##
#.#.##....#
..#.##....#
..####.#.##
##########.
......#..##
#..#..##.#.

#..#####.##.#.#..
####..#.#....####
..##.......##.#.#
#..######.#.#####
#..######.#.#####
..##.......##.#.#
####..#.#....####
#..#####.##.#.#..
#..#...###..#..#.
#..#.###.#..#...#
###.##..#.####.#.
.##.###.##...#.##
##.###.#..###..##
#..###.#..###..##
.##.###.##...#.##
###.##..#.####.#.
#..#.###.#..#...#
HEREDOC




  def test_smudge_first
    inp = INPUT2.split("\n\n")[0].split("\n").map(&:chars)
    inp[6][0] = "#"
    assert_equal 600, Mirror.new(INPUT).check_h(inp, 100)
  end

  def test_h_reflection
    inp = INPUT.split("\n\n")[0].split("\n").map(&:chars)
    inp[6][0] = "#"

    assert Mirror.new(INPUT).is_h_reflection?(inp, 6, 7)
    assert false == Mirror.new(INPUT).is_h_reflection?(inp, 0, 1)
  end

  def test_reflection_summary
    assert_equal 405, Mirror.new(INPUT).reflection_summary
  end

  def test_smudge_summary
    assert_equal 400, Mirror.new(INPUT).smudge_summary
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
