require "minitest/autorun"
require_relative "lens"

class LensTest < Minitest::Test
  INPUT = <<~HEREDOC
    rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
    HEREDOC

  def test_hash_sum
    assert_equal 1320, Lens.new(INPUT).hash_sum
  end
end


