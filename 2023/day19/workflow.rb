class Workflow
  def initialize(input)
    @wf, @parts = input.split("\n\n")

    @wf = @wf.split("\n").map do |line|
      name, ins = line.scan(/(.+){(.+)}/)[0]
      ins = ins.split(",")
      [name, ins]
    end
    @wf = @wf.to_h
    @wf["A"] = ["A"]
    @wf["R"] = ["R"]

    @parts = @parts.split("\n").map do |line|
      line.scan(/{(.+)}/)[0][0].split(",").map { |pn| pn.scan(/(.+)=(.+)/)[0] }
    end
    @parts = @parts.map do |part|
      part = part.to_h
    end
  end

  def accepted_sum
    accepted = []

    @parts.each do |part|
      ins = @wf["in"]
      a_or_r = nil
      until a_or_r == true || a_or_r == false
        ins.each do |step|
          if step == "A"
            a_or_r = true
            break
          elsif step == "R"
            a_or_r = false
            break
          end

          if step.include?("<")
            rating, val, next_step = step.scan(/(.+)<(\d+):(.+)/)[0]
            if part[rating].to_i < val.to_i
              ins = @wf[next_step]
              break
            end
          elsif step.include?(">")
            rating, val, next_step = step.scan(/(.+)>(\d+):(.+)/)[0]
            if part[rating].to_i > val.to_i
              ins = @wf[next_step]
              break
            end
          else
            ins = @wf[step]
          end
        end
      end
      accepted << part if a_or_r
    end

    accepted.sum { |part| part["x"].to_i + part["m"].to_i + part["a"].to_i + part["s"].to_i }
  end
end
