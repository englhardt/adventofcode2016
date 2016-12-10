data = map(x -> chop(x), readlines(open("input.txt", "r")))

bots = Dict{Int, Array{Int}}()
output = Dict{Int, Array{Int}}()

pipeline = Dict()
for l in data
  if startswith(l, "value ")
    instr = map(parse, matchall(r"(\d+)", l))
    if instr[2] ∉ keys(bots)
      bots[instr[2]] = [instr[1]]
    else
      push!(bots[instr[2]], instr[1])
    end
  else
    targets = map(strip, matchall(r" (bot|output) ", l))
    values = map(parse, matchall(r"(\d+)", l))
    pipeline[values[1]] = [(targets[1], values[2]), (targets[2], values[3])]
  end
end

while length(bots) > 0
  deleteBots = []
  for (k, v) in bots
    if length(v) == 2
      values = sort(v)
      if values[1] == 17 && values[2] == 61
        println(k)
      end
      instr = pipeline[k]
      for t in enumerate(instr)
        if t[2][1] == "bot"
          if t[2][2] ∉ keys(bots)
            bots[t[2][2]] = [values[t[1]]]
          else
            push!(bots[t[2][2]], values[t[1]])
          end
        else
          if t[2][2] ∉ keys(output)
            output[t[2][2]] = [values[t[1]]]
          else
            push!(output[t[2][2]], values[t[1]])
          end
        end
      end
      push!(deleteBots, k)
    end
  end
  for d in deleteBots
    delete!(bots, d)
  end
end

println(prod([output[i][1] for i in 0:2]))
