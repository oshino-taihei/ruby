# coding: utf-8
$m = gets.chomp.to_i # プロジェクト人数の最低人数
$n = gets.chomp.to_i # オフィスの数
$offices = []
$n.times {
  office = gets.chomp.split(" ").map(&:to_i)
  $offices.push(office)
}

# 人数トータル
$max_num = $offices.inject(0) { |sum,o| sum + o[0] }

# 最大コスト (全コストのトータルとする)
$max_cost = $offices.inject(0) { |sum,o| sum + o[1] }

################################
# arg:
#  n:officeの最大値
#  max_num: 最大人数
################################
def solve(n, max_num)
  dp = Array.new($max_num)
  n.times do |i|
    num  = $offices[i][0] #オフィスiの人数
    cost = $offices[i][1] #オフィスiのコスト
    # 最大人数から0まで降順に探索(昇順だと同じオフィスを複数回数えてしまうため)
    (max_num-1).downto(0) do |j|
      if dp[j].nil?
        dp[j] = cost if j == num
      elsif j + num < max_num
        next_num  = j + num
        next_cost = dp[j] + cost 
        dp[next_num] = [dp[next_num], next_cost].compact.min
      end
    end
  end
  return dp
end

dp = solve($n, $max_num)
# dp配列の最低人数番目のインデックス以降からnilを除外したもののうち、最小の値が求めるべき最小コスト
p dp[$m..-1].compact.min
