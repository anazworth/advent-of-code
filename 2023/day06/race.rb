class Race
  def initialize(input)
    @input = input
    @time = @input.split("\n")[0].scan(/\d+/).map(&:to_i)
    @distance = @input.split("\n")[1].scan(/\d+/).map(&:to_i)
  end

  def margin_of_error
    puts @time.inspect, @distance.inspect
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
end
