class Game
  CUBES = {
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }

  def initialize(input)
    @input = input
  end

  def check
    sum = 0

    @input.each_line do |line|
      game_id = line.match(/Game\s(\d*):\s/)[1].to_i

      line.gsub!(/Game\s\d*:\s/, "")

      sets = line.split(";")

      game_is_possible = true

      sets.each do |set|
        games = set.split(",")
        game_cubes = Hash.new(0)

        games.each do |cube_str| # Save each color and value to a Hashmap
          value, color = cube_str.strip.split(" ")
          game_cubes[color] += value.to_i
        end

        game_cubes.each do |color, value| # Check if each color is under the threshold
          game_is_possible = false unless value <= CUBES[color]
        end
      end

      if game_is_possible
        sum += game_id
      end
    end

    return sum
  end

  def check_minimum
    sum = 0
    
    @input.each_line do |line|
      line.gsub!(/Game\s\d*:\s/, "")
      max = Hash.new(0)

      sets = line.split(";")

      sets.each do |set|
        games = set.split(",")
        
        games.each do |cube_str|
          value, color = cube_str.strip.split(" ")
          max[color] = [value.to_i, max[color]].max
        end
      end

      power = 1
      max.each do |_, value|
        power *= value.to_i
      end
      sum += power
    end

    return sum
  end
end
