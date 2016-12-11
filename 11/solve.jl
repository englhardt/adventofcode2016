function readData()
  data = map(x -> chop(x), readlines(open("input.txt", "r")))
  state = Array{Int}(4)
  for (i, d) in enumerate(data)
    state[i] = length(matchall(r"(\w+ generator|\w+-compatible microchip)", d))
  end
  return state
end

function computeMoves(state)
  # N items on floor i need 2 * N - 3 to move all N items up one floor
  moves = 0
  for i in 1:3
    moves += (2 * state[i] - 3)
    state[i+1] += state[i]
  end
  return moves
end

function partOne(state)
  return computeMoves(state)
end

function partTwo(state)
  state[1] += 4
  return computeMoves(state)
end

println(partOne(readData()))
println(partTwo(readData()))
