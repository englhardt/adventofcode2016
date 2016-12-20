input = 3014387

presents = ones(Int, input)

while length(filter(x -> x > 0, presents)) > 1
  for i in 0:input - 1
    if presents[i + 1] > 0
      j = i + 1
      while presents[(j % input) + 1] == 0
        j += 1
      end
      presents[i + 1] += presents[(j % input) + 1]
      presents[(j % input) + 1] = 0
    end
  end
end
map(i -> if presents[i] > 0 println(i) end, collect(1:length(presents)))
