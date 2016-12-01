function readData()
  inputStream = open("input.txt", "r")
  input = readline(inputStream)
  close(inputStream)
  return input
end

function parseInput(input::String)
  return map(x-> begin
        return (x[1], parse(Int, x[2:end]))
    end, split(input, ", "))
end

# Part One
function partOne(data)
  point = (0, 0)
  face = 0
  directions = Dict(0 => [0, 1], 1 => [1, 0], 2 => [0, -1], 3 => [-1, 0])

  for x in data
    if x[1] == 'R'
      face = mod(face + 1, 4)
    else
      face = mod(face - 1, 4)
    end
    point = (point[1] + x[2] * directions[face][1], point[2])
    point = (point[1], point[2] + x[2] * directions[face][2])
  end
  return abs(point[1]) + abs(point[2])
end

# Part Two
function partTwo(data)
  point = (0, 0)
  face = 0
  directions = Dict(0 => [0, 1], 1 => [1, 0], 2 => [0, -1], 3 => [-1, 0])

  visitedPositions = Set()
  for x in data
    if x[1] == 'R'
      face = mod(face + 1, 4)
    else
      face = mod(face - 1, 4)
    end
    for _ in range(1, x[2])
      point = (point[1] + directions[face][1], point[2])
      point = (point[1], point[2] + directions[face][2])
      if in(point, visitedPositions)
        return abs(point[1]) + abs(point[2])
      end
      push!(visitedPositions, point)
    end
  end
end

function main()
  data = parseInput(readData())
  println(partOne(data))
  println(partTwo(data))
end

main()
