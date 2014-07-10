def permutation1(pos, n, used, perm)
  if (pos == n) then
    print perm
    puts
    return
  end

  0.upto(n) do |i|
    if (!used[i]) then
      perm[pos] = i
      used[i] = true
      permutation1(pos + 1, n, used, perm)
      used[i] = false
    end
  end

end

permutation1(0, 4, [], [])
#permutation1(0, 4)
