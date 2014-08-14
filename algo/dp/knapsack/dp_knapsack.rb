# coding: utf-8
# item = [weight, value]
#$items = [[2,3], [1,2], [3,4], [2,2]]
#$max_weight = 5
$items = [[168,496],[10,45],[145,325],[60,347],[10,61],[124,486],[124,446],[105,22],[126,110],[184,475]]
$max_weight = 300
$size = $items.size

# ナップサック問題をDPで解く
$MAX_N = $size + 1
$MAX_W = $max_weight + 1
$dp = Array.new($MAX_N).map { Array.new($MAX_W, 0) }
def solve(i, max)
  i.downto(0) {|j|
    0.upto(max) {|k|
      if k < $items[j][0] then
        $dp[j][k] = $dp[j + 1][k]
      else
        $dp[j][k] = [$dp[j + 1][k], $dp[j + 1][k - $items[j][0]] + $items[j][1]].max
      end
    }
  }
end

solve($size - 1, $max_weight)
puts $dp[0][$max_weight]
