data = map(x -> chop(x), readlines(open("input.txt")))
data = map(x -> map(parse, matchall(r"\d+", x)), data)
sort!(data, by=x -> x[1])

ip, total = 0, 0
i = 1
while ip < 2 ^ 32
  if ip >= data[i][1]
    if ip <= data[i][2]
      ip = data[i][2] + 1
    else
      i += 1
    end
  else
    if total == 0
      println(ip)
    end
    total += 1
    ip += 1
  end
end

println(total)
