data = map(x -> chop(x), readlines(open("input.txt", "r")))[1]

function decompress(data, recursive)
  outputLength = 0
  i = 1
  while i <= length(data)
    marker = search(data, '(', i)

    if marker == 0
      return outputLength + length(data) - (i - 1)
    else
      outputLength += marker - i

      m = match(r"\((\d+)x(\d+)\)", data[i:end])
      decompLength = parse(Int, m.captures[1])
      decompRepeats = parse(Int, m.captures[2])

      if recursive
        outputLength += decompRepeats * decompress(data[i+length(m.match):i+length(m.match)+decompLength-1], true)
      else
        outputLength += decompRepeats * decompLength
      end

      i += decompLength + length(m.match)
    end
  end
  return outputLength
end

println(decompress(data, false))
println(decompress(data, true))
