# -- coding: utf-8
line = gets.chomp.split(" ")
$columns = line[0].to_i
$rows = line[1].to_i

$map = Array.new
$rows.times {
  $map.push(gets.chomp.split(" ").map(&:to_i))
}

# 島ならば島の部分を全て0に変え、trueを返す
def check_island(i, j)
  $map[i][j] = 0
  next_ijs = [[i-1,j],[i,j-1],[i,j+1],[i+1,j]]
  next_ijs.each {|n|
    ni = n[0]
    nj = n[1]
    check_island(ni, nj) if ni >= 0 && ni < $rows && nj >= 0 && nj < $columns && $map[ni][nj] == 1
  }
end

# MAIN
$islands = 0
$rows.times {|i|
  $columns.times {|j|
    if $map[i][j] == 1 then
      check_island(i, j)
      $islands += 1
    end
  }
}
puts "#{$islands}"
