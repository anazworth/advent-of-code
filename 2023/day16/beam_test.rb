require "minitest/autorun"
require_relative "beam"

class BeamTest < Minitest::Test
  INPUT = <<~HEREDOC
    .|...x....
    |.-.x.....
    .....|-...
    ........|.
    ..........
    .........x
    ..../.xx..
    .-.-/..|..
    .|....-|.x
    ..//.|....
    HEREDOC

  def test_energized_count
    assert_equal 46, Beam.new(INPUT).energized_count
  end
end


