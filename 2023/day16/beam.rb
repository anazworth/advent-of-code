class Beam
  def initialize(input)
    # Used `sed -i bak 's/\\/x/g' input.txt` to replace all \ with x in the input file
    @input = input.split("\n").map { |row| row.split("") }
    @energized = Set.new
    @seen_crossroads = Hash.new
  end

  def energized_count
    follow_beam(0, 0, :right, @input)
    @energized.count
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
