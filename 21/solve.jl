using Combinatorics
data = map(x -> split(chop(x)), readlines(open("input.txt")))

function scramble(word)
  for l in data
    if l[1] == "swap"
      if l[2] == "letter"
        x = l[3][1]
        y = l[6][1]
        map!(c -> begin
          if c == x return y
          elseif c == y return x
          else return c end
        end, word)
      else
        x = word[parse(l[3]) + 1]
        y = word[parse(l[6]) + 1]
        map!(c -> begin
          if c == x return y
          elseif c == y return x
          else return c end
        end, word)
      end
    elseif l[1] == "rotate"
      if l[2] == "left"
        word = circshift(word, -parse(l[3]))
      elseif l[2] == "right"
        word = circshift(word, parse(l[3]))
      else
        numShifts = findfirst(x -> x == l[7][1], word)
        if numShifts >= 5
          numShifts += 1
        end
        word = circshift(word, numShifts)
      end
    elseif l[1] == "reverse"
      word = reverse(word, parse(l[3]) + 1, parse(l[5]) + 1)
    elseif l[1] == "move"
      x = parse(l[3]) + 1
      y = parse(l[6]) + 1
      buf = word[x]
      newWord = copy(word)
      if x < y
        for i in x:y - 1
          newWord[i] = word[i + 1]
        end
      else
        for i in y + 1:x
          newWord[i] = word[i - 1]
        end
      end
      newWord[y] = buf
      word = newWord
    end
  end
  return join(word)
end

function descramble(target)
  word = collect('a':'h')
  for i in 1:factorial(8)
    p = nthperm(word, i)
    if scramble(p) == target
     return join(p)
    end
  end
end

println(scramble(collect('a':'h')))
println(descramble("fbgdceah"))
