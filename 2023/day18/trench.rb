class Trench
  DIRS = {
    "R" => [1, 0],
    "D" => [0, 1],
    "L" => [-1, 0],
    "U" => [0, -1]
  }
  def initialize(input)
    @input = input.split("\n")
    @trench = Array.new(1000) { Array.new(1000, 0) }
  end

  def trench_area
    curr_x, curr_y = 500, 500
    @trench[curr_y][curr_x] = 1

    vertices = []
    perimeter = 0


    instructions = @input.map { |line| line.split(" ") }
    instructions.each_with_index do |(dir, steps, _), i|
      steps.to_i.times do |step|
        perimeter += 1
        curr_x += DIRS[dir][0]
        curr_y += DIRS[dir][1]
        @trench[curr_y][curr_x] = 1
      end
      vertices << [curr_x, curr_y]
    end

    return shoelace(vertices) + perimeter / 2 + 1
  end

  def shoelace(vertices)
    n = vertices.length
    forward = 0
    backward = 0

    vertices = vertices.reverse
    (0...n - 1).each do |i|
      forward += vertices[i][0] * vertices[i + 1][1]
    end
    forward += vertices[n - 1][0] * vertices[0][1]

    (1...n).each do |i|
      backward += vertices[i][0] * vertices[i - 1][1]
    end
    backward += vertices[0][0] * vertices[n - 1][1]
    (forward - backward).abs / 2
  end
end
