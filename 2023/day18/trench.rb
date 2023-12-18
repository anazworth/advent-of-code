class Trench
  DIRS = {
    "R" => [1, 0],
    "D" => [0, 1],
    "L" => [-1, 0],
    "U" => [0, -1]
  }
  def initialize(input)
    @input = input.split("\n")
  end

  def trench_area
    curr_x, curr_y = 0, 0

    vertices = []
    perimeter = 0

    instructions = @input.map { |line| line.split(" ") }
    instructions.each do |(dir, steps, _)|
      steps.to_i.times do |step|
        perimeter += 1
        curr_x += DIRS[dir][0]
        curr_y += DIRS[dir][1]
      end
      vertices << [curr_x, curr_y]
    end

    return shoelace(vertices) + perimeter / 2 + 1
  end

  def trench_hex_area
    curr_x, curr_y = 0, 0

    vertices = []
    perimeter = 0

    instructions = @input.map { |line| line.split(" ") }
    instructions.each do |_, _, hex|
      converted_hex = hex.scan(/#(.....)(.)/)
      steps = Integer(converted_hex[0][0], 16)
      dir = case converted_hex[0][1]
            when "0"
              "R"
            when "1"
              "D"
            when "2"
              "L"
            when "3"
              "U"
            end

      steps.times do |step|
        curr_x += DIRS[dir][0]
        curr_y += DIRS[dir][1]
      end
      perimeter += steps
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
