# -- coding: utf-8

# 迷路初期化
meiro = []
while line = gets
  meiro.push(line.chomp!.split(//))
end
$LX = meiro[0].size
$LY = meiro.size

# 移動4方向のベクトル
##    [下,右,上,左]
$dx = [1, 0, -1,  0]
$dy = [0, 1,  0, -1]

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
# q : 探索点のキュー
def find_goal(m, q)
  # キューが空になるまで探索
  while q.size > 0 do
    p = q.shift
    px = p[0]
    py = p[1]

    # ゴールに達したら探索終了
    break if m[px][py] == "G"
    
    puts "m[#{px}, #{py}] = #{m[px][py]}"

    # スタート地点ならば距離0
    m[px][py] = 0 if m[px][py] == "S"

    # 4方向に移動
    0.upto(3) {|d|
      nx = px + $dx[d]
      ny = py + $dy[d]
      # 移動可能かつ未訪ならばキューに入れ、距離を現在地+1で再帰的に探索
      if (0 <= nx && nx < $LX  && 0 <= ny && ny <= $LY && m[nx][ny] != "#" && m[nx][ny] == ".") then
        q.push([nx, ny])

        m[nx][ny] = m[px][py] + 1
      end

    }
  end

  return m
end

# 迷路を表示
def print_meiro(m)
  m.each {|l|
    l.each {|c|
      print c.to_s.ljust(2)
    }
    print "\n"
  }
end

queue = [start]
ans = find_goal(meiro, queue) 
print_meiro(ans)
