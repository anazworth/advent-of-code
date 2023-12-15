class Platform
  def initialize(input)
    @input = input.split("\n")
  end

  def calculate_load
    platform = shift_rocks(@input)

    load = 0
    platform.each_with_index do |row, index|
      load += row.count("O") * (platform.length - index)
    end
    load
  end

  def shift_rocks(input)
    platform = input.map(&:dup)

    shifted = nil
    until shifted == false
      shifted = false
      platform.each_with_index do |row, row_index|
        row.each_char.with_index do |char, col_index|
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
end
