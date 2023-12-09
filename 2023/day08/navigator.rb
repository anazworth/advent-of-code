class Navigator
  def initialize(input)
    @directions = input.split("\n")[0].chars
    @nodes = parse_nodes input.split("\n")[2..-1]
    @first_node = input.split("\n")[2].scan(/(\w*)\s/)[0][0]
  end

  def calculate_steps
    return follow_directions(@nodes["AAA"], "ZZZ")
  end

  def calculate_steps_by_last
    starting_nodes = @nodes.select { |key, _| key[2] == "A" }

    results = starting_nodes.map do |key, _ |
      ending_node = /..Z/
      follow_directions(@nodes[key], ending_node)
    end

    results.reduce(1, :lcm)
  end

  private

  def parse_nodes(input)
    hash = {}

    input.each do |line|
      line = line.scan(/(\w*)\s*=\s*\((\w*),\s(\w*)\)/)
      hash[line[0][0]] = { left: line[0][1], right: line[0][2] }
    end
    hash
  end

  def follow_directions(start_node, end_node_name)
    steps, dir_index = 0, 0
    current_node = start_node

    loop do
      current_direction = @directions[dir_index]

      steps += 1
      return steps if current_node[:left].match(end_node_name) && current_direction == "L"
      return steps if current_node[:right].match(end_node_name) && current_direction == "R"

      current_node = @nodes[current_node[:left]] if current_direction == "L"
      current_node = @nodes[current_node[:right]] if current_direction == "R"

      dir_index += 1
      dir_index = 0 if dir_index == @directions.length
    end

    steps
  end
end
