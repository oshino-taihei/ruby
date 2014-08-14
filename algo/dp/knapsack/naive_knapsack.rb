# coding: utf-8
# item = [weight, value]
#$items = [[2,3], [1,2], [3,4], [2,2]]
#$max_weight = 5
$items = [[168,496],[10,45],[145,325],[60,347],[10,61],[124,486],[124,446],[105,22],[126,110],[184,475]]
$max_weight = 300
$size = $items.size

# ナップサック問題をナイーブな二分木で解く
def solve(i, max)
  # アイテムがない
  if i == $size then
    return 0
  # アイテムが入らない
  elsif $items[i][0] > max then
    return solve(i+1, max)
  # アイテムを入れる場合と入れない場合の価値が大きい方
  else
    return [solve(i+1, max-$items[i][0]) + $items[i][1], solve(i+1, max)].max
  end
end

ret = solve(0, $max_weight)
puts ret
