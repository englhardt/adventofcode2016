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

function getStretchedHash(x)
  key = getHash(x)
  for i in 1:2016
    key = hexdigest!(update!(h, key))
  end
  return key
end

i = 0
foundHashs = 0
while foundHashs < 64
  while !ismatch(r"(.)\1\1", getStretchedHash(i))
    i += 1
  end
  key = join(repeated(matchall(r"(.)\1\1", getStretchedHash(i))[1][1], 5))
  for j in (i:i+1000) + 1
    if contains(getStretchedHash(j), key)
      foundHashs += 1
      break
    end
  end
  i += 1
end

println(i - 1)
