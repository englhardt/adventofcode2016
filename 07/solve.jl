data = map(x -> chop(x), readlines(open("input.txt", "r")))

function isABBA(x)
  return x[1] == x[4] && x[2] == x[3] && x[1] != x[2]
end

function isABA(x)
  return x[1] == x[3] && x[1] != x[2]
end

println(length(filter(x -> begin
    ip = split(x, ['[', ']'])[1:2:end]
    hyp = split(x, ['[', ']'])[2:2:end]
    valid = false
    for y in ip
      for i in 1:length(y)-3
        valid |= isABBA(y[i:i+3])
      end
    end
    if valid
      for y in hyp
        for i in 1:length(y)-3
          valid &= !isABBA(y[i:i+3])
        end
      end
    end
    return valid
  end, data)))

println(length(filter(x -> begin
    ip = split(x, ['[', ']'])[1:2:end]
    hyp = split(x, ['[', ']'])[2:2:end]
    valid = false
    targetList = []
    for y in ip
      for j in 1:length(y)-2
        if isABA(y[j:j+2])
          valid = true
          push!(targetList, "$(y[j+1])$(y[j])$(y[j+1])")
        end
      end
    end
    if valid && !isempty(targetList)
      curFound = false
      for t in targetList
        for y in hyp
          curFound |= contains(y, t)
        end
      end
      valid &= curFound
    end
    return valid
  end, data)))
