class Mapper
  def initialize(input)
    @input = input
  end

  def lowest_location
    lowest = nil
    seeds = @input.split("\n")[0].scan(/(\d+)/)
    input = @input.gsub!(/seeds:.*\n/, "")
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
end
