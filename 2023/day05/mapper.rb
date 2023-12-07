class Mapper
  def initialize(input)
    @input = input
  end

  def lowest_location
    lowest = nil
    seeds = @input.split("\n")[0].scan(/(\d+)/)
    input = @input.gsub(/seeds:.*\n/, "")
    maps = input.split(/\n\s*\n/).map { |map| map.scan(/(\d+) (\d+) (\d+)/) }

    seeds.each do |seed|
      location = seed.join.to_i

      maps.each do |map|
        map.each do |line|
          destination = line[0].to_i
          source = line[1].to_i
          range = line[2].to_i - 1

          if (source..(source + range)).include? location
            location = location - source + destination
            break # Don't continue the loop because the location value changed
          end
        end
      end
      lowest = [lowest, location].min unless lowest == nil
      lowest = location if lowest == nil
    end
    lowest
  end

  def lowest_location_range
    lowest = nil
    seeds = @input.split("\n")[0].scan(/(\d+)/).flatten.map(&:to_i).each_slice(2)
    input = @input.gsub(/seeds:.*\n/, "")
    maps = input.split(/\n\s*\n/).map { |map| map.scan(/(\d+) (\d+) (\d+)/) }

    seeds = seeds.map { |range| (range[0]..(range[0] + range[1])) }

    found = false
    ending_location = 0

    while !found
      current_location = ending_location
      printf("\rcurrent_location: #{current_location}")
      maps.reverse.each do |map|
        map.each do |line|
          destination = line[0].to_i
          source = line[1].to_i
          range = line[2].to_i - 1

          if (destination..(destination + range)).include? current_location
            current_location = current_location - destination + source
            break # Don't continue the loop because the location value changed
          end
        end
      end
      # see if the value of location is within any of the ranges within seeds
      seeds.each do |seed_range|
        if seed_range.include? current_location
          p "found: #{ending_location} in #{seed_range}"
          found = true
          lowest = ending_location
          break
        end
      end
    ending_location += 1
    end
    return lowest
  end
end
