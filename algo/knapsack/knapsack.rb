# item = [weight, value]
#$items = [[2,3], [1,2], [3,4], [2,2]]
#$max_weight = 5
$items = [[168,496],[10,45],[145,325],[60,347],[10,61],[124,486],[124,446],[105,22],[126,110],[184,475]]
$max_weight = 300
$size = $items.size

# ナップサック問題をナイーブな二分木で解く
def solve_knapsack(i, max_weight)
  if (i == $size) then
    return {:value => 0, :list => []}
  elsif (max_weight < $items[i][0]) then
    return solve_knapsack(i + 1, max_weight)
  else
    # 入れる場合と入れない場合の最大値を採用
    inres = solve_knapsack(i + 1, max_weight - $items[i][0])
    outres = solve_knapsack(i + 1, max_weight)
    if (inres[:value] + $items[i][1] > outres[:value]) then
      inres[:value] += $items[i][1]
      inres[:list].push(i)
      return inres
    else
      return outres
    end
  end
end

#puts items
puts "items(weight,value) = #{$items}"
puts "max_weight = #{$max_weight}"
puts "answer = "
puts solve_knapsack(0, $max_weight)
