class Platform
  def initialize(input)
    @input = input.split("\n").map(&:chars)
  end

  def calculate_total_load
    platform = shift_rocks(@input)

    calculate_load(platform)
  end

  def calculate_load_with_cycles(cycles)
    platform = @input.map(&:dup)

    pattern_counter = Hash.new { |h, k| h[k] = 0 }
    weights = {}
    200.times do |n|
      platform = shift_rocks(platform) # shift north
      platform = shift_rocks(platform.transpose).map { |row| row.reverse } # shift west
      platform = shift_rocks(platform.transpose).map { |row| row.reverse } # shift south
      platform = shift_rocks(platform.transpose).map { |row| row.reverse } # shift east
      platform = platform.transpose.map { |row| row.reverse } # transpose back to original orientation
      # printf("\r#{cycles} cycles remaining, load: #{calculate_load(platform.map(&:dup))}")
      key = platform.join
      pattern_counter[key] += 1
      weights[n] = calculate_load(platform)

      break if pattern_counter[key] > 2
    end

    offset = pattern_counter.values.count(1)
    cycle_length = pattern_counter.values.count {_1 > 1}

    index = (cycles - offset - 1) % cycle_length
    weights[offset + index]
  end

  def shift_rocks(input)
    platform = input.map(&:dup)

    shifted = nil
    until shifted == false
      shifted = false
      platform.each_with_index do |row, row_index|
        row.each_with_index do |char, col_index|
          next if row_index == platform.length - 1
          if char == "." && platform[row_index + 1][col_index] == "O"
            platform[row_index][col_index] = "O"
            platform[row_index + 1][col_index] = "."
            shifted = true
          end
        end
      end
    end
    return platform
  end

  def calculate_load(pattern)
    load = 0
    pattern.each_with_index do |row, index|
      load += row.count("O") * (pattern.length - index)
    end
    load
  end
end
