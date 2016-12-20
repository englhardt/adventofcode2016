type Elf
  number
  prev
  next
end

function solve(input)
  elves = map(x -> Elf(x, 0, 0), collect(1:input))
  for i in 2:input - 1
    elves[i].prev = elves[i - 1]
    elves[i].next = elves[i + 1]
  end
  elves[1].prev = elves[input]
  elves[1].next = elves[2]
  elves[input].prev = elves[input - 1]
  elves[input].next = elves[1]

  cur = elves[1]
  remove = elves[1]
  len = input

  while len > 1
    dist = floor(len / 2)
    j = 0
    while j < dist
      remove = remove.next
      j += 1
    end

    remove.prev.next = remove.next
    remove.next.prev = remove.prev

    len -= 1
    cur = cur.next
    remove = cur
    if len % 1000 == 0
      println(len)
    end
  end
  return cur.number
end

function fastSolve(n)
  a = 1
  while 3 * a <= n
    a *= 3
  end
  if a == n
    return n
  end
  result = n - a
  for i in 2*a + 1:n
    result += 1
  end
  return result
end

#for i in 2:100
#  println("Result[", i, "] ", solve(i), ", fastSolve: ", fastSolve(i))
#end
#println(all(map(x -> solve(x) == fastSolve(x), collect(2:100))))

println(fastSolve(3014387))
