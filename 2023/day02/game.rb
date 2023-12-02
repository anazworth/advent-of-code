class Game
  CUBES = {
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }.freeze

  def initialize(input)
    @input = input
  end

  def check
    @input.each_line.sum do |game|
      game_id = game.match(/Game\s(\d*):\s/)[1].to_i
      possible_game?(game.gsub!(/Game\s\d*:\s/, "").split(";")) ? game_id : 0
    end
  end

  def check_minimum
    @input.each_line.map { |game| game_power(game) }.sum
  end

  private
  def possible_game?(game)
    game.each do |set|
      game_cubes = Hash.new(0)

      # Save each color and value to a Hashmap
      set.split(",").each do |cube_str|
        value, color = cube_str.strip.split(" ")
        game_cubes[color] += value.to_i
      end

      # Check the game against the possible cubes
      return false unless game_cubes.all? { |color, value| value <= CUBES[color] } 
    end
    return true
  end

  def game_power(game)
    max = Hash.new(0)

    game.gsub!(/Game\s\d*:\s/, "").split(";").each do |set|
      set.split(",").each do |cube_str|
        value, color = cube_str.strip.split(" ")
        max[color] = [value.to_i, max[color]].max
      end
    end

    power = 1
    max.each { |_, value| power *= value.to_i }
    return power
  end
end
