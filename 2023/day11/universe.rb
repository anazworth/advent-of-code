class Universe
  def initialize(input)
    @input = input.split("\n")
    @rows_to_expand = find_rows_to_expand(input)
    @cols_to_expand = find_cols_to_expand(input)
    @galaxies = find_galaxies(input)
  end

  def sum_shortest_paths(expansion_rate = 1)
    expansion_rate -= 1 unless expansion_rate == 1
    sum = 0
    @galaxies.each_with_index do |galaxy, index|
      galaxy_to_check_index = index + 1

      until galaxy_to_check_index == @galaxies.length
        x_range = [galaxy[0], @galaxies[galaxy_to_check_index][0]].sort
        y_range = [galaxy[1], @galaxies[galaxy_to_check_index][1]].sort

        curr_sum = 0
        (x_range[0]..x_range[1]).each do |x|
          curr_sum += expansion_rate unless @rows_to_expand[x] == false
          curr_sum += 1
        end
        curr_sum -= 1

        (y_range[0]..y_range[1]).each do |y|
          curr_sum += expansion_rate unless @cols_to_expand[y] == false
          curr_sum += 1
        end
        galaxy_to_check_index += 1
        curr_sum -= 1
        sum += curr_sum
      end
    end
    sum
  end

  private

  def find_rows_to_expand(input)
    hash = Hash.new(false)
    input.split("\n").each_with_index do |row, row_index|
      next if row.include? "#"
      hash[row_index] = true
    end
    hash
  end

  def find_cols_to_expand(input)
    hash = Hash.new(false)
    width = input.split("\n").first.length
    length = input.split("\n").length - 1

    (0..width).each do |col_index|
      galaxy_found = false
      (0..length).each do |row_index|
        galaxy_found = true if input.split("\n")[row_index][col_index] == "#"
      end
      hash[col_index] = true unless galaxy_found
    end
    hash
  end

  def find_galaxies(input)
    galaxies = []
    input.split("\n").each_with_index do |row, row_index|
      row.split("").each_with_index do |col, col_index|
        galaxies << [row_index, col_index] if col == "#"
      end
    end
    galaxies
  end
end
