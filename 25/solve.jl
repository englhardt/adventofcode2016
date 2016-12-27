function solve(data, reg)
  i = 1
  result = ""
  while i <= length(data)
    s = data[i]
    #println(i, " ", s, reg)
    if startswith(result, "010101010101")
      return true
    elseif startswith(result, "1") || contains(result, "11") || contains(result, "00")
      return false
    end
    if i + 5 <= length(data) && s == ["cpy","182","b"] && data[i+1] == ["inc","d"] && data[i+2] == ["dec","b"] &&
      data[i+3] == ["jnz","b","-2"] && data[i+4] == ["dec","c"] && data[i+5] == ["jnz","c","-5"]
      reg["d"] += 182 * 14
      reg["b"] = 0
      reg["c"] = 0
      i += 6
      continue
    end
    if i + 9 <= length(data) && s == ["cpy", "a", "b"] && data[i+1] == ["cpy", "0", "a"] && data[i+2] == ["cpy", "2", "c"] &&
      data[i+3] == ["jnz","b","2"] && data[i+4] == ["jnz","1","6"] && data[i+5] == ["dec","b"] && data[i+6] == ["dec","c"] &&
      data[i+7] == ["jnz","c","-4"] && data[i+8] == ["inc","a"] && data[i+9] == ["jnz","1","-7"]
      reg["c"] = 2 - mod(reg["a"], 2)
      reg["a"] = Int(floor(reg["a"] / 2))
      i += 10
      continue
    end
    if s[1] == "inc"
      reg[s[2]] += 1
    elseif s[1] == "dec"
      reg[s[2]] -= 1
    elseif s[1] == "out"
      if !isnumber(s[2])
        result *= string(reg[s[2]])
      else
        result *= s[2]
      end
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
    if s == ["jnz", "0", "0"]
      i += 1
      continue
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
  return startswith(result, "010101010101")
end

data = map(x -> split(chop(x)), readlines(open("input.txt")))
for i in 1:1000
  if solve(data, Dict("a" => i, "b" => 0, "c" => 0, "d" => 0))
    println(i)
    break
  end
end
