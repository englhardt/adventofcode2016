data = map(x -> chop(x), readlines(open("input.txt")))
data = hcat(map(x -> map(parse, matchall(r"\d+", x)), data)...).'

pos = data[:, 4]
range = data[:, 2]

function simulate(pos)
  t = 0
  while !all((pos + collect(0:length(pos) - 1)) .% range .== pos[1])
    pos = (pos + 1) .% range
    t += 1
  end
  println(t - 1)
end

simulate(pos)
push!(pos, 0)
push!(range, 11)
simulate(pos)
