using DataStructures

data =hcat(map(x -> split(chop(x),  ""), readlines(open("input.txt", "r")))...)
charOcc = Array(OrderedDict{Char, Int}, size(data, 1))
for line in 1:size(data, 1)
  charOcc[line] = OrderedDict{Char, Int}()
  for c in 'a':'z'
    charOcc[line][c] = length(matchall(Regex("$c"), join(data[line,:])))
  end
end

println(join(map(x -> sort(collect(x), by=x->x[2], rev=true)[1][1], charOcc)))
println(join(map(x -> sort(collect(x), by=x->x[2], rev=false)[1][1], charOcc)))
