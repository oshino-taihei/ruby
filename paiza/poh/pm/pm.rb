# coding: utf-8
$m = gets.chomp.to_i
$n = gets.chomp.to_i
$offices = []
$n.times {
  office = gets.chomp.split(" ").map(&:to_i)
  $offices.push(office)
}

# 最小コスト (全コストのトータルで初期化)
$min_cost = $offices.inject(0) { |sum,o| sum + o[1] }

################################
#  i:i番目までのoffice
#  num_total:人数のトータル
#  cost_total: コストのトータル
################################
def solve(i, num_total, cost_total)
  # プロジェクト最小人数を満たしているなら、最小コストを更新
  $min_cost = [$min_cost, cost_total].min if num_total >= $m

  # 全てのofficeを探索したなら終了
  if i == $n then
    return true
  else
    # i番目を加える場合
    next_num_total = num_total + $offices[i][0]
    next_cost_total = cost_total + $offices[i][1]
    solve(i+1, next_num_total, next_cost_total)

    # i番目を加えない場合
    solve(i+1, num_total, cost_total)
  end
  return true
end

solve(0, 0, 0)
puts $min_cost
