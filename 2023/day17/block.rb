require 'rb_heap'

class Block
  def initialize(input)
    @input = input.split("\n").map { |line| line.chars.map(&:to_i) }
    @height, @width = @input.size, @input.first.size
    @grid = Hash.new

    lines = File.readlines('input.txt').map(&:chomp)
    lines.each_with_index do |line, y|
      line.chars.each_with_index do |n, x|
        @grid[[x, y]] = n.to_i
      end
    end
  end

  def cheapest_route
    find_min_cost(@input)
  end

  def cheapest_route_ultra
    least_heat(@grid, @height, @width, 3, 10)
  end

  def least_heat(grid, height, width, minimum_streak=0, maximum_steak=3)
    frontier = Heap.new { |a, b| (a <=> b) == -1 }
    frontier.add([grid[[1, 0]], [1, 0], [1, 0], 0])
    frontier.add([grid[[0, 1]], [0, 1], [0, 1], 0])
    visited = Set.new
    target = [width - 1, height - 1]
    until frontier.empty?
      cost, (x, y), (dx, dy), streak = frontier.pop
      return cost if [x, y] == target && minimum_streak <= streak
      next if visited.include?([[x, y], [dx, dy], streak])
      visited.add([[x, y], [dx, dy], streak])
      if streak < (maximum_steak - 1) && grid.key?([x + dx, y + dy])
        straight_position = [x + dx, y + dy]
        straight_cost = cost + grid[straight_position]
        frontier.add([straight_cost, straight_position, [dx, dy], streak + 1])
      end
      if minimum_streak <= streak
        lx, ly = dy, -dx
        left_position = [x + lx, y + ly]
        rx, ry = -dy, dx
        right_position = [x + rx, y + ry]
        if grid.key?(left_position)
          left_cost = cost + grid[left_position]
          frontier.add([left_cost, left_position, [lx, ly], 0])
        end
        if grid.key?(right_position)
          right_cost = cost + grid[right_position]
          frontier.add([right_cost, right_position, [rx, ry], 0])
        end
      end
    end
  end

  def find_min_cost(grid, min_streak = 1, max_streak = 3)
    directions = [[0, 1], [1, 0], [0, -1], [-1, 0]] # r d l u

    pq = Heap.new { |a, b| (a <=> b) == -1 }
    visited = Set.new

    pq << [0, 0, 0, 0, 1, 1] # [cost, [x, y], [dx, dy], streak]
    pq << [0, 0, 0, 1, 0, 1]

    while !pq.empty?
      cost, x, y, dx, dy, streak = pq.pop

      next if visited.include?([x, y, dx, dy, streak])
      visited << [x, y, dx, dy, streak].freeze

      nx, ny = x + dx, y + dy

      if nx < 0 || nx >= grid.size || ny < 0 || ny >= grid.first.size
        next
      end

      new_cost = cost + grid[nx][ny]

      if nx == grid.size - 1 && ny == grid.first.size - 1
        pp nx, ny
        return new_cost
      end

      directions.each do |dir_x, dir_y|
        next if dir_x + dx == 0 && dir_y + dy == 0

        if [dir_x, dir_y] == [dx, dy]
          turn = false
          new_streak = streak + 1
        else
          turn = true
          new_streak = 1
        end

        next if new_streak > max_streak || (turn && streak < min_streak)

        pq << [new_cost, nx, ny, dir_x, dir_y, new_streak] unless visited.include?([nx, ny, dir_x, dir_y, new_streak])

      end
    end
  end

  def valid?(row, col, grid_row_size, grid_col_size)
    row.between?(0, grid_row_size - 1) && col.between?(0, grid_col_size - 1)
  end
end
