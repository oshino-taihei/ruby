# coding: utf-8
$m = gets.chomp.to_i
$n = gets.chomp.to_i
$offices = []
$n.times {
  office = gets.chomp.split(" ").map(&:to_i)
  $offices.push(office)
}

$min_cost = -1
# arg: i(i番目までのoffice)
# return: [人数トータル, コストトータル]
def solve(i, num_total, cost_total)
  if i == $n then
    return true
  else
    # i番目を加える場合
    next_num_total = num_total + $offices[i][0]
    next_cost_total = cost_total + $offices[i][1]
    if next_num_total >= $m then
      $min_cost = [$min_cost, next_cost_total].min
      $min_cost = next_cost_total if $min_cost == -1
    end
    solve(i+1, next_num_total, next_cost_total)

    # i番目を加えない場合
    next_num_total = $offices[i][0]
    next_cost_total = $offices[i][1]
    if next_num_total >= $m then
      $min_cost = [$min_cost, next_cost_total].min
      $min_cost = next_cost_total if $min_cost == -1
    end
    solve(i+1, next_num_total, next_cost_total)
  end
  return true
end

solve(0, 0, 0)
puts $min_cost
