lines = File.readlines('input.txt').map(&:chomp)

seed_to_soil_lines = []
soil_to_fertilizer_lines = []
fertilizer_to_water_lines = []
water_to_light_lines = []
light_to_temperature_lines = []
temperature_to_humidity_lines = []
humidity_to_location_lines = []

current_map = nil
lines.each do |line|
  next if line.empty?
  if line.include?('map')
    current_map = "#{line.split(' ')[0].gsub('-', '_')}_lines"
    next
  end

  if current_map
    eval("#{current_map} << line")
  end
end

def fill_ranges(lines)
  result = {}
  lines.each do |line|
    destination, source, range = line.split(' ').map(&:to_i)

    result[source..(source + range - 1)] = destination..(destination + range - 1)
  end
  result
end

seed_to_soil_ranges = fill_ranges(seed_to_soil_lines)
soil_to_fertilizer_ranges = fill_ranges(soil_to_fertilizer_lines)
fertilizer_to_water_ranges = fill_ranges(fertilizer_to_water_lines)
water_to_light_ranges = fill_ranges(water_to_light_lines)
light_to_temperature_ranges = fill_ranges(light_to_temperature_lines)
temperature_to_humidity_ranges = fill_ranges(temperature_to_humidity_lines)
humidity_to_location_ranges = fill_ranges(humidity_to_location_lines)

seed_numbers = lines.first.gsub('seeds: ', '').split(' ').map(&:to_i)
seed_ranges = []
locations = []

seed_numbers.each.with_index do |seed, i|
  if i % 2 == 0
    seed_ranges << (seed..(seed + seed_numbers[i + 1] - 1))
  end
end

def range_intersection(range1, range2)
  return nil if (range1.max < range2.begin || range2.max < range1.begin) 
  puts "#{range1} #{range2}"
  [range1.begin, range2.begin].max..[range1.max, range2.max].min
end

def find_destination_ranges(source_ranges, destination_ranges)
  result = []
  source_ranges.uniq.each do |source_range|
    destination_ranges.each.with_index do |(source_range_temp, destination_range), i|
      if (intersection = range_intersection(source_range, source_range_temp))
        result << ((intersection.min - source_range_temp.min + destination_range.min)..(intersection.max - source_range_temp.max + destination_range.max))
        if intersection.size == source_range.size
          break
        else
          if intersection.max < source_range.max
            source_range = ((intersection.max + 1)..source_range.max)
          else
            source_range = ((source_range.min)..(intersection.min - 1))
          end
        end
      elsif i == destination_ranges.size - 1
        result << source_range
      end
    end
  end
  result
end

results = []

soil_ranges = find_destination_ranges(seed_ranges, seed_to_soil_ranges)
fertilizer_ranges = find_destination_ranges(soil_ranges, soil_to_fertilizer_ranges)
water_ranges = find_destination_ranges(fertilizer_ranges, fertilizer_to_water_ranges)
light_ranges = find_destination_ranges(water_ranges, water_to_light_ranges)
temperature_ranges = find_destination_ranges(light_ranges, light_to_temperature_ranges)
humidity_ranges = find_destination_ranges(temperature_ranges, temperature_to_humidity_ranges)
location_ranges = find_destination_ranges(humidity_ranges, humidity_to_location_ranges)

puts location_ranges.map(&:min).min
