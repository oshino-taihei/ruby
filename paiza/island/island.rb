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
  return false if i < 0 || i >= $rows || j < 0 || j >= $columns
  return false if $map[i][j] == 0
  $map[i][j] = 0
  check_island(i-1,j  ) #上
  check_island(i  ,j-1) #左
  check_island(i  ,j+1) #右
  check_island(i+1,j  ) #下

  return true
end

# MAIN
$islands = 0
$rows.times {|i|
  $columns.times {|j|
    $islands += 1 if check_island(i, j)
  }
}
puts "#{$islands}"
