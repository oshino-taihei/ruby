# coding: utf-8
# item = [weight, value]
#$items = [[2,3], [1,2], [3,4], [2,2]]
#$max_weight = 5
$items = [[168,496],[10,45],[145,325],[60,347],[10,61],[124,486],[124,446],[105,22],[126,110],[184,475]]
$max_weight = 300
$size = $items.size

# ナップサック問題をメモで記憶した二分木で解く
$MAX_N = 1000
$MAX_W = $max_weight
$dp = Array.new($MAX_N).map { Array.new($MAX_W) }
def solve(i, max)
  # メモ済み
  return $dp[i][max] if $dp[i][max]

  # アイテムがない
  if i == $size then
    ret = 0
  # アイテムが入らない
  elsif $items[i][0] > max then
    ret = solve(i+1, max)
  # アイテムを入れる場合と入れない場合の価値が大きい方
  else
    ret = [solve(i+1, max-$items[i][0]) + $items[i][1], solve(i+1, max)].max
  end

  # 結果をメモ
  $dp[i][max] = ret
  return ret
end

ret = solve(0, $max_weight)
puts ret
