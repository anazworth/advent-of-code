require "minitest/autorun"
require_relative "race"

class TestRace < Minitest::Test
  INPUT = <<-HEREDOC
Time:      7  15   30
Distance:  9  40  200
HEREDOC

  def test_margin_of_error
    assert_equal 288, Race.new(INPUT).margin_of_error
  end

end


