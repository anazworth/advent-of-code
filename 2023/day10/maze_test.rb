require "minitest/autorun"
require_relative "maze"

class MazeTest < Minitest::Test
  INPUT = <<-HEREDOC
.....
.S-7.
.|.|.
.L-J.
.....
HEREDOC

  INPUT_TWO = <<-HEREDOC
..F7.
.FJ|.
SJ.L7
|F--J
LJ...
HEREDOC

  def test_find_farthest_point
    assert_equal 4, Maze.new(INPUT).find_farthest_point
    assert_equal 8, Maze.new(INPUT_TWO).find_farthest_point
  end
end

