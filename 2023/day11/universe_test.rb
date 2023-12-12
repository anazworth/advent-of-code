require "minitest/autorun"
require_relative "universe"

class MazeTest < Minitest::Test
  INPUT = <<-HEREDOC
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
HEREDOC

  def test_sum_shortest_paths
    assert_equal 374, Universe.new(INPUT).sum_shortest_paths
  end

  def test_sum_shortest_paths_with_expansion
    assert_equal 1030, Universe.new(INPUT).sum_shortest_paths(10)
    assert_equal 8410, Universe.new(INPUT).sum_shortest_paths(100)
  end
end

