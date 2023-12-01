class Calibrator
  REGEXP = Regexp.new /\d|one|two|three|four|five|six|seven|eight|nine/
  REGEXP_LAST = Regexp.new /.*(\d|one|two|three|four|five|six|seven|eight|nine).*$/
  def initialize(input)
    @input = input
  end

  def calibrate
    sum = 0

    @input.each_line do |line|
      left = 0
      right = line.length - 1
      found = false

      while left <= right && !found
        if is_integer?(line[left]) && is_integer?(line[right])
          num = line[left] + line[right]
          sum += num.to_i
          found = true
        end

        left += 1 unless is_integer?(line[left])
        right -= 1 unless is_integer?(line[right])
      end

    end
    return sum
  end

  def calibrate_with_letters
    sum = 0

    @input.each_line do |line|
      left_num = line[REGEXP]
      right_num = line[REGEXP_LAST, 1]

      num = convert_numbers(left_num) + convert_numbers(right_num)
      sum += num.to_i
    end
    return sum
  end

  private
  def is_integer?(char)
    char.match(/[0-9]/)
  end

  def convert_numbers(words)
    line = words
    line.gsub!(/one/, "1")
    line.gsub!(/two/, "2")
    line.gsub!(/three/, "3")
    line.gsub!(/four/, "4")
    line.gsub!(/five/, "5")
    line.gsub!(/six/, "6")
    line.gsub!(/seven/, "7")
    line.gsub!(/eight/, "8")
    line.gsub!(/nine/, "9")
    return line
  end

end
