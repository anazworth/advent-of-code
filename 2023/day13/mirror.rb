class Mirror
  def initialize(input)
    @input = input.split("\n\n")
  end

  def reflection_summary
    @input.sum do |p|
      pp pattern = p.split("\n")
      pp [check_v(pattern), check_h(pattern)].sum
    end
  end
  
  def check_v(pattern)
    right = pattern[0].length - 1
    found_index = nil
    left = 0

    until !found_index.nil? || left == right
      found_index = left if is_v_reflection?(pattern, left, left + 1)
      left += 1
    end
    return 0 if found_index == nil
    return found_index + 1
  end

  def check_h(pattern)
    bottom = pattern.length - 1
    found_index = nil
    top = 0

    until !found_index.nil? || top == bottom
      found_index = top if is_h_reflection?(pattern, top, top + 1)
      top += 1
    end
    return 0 if found_index == nil
    return (found_index + 1) * 100
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
