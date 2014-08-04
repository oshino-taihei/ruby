# -- coding: utf-8

# 迷路初期化
meiro = []
while line = gets
  meiro.push(line.chomp!.split(//))
end

# スタート地点を取得
def find_start(m) 
  m.each_with_index { |l, i|
    l.each_with_index { |c, j|
      return [i, j] if c == "S"
    }
  }
end
start = find_start(meiro)

# 迷路を探索
# m : 迷路の配列
# i,j : 現在位置
def find_goal(m, i, j)
  return 0 if m[i][j] == "G"
  
  puts "m[#{i}, #{j}] = #{m[i][j]}"

  # 現在位置を塗りつぶす
  m[i][j] = "#"

  # 左に進む
  return find_goal(m, i  ,j-1) + 1 if m[i][j-1] == "." || m[i][j-1] == "G"
  # 左に進む
  return find_goal(m, i  ,j+1) + 1 if m[i][j+1] == "." || m[i][j+1] == "G"
  # 上に進む
  return find_goal(m, i-1,j  ) + 1 if m[i-1][j] == "." || m[i-1][j] == "G"
  # 下に進む
  return find_goal(m, i+1,j  ) + 1 if m[i+1][j] == "." || m[i+1][j] == "G"
end

ans = find_goal(meiro, start[0], start[1])
puts ans
