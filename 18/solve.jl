input = "^..^^.^^^..^^.^...^^^^^....^.^..^^^.^.^.^^...^.^.^.^.^^.....^.^^.^.^.^.^.^.^^..^^^^^...^.....^....^."

function calc(rows)
  result = [input]
  r = input
  for i in 2:rows
    newResult = []
    for j in 1:length(r)
      seq = ""
      if j == 1
        seq = "." * r[j:j+1]
      elseif j == length(r)
        seq = r[j-1:j] * "."
      else
        seq = r[j-1:j+1]
      end
      if seq == "^^." || seq == ".^^" || seq == "^.." || seq == "..^"
        push!(newResult, "^")
      else
        push!(newResult, ".")
      end
    end
    newResult = join(newResult)
    r = newResult
    push!(result, newResult)
  end
  return result
end

println(sum(map(x -> count(y -> y == '.', x), calc(40))))
println(sum(map(x -> count(y -> y == '.', x), calc(400000))))
