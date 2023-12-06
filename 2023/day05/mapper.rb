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
    seeds = seeds.sort_by(&:first).inject([]) do |result, range|
      if result.empty? || range.first > result.last.last
        result << range
      else
        result.last.last = [result.last.last, range.last].max
      end
      result
    end


    seeds.each do |seed_range|
      (seed_range).each do |seed|
        break if !seed_range.include? seed
        location = seed
        p seeds.inspect
        p "Range: #{seed_range}, Seed: #{seed}, Location: #{location}"

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
    end
    lowest
  end
end
