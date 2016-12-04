using DataStructures

function readData()
  inputStream = open("input.txt", "r")
  input = readlines(inputStream)
  close(inputStream)
  return input
end

function parseInput(input)
  return map(x -> begin
      splitText = match(r"(.*)-(\d+)\[(\w+)\]", chop(x)).captures
      return [replace(splitText[1], "-", " "), parse(Int, splitText[2]), splitText[3]]
    end, input)
end

data = parseInput(readData())

function calculateValue(roomName, sectorID, checksum)
  characterOccurences = OrderedDict{Char, Int}()
  for c in 'a':'z'
    characterOccurences[c] = length(matchall(Regex("$c"), roomName))
  end
  curChecksum = join(map(x -> x[1], sort(collect(characterOccurences), by=x->x[2], rev=true)[1:5]))
  if (curChecksum == checksum)
    return sectorID
  end
  return 0
end

function rotateString(roomName, sectorID)
  return join(map(x -> begin
      if x == ' '
        return ' '
      end
      return Char((Int(x) + sectorID - Int('a')) % 26 + Int('a'))
    end, roomName))
end

# Part One
function partOne(data)
  return sum(map(x -> calculateValue(x...), data))
end

# Part Two
function partTwo(data)
  validRooms = filter(x -> calculateValue(x...) > 0, data)
  decryptedNames = map(x -> (rotateString(x[1:2]...), x[2]), validRooms)
  return first(filter(x -> x[1] == "northpole object storage", decryptedNames))[2]
end

function main()
  data = parseInput(readData())
  println(partOne(data))
  println(partTwo(data))
end

main()
