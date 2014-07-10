# -- coding: utf-8
lines = []
while line = gets
  lines.push line.chomp!.to_i
end

def calc_around(l1, l2, l3)
  lines = [l1, l2, l3].sort
  if lines[0] + lines[1] > lines[2] then
    return l1 + l2 + l3
  else
    return 0
  end
end


max = 0
lines.each_with_index { |li, i|
  first = li
  lines.each_with_index { |lj, j|
    next if i == j
    second = lj
    lines.each_with_index {|lk, k|
      next if i == k or j == k
      third = lk
      around = calc_around(first,second,third)
      puts "(#{first},#{second},#{third}) => #{around}"
      max = [max, around].max
    }
  }
}
puts "max = #{max}"
