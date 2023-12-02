require "minitest/autorun"
require_relative "game"

class GameTest < Minitest::Test
  INPUT = <<-INPUT
          Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
          Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
          Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
          Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
          Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
          INPUT

  def test_check_game
    assert_equal 8, Game.new(INPUT).check
  end

  def test_check_minimum_cubes
    assert_equal 2286, Game.new(INPUT).check_minimum
  end
end

