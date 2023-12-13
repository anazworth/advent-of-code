class Spring
  def initialize(input)
    @input = input.split("\n")
  end

  def sum_possible_arrangements
    results = @input.sum do |line|
      line = line.split(" ")
      springs = line[0]
      exp = build_regexp(line[1])
      printf "\rWorking on... #{springs}"

      sum_valid_permutations(springs, exp)
    end
    print "\r\nDone!\n"
    results
  end

  def sum_possible_arrangements_unfolded
    results = @input.sum do |line|
      springs, sizes = line.split(" ")

      sizes = sizes.split(",").map(&:to_i) * 5
      springs = [[springs] * 5].flatten.join("?") + "."
      springs = springs.gsub(/\.+/, ".")

      sum_unfolded(springs, sizes)
    end
    print "\r\nDone!\n"
    results
  end


  private

  def build_regexp(groups)
    group_arr = groups.split(",").map(&:to_i)
    exp_str = []
    group_arr.each_with_index do |num, index|
      hash = "#" * num
      if index == 0 # Making sure there are no other '#' before the first group
        exp_str << "(^[^#]+|^)(#{hash})"
      elsif index == group_arr.length - 1 # Making sure there are no other '#' after the last group
        exp_str << "(#{hash})([.]+$|$)"
      else
        exp_str << "(#{hash})"
      end
    end
    result = Regexp.new(exp_str.join("\\.+")) # Adding dots between groups
  end

  def valid_arrangement?(arrangement, exp)
    arrangement.match?(exp)
  end

  def sum_valid_permutations(springs, exp)
    variable_indices = (0...springs.length).find_all { |i| springs[i] == "?" }

    combinations = ["#", "."].repeated_permutation(variable_indices.count).to_a

    result_strings = combinations.map do |arr|
      result = springs.dup
      variable_indices.each_with_index do |index, i|
        result[index] = arr[i]
      end
      result
    end
    result_strings.uniq.sum { |arr| valid_arrangement?(arr, exp) ? 1 : 0 }
  end

  # Part 2
  # https://www.youtube.com/watch?v=ZIWk05CqC4s
  # Video/solution by CJ Avilla 
  def sum_unfolded(springs, sizes, group_size = 0, cache = {})
    key = [springs, sizes, group_size]

    return cache[key] if cache[key]

    if sizes.any? { |size| size - group_size > springs.length }
      return cache[key] = 0
    end

    if sizes.empty?
      return cache[key] = 1 if !springs.include?("#")
      return cache[key] = 0
    end

    current, *rest = springs.chars

    case [current]
    in ['?']
      return cache[key] = sum_unfolded('#' + rest.join, sizes, group_size, cache) + sum_unfolded("." + rest.join, sizes, group_size, cache)
    in ['#']
      return cache[key] = sum_unfolded(rest.join, sizes, group_size + 1, cache)
    in ['.']
      if group_size > 0
        if group_size == sizes.first
          return cache[key] = sum_unfolded(rest.join, sizes[1..], 0, cache)
        else
          return cache[key] = 0
        end
      else
        return cache[key] = sum_unfolded(rest.join, sizes, 0, cache)
      end
    end
  end
end
