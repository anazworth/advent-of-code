require "minitest/autorun"
require_relative "spring"

class SpringTest < Minitest::Test
  INPUT = <<-HEREDOC
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
HEREDOC

  def test_sum_possible_arrangements
    assert_equal 21, Spring.new(INPUT).sum_possible_arrangements
  end
end
