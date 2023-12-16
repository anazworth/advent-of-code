class Lens
  def initialize(input)
    @input = input.chomp.split(",")
  end

  def hash_sum
    @input.sum { |str| hash_char(str.chars) }
  end

  def focus_power_sum
    boxes = Array.new(256) {Array.new}

    @input.each do |str|
      _, value = str.split(/[-=]/)
      label, operation = str.match(/([a-z]+)([-=])/).captures
      key = hash_char(label.chars)

      if operation == "="
        if boxes[key].any? {|box| box[0] == label}
          boxes[key].each {|box| box[1] = value.to_i if box[0] == label}
        else
          boxes[key] << [label, value.to_i]
        end
      elsif operation == "-"
        boxes[key].each do |box|
          boxes[key].delete_at(boxes[key].index(box)) if box[0] == label
        end
      end
    end

    sum = 0
    boxes.each_with_index do |box, box_index|
      box.each_with_index do |(label, value), index|
        sum += (box_index + 1) * (index + 1) * value
      end
    end
    sum
  end

  def hash_char(chars, curr_val = 0)
    chars.each do |char|
      code = char.ord
      curr_val += code
      curr_val *= 17
      curr_val %= 256
      curr_val
    end
    curr_val
  end
end
