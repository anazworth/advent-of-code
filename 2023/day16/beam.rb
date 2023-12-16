class Beam
  def initialize(input)
    # Used `sed -i bak 's/\\/x/g' input.txt` to replace all \ with x in the input file
    @input = input.split("\n").map { |row| row.split("") }
    @energized = Set.new
    @seen_crossroads = Hash.new
  end

  def energized_count(row = 0, col = 0, starting_dir = :right)
    follow_beam(col, row, starting_dir, @input)
    @energized.count
  end

  def max_possible_energized
    max = 0

    # Check inward via left and right edges
    @input.each_with_index do |row, index|
      @energized = Set.new
      @seen_crossroads = Hash.new
      energized_count(index, 0)
      left = @energized.count
      max = [max, left].max

      @energized = Set.new
      @seen_crossroads = Hash.new
      energized_count(index, row.length - 1, :left)
      right = @energized.count
      max = [max, right].max
    end

    # Check inward via top and bottom edges
    (1..@input[0].length - 2).each do |index|
      @energized = Set.new
      @seen_crossroads = Hash.new
      energized_count(0, index, :down)
      top = @energized.count
      max = [max, top].max

      @energized = Set.new
      @seen_crossroads = Hash.new
      energized_count(@input.length - 1, index, :up)
      bottom = @energized.count
      max = [max, bottom].max
    end
    max
  end

  def follow_beam(x, y, dir, grid)
    return if x < 0 || y < 0 || x >= grid[0].length || y >= grid.length
    current = grid[y][x]
    return if @seen_crossroads[[x, y, current]]
    @energized << [y, x, current]
    case current
    when "."
      case dir
        when :right
          follow_beam(x + 1, y, dir, grid)
        when :down
          follow_beam(x, y + 1, dir, grid)
        when :left
          follow_beam(x - 1, y, dir, grid)
        when :up
          follow_beam(x, y - 1, dir, grid)
        end
    when "/"
      case dir
        when :right
          follow_beam(x, y - 1, :up, grid)
        when :down
          follow_beam(x - 1, y, :left, grid)
        when :left
          follow_beam(x, y + 1, :down, grid)
        when :up
          follow_beam(x + 1, y, :right, grid)
        end
    when "x"
      case dir
        when :right
          follow_beam(x, y + 1, :down, grid)
        when :down
          follow_beam(x + 1, y, :right, grid)
        when :left
          follow_beam(x, y - 1, :up, grid)
        when :up
          follow_beam(x - 1, y, :left, grid)
        end
    when "-"
      case dir
        when :right
          follow_beam(x + 1, y, dir, grid)
        when :down
          @seen_crossroads[[x, y, current]] = true
          follow_beam(x + 1, y, :right, grid)
          follow_beam(x - 1, y, :left, grid)
        when :left
          follow_beam(x - 1, y, dir, grid)
        when :up
          @seen_crossroads[[x, y, current]] = true
          follow_beam(x + 1, y, :right, grid)
          follow_beam(x - 1, y, :left, grid)
        end
    when "|"
      case dir
        when :right
          @seen_crossroads[[x, y, current]] = true
          follow_beam(x, y + 1, :down, grid)
          follow_beam(x, y - 1, :up, grid)
        when :down
          follow_beam(x, y + 1, dir, grid)
        when :left
          @seen_crossroads[[x, y, current]] = true
          follow_beam(x, y + 1, :down, grid)
          follow_beam(x, y - 1, :up, grid)
        when :up
          follow_beam(x, y - 1, dir, grid)
        end
      end
  end
end
