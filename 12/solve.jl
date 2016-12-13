function solve(data, reg)
  i = 1
  while i <= length(data)
    s = data[i]
    if s[1] == "inc"
      reg[s[2]] += 1
    elseif s[1] == "dec"
      reg[s[2]] -= 1
    elseif s[1] == "cpy"
      if isnumber(s[2])
        reg[s[3]] = parse(s[2])
      else
        reg[s[3]] = reg[s[2]]
      end
    end
    if s[1] == "jnz" && (isnumber(s[2]) && parse(s[2]) != 0 || reg[s[2]] != 0)
      i += parse(s[3])
    else
      i += 1
    end
  end
  return reg
end

data = map(x -> chop(x), readlines(open("input.txt", "r")))
data = map(x -> split(x, " "), data)
println(solve(data, Dict("a" => 0, "b" => 0, "c" => 0, "d" => 0))["a"])
println(solve(data, Dict("a" => 0, "b" => 0, "c" => 1, "d" => 0))["a"])
