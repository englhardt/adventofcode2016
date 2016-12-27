using Combinatorics
data = map(x -> chop(x), readlines(open("input.txt")))
validFields = ".01234567"
function validField(x, y)
  return y ∈ eachindex(data) && x ∈ eachindex(data[y]) && data[y][x] ∈ validFields
end

numberLocations = Dict()
for y ∈ eachindex(data)
  for x ∈ eachindex(data[y])
    if isnumber(data[y][x])
      numberLocations[parse(Int, data[y][x])] = [x, y]
    end
  end
end

distances = Dict{Array{Int, 1}, Int}()
moves = [[-1, 0], [0, -1], [1, 0], [0, 1]]
for i in keys(numberLocations)
  paths = [[numberLocations[i]]]
  seen = Set()
  push!(seen, numberLocations[i])
  while !isempty(paths)
    newPaths = []
    for p ∈ paths
      curPos = last(p)
      if curPos ∈ values(numberLocations) && length(p) > 1
        distances[[i, parse(Int, data[curPos[2]][curPos[1]])]] = length(p) - 1
      end
      for m in moves
        newPos = curPos + m
        if newPos ∉ seen && validField(newPos...)
          push!(newPaths, push!(copy(p), newPos))
          push!(seen, newPos)
        end
      end
    end
    paths = newPaths
  end
end

visitOrder = collect(1:length(numberLocations) - 1)
combinations = map(x -> nthperm(visitOrder, x), 1:factorial(length(numberLocations) - 1))
println(minimum(map(o -> begin
    path = prepend!(copy(o), [0])
    distance = 0
    for i in 1:length(path) - 1
      distance += distances[[path[i], path[i+1]]]
    end
    return distance
  end, combinations)))
println(minimum(map(o -> begin
    path = append!(prepend!(copy(o), [0]), [0])
    distance = 0
    for i in 1:length(path) - 1
      distance += distances[[path[i], path[i+1]]]
    end
    return distance
  end, combinations)))
