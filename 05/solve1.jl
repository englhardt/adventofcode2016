using Nettle
h = Hasher("md5")

input = "ffykfhsq"
result = ""
i = 1
while length(result) < 8
  hash = hexdigest!(update!(h, "$input$i"))
  if ismatch(r"^00000", hash)
    result *= "$(hash[6])"
  end
  i += 1
end
println(result)
