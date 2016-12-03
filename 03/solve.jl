function readData()
  inputStream = open("input.txt", "r")
  input = readlines(inputStream)
  close(inputStream)
  return input
end

function parseInput(input)
  data =  map(x -> replace(x, r"\s+(\d+)\s+(\d+)\s+(\d+)", s"\1 \2 \3"), input)
  return map(x -> map(y -> parse(Int, y), split(x, " ")), data)
end

# Part One
function partOne(data)
  return sum(map(x -> begin
      x = sort(x)
      return x[1] + x[2] > x[3]
    end, data))
end

# Part Two
function partTwo(data)
  data = hcat(data...)
  counter = 0
  for y in 1:size(data, 1)
    for x in 1:3:size(data, 2)
      curData = sort([data[y, x], data[y, x + 1], data[y, x + 2]])
      if curData[1] + curData[2] > curData[3]
        counter += 1
      end
    end
  end
  return counter
end

function main()
  data = parseInput(readData())
  println(partOne(data))
  println(partTwo(data))
end

main()
