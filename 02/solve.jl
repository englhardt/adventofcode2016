function readData()
  inputStream = open("input.txt", "r")
  input = readlines(inputStream)
  close(inputStream)
  return input
end

function parseInput(input)
  return map(x-> split(x, "")[1:end - 1], input)
end

function solve(data, keypad, start)
  modifier = Dict("R" => [1, 0], "L" => [-1, 0], "U" => [0, -1], "D" => [0, 1])
  point = start
  result = ""
  for l in data
    for x in l
      newPoint = point + modifier[x]
      newPoint = [max(min(size(keypad, 1), newPoint[1]), 1),
                  max(min(size(keypad, 1), newPoint[2]), 1)]
      if keypad[newPoint[2]][newPoint[1]] != "X"
        point = newPoint
      end
    end
    result *= keypad[point[2]][point[1]]
  end
  return result
end

# Part One
function partOne(data)
  keypad = [["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"]]
  return solve(data, keypad, [2, 2])
end

# Part Two
function partTwo(data)
  keypad = [["X", "X", "1", "X", "X"],
            ["X", "2", "3", "4", "X"],
            ["5", "6", "7", "8", "9"],
            ["X", "A", "B", "C", "X"],
            ["X", "X", "D", "X", "X"]]
  return solve(data, keypad, [1, 3])
end

function main()
  data = parseInput(readData())
  println(partOne(data))
  println(partTwo(data))
end

main()
