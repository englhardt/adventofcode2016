data = map(x -> split(chop(x)), readlines(open("input.txt")))[3:end]

count = 0
for x in data
  if x[3] != "0T"
    for y in data
      if x != y
        usedX = parse(chop(x[3]))
        availableY = parse(chop(y[4]))
        if usedX <= availableY
          count += 1
        end
      end
    end
  end
end

grid = Array{String}(30, 35)
emptyCord = []

for d in data
  cord = map(parse, matchall(r"\d+", d[1])) + 1
  if d[3] == "0T"
    grid[cord[1], cord[2]] = "_"
    emptyCord = cord
  elseif parse(chop(d[3])) > 100
    grid[cord[1], cord[2]] = "#"
  else
    grid[cord[1], cord[2]] = "."
  end
end

grid[30, 1] = "G"

for i in 1:size(grid, 2)
  println(join(grid[:,i]))
end
# move '_' to x=29 and y=1 then, swap G one left 28 times (requires 5 moves)
# to x=2, y = 1 and one final swap to x=1, y=1 without moving '_' back
println(emptyCord[1] - 1 + emptyCord[2] - 1 + 28 + 28 * 5 + 1)
