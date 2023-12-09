class Predictor
  def initialize(input)
    @input = input.split("\n")
  end

  def sum_extrapolated_values
    @input.sum do |line|
      extrapolate(line)
    end
  end

  private

  def extrapolate(line)
    acc = []
    curr = line.split.map(&:to_i)

    until curr.all? { |n| n == 0 }
      acc << curr
      new = []


      curr.each_with_index do |n, i|
        new << curr[i + 1] - n unless curr[i + 1].nil?
      end
      curr = new
    end

    placeholders = []
    acc.reverse.each do |line|
      placeholders << line[-1]
    end
    placeholders.sum
  end
end
