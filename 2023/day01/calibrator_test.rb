gem "minitest"
require "minitest/autorun"
require_relative "calibrator"

class CalibratorTest < Minitest::Test
  def test_calibrates_example
    assert_equal 142, Calibrator.new("1abc2
                                    pqr3stu8vwx
                                    a1b2c3d4e5f
                                    treb7uchet").calibrate
  end

  def test_calibrates_example_with_letters
    assert_equal 281, Calibrator.new("two1nine
                                    eightwothree
                                    abcone2threexyz
                                    xtwone3four
                                    4nineeightseven2
                                    zoneight234
                                    7pqrstsixteen").calibrate_with_letters
  end
end
