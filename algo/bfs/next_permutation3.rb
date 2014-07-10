def permutation1(pos, n, perm)
  if (pos == n) then
    print perm
    puts
    return
  end

  0.upto(n) do |i|
      permutation1(pos + 1, n, perm)
      perm[pos] = i
  end

end

permutation1(0, 4, [])
