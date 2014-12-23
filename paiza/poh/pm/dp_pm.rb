# coding: utf-8
$m = gets.chomp.to_i # プロジェクト人数の最低人数
$n = gets.chomp.to_i # オフィスの数
$offices = []
$max_num = 0 # 人数トータル
$max_cost = 0 # 最大コスト(全コストのトータルとする)
$n.times {
  office = gets.chomp.split(" ").map(&:to_i)
  $offices.push(office)
  $max_num += office[0]
  $max_cost += office[1]
}

################################
# arg:
#  n:officeの最大値
#  max_num: 最大人数
################################
def solve(n, max_num)
  dp = Array.new($n).map { Array.new($max_num) }
  n.times do |i|
    num  = $offices[i][0] #オフィスiの人数
    cost = $offices[i][1] #オフィスiのコスト
    # 最大人数から0まで降順に探索(昇順だと同じオフィスを複数回数えてしまうため)
    max_num.times do |j|
      puts "i=#{i},j=#{j}"
      if i == 0 && j == num
        dp[i][j] = cost
      elsif
        next_num = j + num
        next_cost = dp[i-1][j] + cost
        dp[i][next_num] = [dp[i][next_num], next_cost].compact.min if next_num < $max_num
      end
    end
  end
  return dp
end

dp = solve($n, $max_num)
# dp配列の最低人数番目のインデックス以降からnilを除外したもののうち、最小の値が求めるべき最小コスト
p dp
#p dp[$m..-1].compact.min
