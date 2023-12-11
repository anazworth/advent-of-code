class Maze
  def initialize(input)
    @input = input.split("\n").map(&:chars)
  end

  def find_farthest_point
    # Find the "S" in the array
    start = find_starting_point(@input)
    length = 0
    curr_dir = valid_first_move(start)
    curr_pos = start
    looped = false


    until looped
      curr_char = @input[curr_pos[0]][curr_pos[1]]

      if curr_char == "L" && curr_dir == "S"
        curr_dir = "E"
      elsif curr_char == "L" && curr_dir == "W"
        curr_dir = "N"
      elsif curr_char == "J" && curr_dir == "S"
        curr_dir = "W"
      elsif curr_char == "J" && curr_dir == "E"
        curr_dir = "N"
      elsif curr_char == "7" && curr_dir == "N"
        curr_dir = "W"
      elsif curr_char == "7" && curr_dir == "E"
        curr_dir = "S"
      elsif curr_char == "F" && curr_dir == "N"
        curr_dir = "E"
      elsif curr_char == "F" && curr_dir == "W"
        curr_dir = "S"
      end

      next_pos = move(curr_dir, curr_pos)
      looped = true if @input[next_pos[0]][next_pos[1]] == "S"

      curr_pos = next_pos
      length += 1
    end

    (length + 1) / 2
  end

  def find_starting_point(input)
    input.each_with_index do |row, index|
      if row.include?("S")
        break [index, row.index("S")]
      end
    end
  end

  def find_enclosed_tiles
    loop = Hash.new(false)
    # Find the "S" in the array
    start = find_starting_point(@input)
    curr_dir = valid_first_move(start)
    curr_pos = start
    looped = false


    until looped
      curr_char = @input[curr_pos[0]][curr_pos[1]]
      loop[curr_pos] = true

      if curr_char == "L" && curr_dir == "S"
        curr_dir = "E"
      elsif curr_char == "L" && curr_dir == "W"
        curr_dir = "N"
      elsif curr_char == "J" && curr_dir == "S"
        curr_dir = "W"
      elsif curr_char == "J" && curr_dir == "E"
        curr_dir = "N"
      elsif curr_char == "7" && curr_dir == "N"
        curr_dir = "W"
      elsif curr_char == "7" && curr_dir == "E"
        curr_dir = "S"
      elsif curr_char == "F" && curr_dir == "N"
        curr_dir = "E"
      elsif curr_char == "F" && curr_dir == "W"
        curr_dir = "S"
      end


      next_pos = move(curr_dir, curr_pos)
      looped = true if @input[next_pos[0]][next_pos[1]] == "S"

      curr_pos = next_pos
    end


    # Convert pipes to special characters
    @input.each_with_index do |row, row_index|
      row.each_with_index do |char, col_index|
        in_loop = loop[[row_index, col_index]]
        if in_loop
          char = @input[row_index][col_index]
          if char == "-"
            @input[row_index][col_index] = "─"
          elsif char == "|"
            @input[row_index][col_index] = "│"
          elsif char == "J"
            @input[row_index][col_index] = "┘"
          elsif char == "7"
            @input[row_index][col_index] = "┐"
          elsif char == "L"
            @input[row_index][col_index] = "└"
          elsif char == "F"
            @input[row_index][col_index] = "┌"
          end
        end
      end
    end


    contained = 0
    @input.each_with_index do |row, row_index|
      row.each_with_index do |char, col_index|
          east_index = col_index
          next if loop[[row_index, col_index]]

          sides = []

          walls_hit = 0
          until east_index >= @input[0].length
            char_in_loop = loop[[row_index, east_index]] || @input[row_index][east_index] == "S"

            east_index += 1

            if char_in_loop
              walls_hit += 1
            end
          end
          sides << walls_hit

          walls_hit = 0
          west_index = col_index
          until west_index < 0
            char_in_loop = loop[[row_index, west_index]] || @input[row_index][west_index] == "S"
            west_index -= 1
            walls_hit += 1 if char_in_loop
          end
          sides << walls_hit

          walls_hit = 0
          north_index = row_index
          until north_index < 0
            char_in_loop = loop[[north_index, col_index]] || @input[north_index][col_index] == "S"
            north_index -= 1
            walls_hit += 1 if char_in_loop
          end
          sides << walls_hit

          walls_hit = 0
          south_index = row_index
          until south_index >= @input.length
            char_in_loop = loop[[south_index, col_index]] || @input[south_index][col_index] == "S"
            south_index += 1
            walls_hit += 1 if char_in_loop
          end
          sides << walls_hit

          if sides.any? { |side| side == 0 }
            @input[row_index][col_index] = " "
          end



          @input[row_index][col_index] = sides.any? { |side| side.odd? } ? "1" : "0"
          if sides.any? { |side| side == 0 }
            @input[row_index][col_index] = " "
          end
          contained += 1 if sides.any? { |side| side.odd? } && sides.all? { |side| side != 0 }

      end
    end
    pp contained


    # Save input to file
    File.open("output.txt", "w") do |file|
      file.write(@input.map(&:join).join("\n"))
    end
    return contained
  end

  private


  def move(direction, position)
    x = position[0]
    y = position[1]
    case direction
    when "N"
      return [x - 1, y]
    when "E"
      return [x, y + 1]
    when "S"
      return [position[0] + 1, position[1]]
    when "W"
      return [x, y - 1]
    end
  end

  def valid_first_move(position, prev_position=nil)
    north_pos = move("N", position)
    north_char = @input[north_pos[0]][north_pos[1]] unless north_pos[0] < 0 || north_pos == prev_position
    east_pos = move("E", position)
    east_char = @input[east_pos[0]][east_pos[1]] unless east_pos[1] >= @input[0].length || east_pos == prev_position
    south_pos = move("S", position)
    south_char = @input[south_pos[0]][south_pos[1]] unless south_pos[0] >= @input.length || south_pos == prev_position
    west_pos = move("W", position)
    west_char = @input[west_pos[0]][west_pos[1]] unless west_pos[1] < 0 || west_pos == prev_position

    curr_char = @input[position[0]][position[1]]

    if (north_char == "|" || north_char == "F" || north_char == "7") && (curr_char == "|" || curr_char = "L" || curr_char = "J")
      "N"
    elsif (east_char == "-" || east_char == "J" || east_char == "7") && (curr_char == "-" || curr_char = "F" || curr_char = "L")
      "E"
    elsif (south_char == "|" || south_char == "L" || south_char == "J") && (curr_char == "|" || curr_char = "F" || curr_char = "7")
      "S"
    elsif (west_char == "-" || west_char == "F" || west_char == "L") && (curr_char == "-" || curr_char = "J" || curr_char = "7")
      "W"
    else
      "F"
    end
  end
end
