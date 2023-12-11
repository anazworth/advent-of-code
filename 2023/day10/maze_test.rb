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

  INPUT_THREE = <<-HEREDOC
FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L
HEREDOC

  INPUT_FOUR = <<-HEREDOC
.F----7F7F7F7F-7....
.|F--7||||||||FJ....
.||.FJ||||||||L7....
FJL7L7LJLJ||LJ.L-7..
L--J.L7...LJS7F-7L7.
....F-J..F7FJ|L7L7L7
....L7.F7||L7|.L7L7|
.....|FJLJ|FJ|F7|.LJ
....FJL-7.||.||||...
....L---J.LJ.LJLJ...
HEREDOC

  def test_find_farthest_point
    assert_equal 4, Maze.new(INPUT).find_farthest_point
    assert_equal 8, Maze.new(INPUT_TWO).find_farthest_point
  end

  def test_find_enclosed_tiles
    assert_equal 10, Maze.new(INPUT_THREE).find_enclosed_tiles
    assert_equal 8, Maze.new(INPUT_FOUR).find_enclosed_tiles
  end
end

