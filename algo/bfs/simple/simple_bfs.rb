# -- coding: utf-8
$vlist = gets.chomp!.split(" ").map(&:to_i)
$target = gets.to_i
puts "init=#{$vlist}, target=#{$target}"

# i: i番目まで探索済み、i番目以降から探索
# list: 現在作成したリスト
def dfs_sum(i, list)
  puts "i=#{i}, list=#{list}, listsum=#{list.inject(:+)}"
  return list.inject(:+) == $target if i == $vlist.size
  return true if dfs_sum(i+1, list)
  return true if dfs_sum(i+1, list.clone.push($vlist[i]))
  return false
end

ans = dfs_sum(0, [])
puts ans
