class Race
  def initialize(input)
    @input = input
    @time = @input.split("\n")[0].scan(/\d+/).map(&:to_i)
    @distance = @input.split("\n")[1].scan(/\d+/).map(&:to_i)
  end

  def margin_of_error
    wins_by_race = []

    @time.each_with_index do |time, index|
      wins = 0
      (time).times do |t|
        next if t == 0

        remainder = time - t
        if t * remainder > @distance[index]
          wins += 1
        end
      end
      wins_by_race << wins if wins > 0
    end
    wins_by_race.inject(:*)
  end

  def margin_of_error_single
    wins_by_race = []
    time = @time.join.to_i
    distance = @distance.join.to_i

    wins = 0
    (time).times do |t|
      next if t == 0

      remainder = time - t
      if t * remainder > distance
        wins += 1
      end
    end
    wins_by_race << wins if wins > 0
  wins_by_race.inject(:*)
  end
end
