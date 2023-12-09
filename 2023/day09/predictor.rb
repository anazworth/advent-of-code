class Predictor
  def initialize(input)
    @input = input.split("\n")
  end

  def sum_extrapolated_values
    @input.sum { |line| extrapolate(line) }
  end

  def sum_extrapolated_reverse_values
    @input.sum { |line| extrapolate_reverse(line) }
  end

  private

  def generate_sequences(line)
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
    acc
  end

  def extrapolate(line)
    sequences = generate_sequences(line)
    sequences.reverse.sum { |line| line[-1] }
  end

  def extrapolate_reverse(line)
    sequences = generate_sequences(line)

    placeholders = []
    curr_place = 0
    sequences.reverse.each_with_index do |line|
      place = line[0] - curr_place
      placeholders << place
      curr_place = place
    end
    placeholders[-1]
  end
end
