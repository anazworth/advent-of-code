class Mirror
  def initialize(input)
    @input = input.split("\n\n")
  end

  def reflection_summary
    @input.sum do |p|
      pattern = p.split("\n").map(&:chars)
      [check_v(pattern), check_h(pattern)].max
    end
  end

  def smudge_summary
    @input.sum do |p|
      pattern =  p.split("\n").map(&:chars)

      actual_h = check_h(pattern)
      actual_v = check_v(pattern)
      possible_rows = Set.new
      possible_cols = Set.new

      pattern.each_with_index do |row, row_index|
        row.each_with_index do |char, col_index|

          temp = pattern.map(&:dup)
          temp[row_index][col_index] = char == "#" ? "." : "#"

          possible_rows << check_h(temp, actual_h)
          possible_cols << check_v(temp, actual_v)
        end
      end
      row = possible_rows - [actual_h]
      col = possible_cols - [actual_v]
      row.sum + col.sum
    end
  end

  
  def check_v(pattern, original = 0)
    right = pattern[0].length - 1
    found_index = nil
    left = 0

    until !found_index.nil? || left == right
      found_index = left if is_v_reflection?(pattern, left, left + 1) && (left + 1) != original
      left += 1
    end
    return 0 if found_index == nil
    return found_index + 1
  end

  def check_h(pattern, original = 0)
    bottom = pattern.length - 1
    found_index = nil
    top = 0

    until !found_index.nil? || top == bottom
      if is_h_reflection?(pattern, top, top + 1) && (top + 1) * 100 != original
        found_index = top
      end
      top += 1
    end
    return (top) * 100 if !found_index.nil?
    return 0
  end

  def is_h_reflection?(pattern, t, b)
    until t < 0 || b > pattern.length - 1
      return false if pattern[t] != pattern[b]
      t -= 1
      b += 1
    end
    return true
  end

  def is_v_reflection?(pattern, l, r)
    until l < 0 || r > pattern[0].length - 1
      return false if !column_match?(pattern, l, r)
      l -= 1
      r += 1
    end
    return true
  end

  private

  def column_match?(pattern, l, r)
    pattern.each do |line|
      return false if line[l] != line[r]
    end
    return true
  end
end
