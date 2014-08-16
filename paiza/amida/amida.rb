# coding: utf-8
l = gets.chomp.split(" ").map(&:to_i)
$L = l[0]
$n = l[1]
$m = l[2]

$lines = []
$m.times { |i|
  l = gets.chomp.split(" ").map(&:to_i)
  $lines.push(l)
}

# i番目の列の上から[x]cmのところからアミダを開始する
# return : ゴールの列番号
def amida(i, x)
  # 選択する線を保持
  next_i = nil
  next_x = nil
  target_x = nil

  # 曲がる線を検索
  $lines.each { |line|
    # 右向きの線がある場合
    if line[0] == i && line[1] < x then
      # 曲がる線の候補がなければ採用
      unless next_i then
        next_i = i+1
        next_x = line[2]
        target_x = line[1]
      end
      # 候補があれば、より曲がる位置がxに近い方を採用
      if line[1] > target_x then
        next_i = i+1
        next_x = line[2]
        target_x = line[1]
      end
    end

    # 左向きの線がある場合
    if line[0] == (i-1) && line[2] < x then
      # 曲がる線の候補がなければ採用
      unless next_i then
        next_i = i-1
        next_x = line[1]
        target_x = line[2]
      end
      # 候補があれば、より曲がる位置がxに近い方を採用
      if line[2] > target_x then
        next_i = i-1
        next_x = line[1]
        target_x = line[2]
      end
    end
  }

  # 曲がる線があるならそこからアミダを再開
  return amida(next_i, next_x) if next_i && next_x

  # なければその列がゴール
  return i
end

# 第1列の一番下から実行
puts amida(1, $L)
