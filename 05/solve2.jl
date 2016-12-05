using Nettle
h = Hasher("md5")

input = "ffykfhsq"
result = [" ", " ", " ", " ", " ", " ", " ", " "]
i = 1
while " " in result
  hash = hexdigest!(update!(h, "$input$i"))
  if ismatch(r"^00000", hash) && isdigit(hash[6])
    position = parse("$(hash[6])") + 1
    if position in 1:8 && result[position] == " "
      result[position] = "$(hash[7])"
    end
  end
  i += 1
end
println(join(result))
