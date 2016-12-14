using Nettle
h = Hasher("md5")
input = "qzyelonm"

computedHashs = Dict{Int, String}()
function getHash(x)
  if x ∉ keys(computedHashs)
    computedHashs[x] = hexdigest!(update!(h, "$input$x"))
  end
  return computedHashs[x]
end

i = 0
foundHashs = 0
while foundHashs < 64
  while !ismatch(r"(.)\1\1", getHash(i))
    i += 1
  end
  key = join(repeated(matchall(r"(.)\1\1", getHash(i))[1][1], 5))
  for j in (i:i+1000) + 1
    if contains(getHash(j), key)
      foundHashs += 1
      break
    end
  end
  i += 1
end

println(i - 1)
