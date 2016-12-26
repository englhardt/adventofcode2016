function solve(data, reg)
  i = 1
  while i <= length(data)
    s = data[i]
    #println(i, " ", s, reg)
    if i + 5 <= length(data) && s == ["cpy","b","c"] && data[i+1] == ["inc","a"] && data[i+2] == ["dec","c"] &&
      data[i+3] == ["jnz","c","-2"] && data[i+4] == ["dec","d"] && data[i+5] == ["jnz","d","-5"]
      reg["a"] += reg["d"] * reg["b"]
      reg["d"] = 0
      reg["c"] = 0
      i += 6
      continue
    end
    if i + 2 <= length(data) && s == ["dec", "d"] && data[i+1] == ["inc", "c"] && data[i+2] == ["jnz", "d", "-2"]
      reg["c"] += reg["d"]
      reg["d"] = 0
      i += 3
      continue
    end
    if i+2 <= length(data) && s == ["inc", "a"] && data[i+1] == ["dec", "d"] && data[i+2] == ["jnz", "d", "-2"]
      reg["a"] += reg["d"]
      reg["d"] = 0
      i += 3
      continue
    end
    if s[1] == "inc"
      reg[s[2]] += 1
    elseif s[1] == "dec"
      reg[s[2]] -= 1
    elseif s[1] == "cpy"
      if !(isnumber(s[2]) && isnumber(s[3]))
      if typeof(parse(s[2])) != Symbol
          reg[s[3]] = parse(s[2])
        else
          reg[s[3]] = reg[s[2]]
        end
      end
    elseif s[1] == "tgl"
      target = 0
      if isnumber(s[2])
        target = parse(s[2])
      else
        target = reg[s[2]]
      end
      if target + i > 0 && target + i <= length(data)
        targetInstr = data[target + i]
        if targetInstr[1] == "inc"
          targetInstr[1] = "dec"
        elseif targetInstr[1] == "dec" || targetInstr[1] == "tgl"
          targetInstr[1] = "inc"
        elseif targetInstr[1] == "jnz"
          targetInstr[1] = "cpy"
        elseif targetInstr[1] == "cpy"
          targetInstr[1] = "jnz"
        end
      end
    end
    if s[1] == "jnz" && (isnumber(s[2]) && parse(s[2]) != 0 || reg[s[2]] != 0)
      if typeof(parse(s[3])) != Symbol
        i += parse(s[3])
      else
        i += reg[s[3]]
      end
    else
      i += 1
    end
  end
  return reg
end

data = map(x -> chop(x), readlines(open("input.txt", "r")))
data = map(x -> split(x, " "), data)
println(solve(deepcopy(data), Dict("a" => 7, "b" => 0, "c" => 0, "d" => 0))["a"])
println(solve(data, Dict("a" => 12, "b" => 0, "c" => 0, "d" => 0))["a"])
