require "minitest/autorun"
require_relative "predictor"

class PredictorTest < Minitest::Test
  INPUT = <<-HEREDOC
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
HEREDOC

  def test_sum_extrapolated_values
    assert_equal 114, Predictor.new(INPUT).sum_extrapolated_values
  end

  def test_sum_extrapolated_reverse_values
    assert_equal 2, Predictor.new(INPUT).sum_extrapolated_reverse_values
  end
end
