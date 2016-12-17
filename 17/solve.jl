using Nettle
h = Hasher("md5")

input = "pgflpeqp"
openDoorChars = "bcdef"

function validDirections(x, y, path)
  hash = hexdigest!(update!(h, path))
  validDirections = []
  if y > 1 && hash[1] ∈ openDoorChars
    push!(validDirections, [x, y - 1, path * "U"])
  end
  if y < 4 && hash[2] ∈ openDoorChars
    push!(validDirections, [x, y + 1, path * "D"])
  end
  if x > 1 && hash[3] ∈ openDoorChars
    push!(validDirections, [x - 1, y, path * "L"])
  end
  if x < 4 && hash[4] ∈ openDoorChars
    push!(validDirections, [x + 1, y, path * "R"])
  end
  return validDirections
end

paths = [[1, 1, input]]
valid = []
while !isempty(paths)
  newPaths = []
  for p in paths
    if p[1] == p[2] == 4
      push!(valid, p[3])
      continue
    end
    for d in validDirections(p[1], p[2], p[3])
      push!(newPaths, d)
    end
  end
  paths = newPaths
end

println(sort(valid, by=x -> length(x))[1][length(input) + 1:end])
println(length(sort(valid, by=x -> length(x), rev=true)[1]) - length(input))
