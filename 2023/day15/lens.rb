class Lens
  def initialize(input)
    @input = input.chomp.split(",")
  end

  def hash_sum
    @input.sum do |str|
      curr_val = 0
      str.chars.each do |char|
        code = char.ord
        curr_val += code
        curr_val *= 17
        curr_val %= 256
      end
      curr_val
    end
  end
end
