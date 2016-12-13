function clear(x, y)
  value = x*x + 3*x + 2*x*y + y + y*y + 1364
  count(x -> x=='1', bin(value)) % 2 == 0
end

start = (1, 1)
steps = 0
traversed = Set([start])
partOne = NaN
partTwo = NaN

while isnan(partOne) || isnan(partTwo)
  nextPlaces = []
  for (x, y) in traversed
    for (i, j) in [(x-1, y), (x, y-1), (x+1, y), (x, y+1)]
      if i >= 0 && j >= 0 && (i, j) ∉ traversed && clear(i, j)
        push!(nextPlaces, (i, j))
      end
    end
  end
  push!(traversed, nextPlaces...)
  steps += 1
  if isnan(partOne) && (31, 39) ∈ traversed
    partOne = steps
  end
  if steps == 50
    partTwo = length(traversed)
  end
end

println(partOne)
println(partTwo)
