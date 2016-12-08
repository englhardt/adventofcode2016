data = map(x -> chop(x), readlines(open("input.txt", "r")))

display = falses((6, 50))

function rect(x, y)
  display[1:y, 1:x] = true
end

function rotateRow(y, shift)
  display[y,:] = circshift(display[y,:], shift)
end

function rotateColumn(x, shift)
  display[:,x] = circshift(display[:,x], shift)
end

map(x -> begin
    strings = split(x, [' ', 'x', '='])
    if strings[1] == "rect"
      rect(parse(Int, strings[2]), parse(Int, strings[3]))
    else
      if strings[2] == "row"
        rotateRow(parse(Int, strings[4]) + 1, parse(Int, strings[6]))
      else
        rotateColumn(parse(Int, strings[5]) + 1, parse(Int, strings[7]))
      end
    end
  end, data)
println(sum(display))

for i in 1:6
  result = ""
  for j in 1:50
    if display[i, j]
      result *= "\u2586"
    else
      result *= " "
    end
  end
  println(result)
end
