require "minitest/autorun"
require_relative "schematic"

class SchematicTest < Minitest::Test
  INPUT = <<-INPUT
            467..114..
            ...*......
            ..35..633.
            ......#...
            617*......
            .....+.58.
            ..592.....
            ......755.
            ...$.*....
            .664.598..
            INPUT
  def test_find_part_number
    assert_equal 4361, Schematic.new(INPUT).find_part_number
  end

  def test_find_gear_ratio_sum
    assert_equal 467835, Schematic.new(INPUT).find_gear_ratio
  end
end
