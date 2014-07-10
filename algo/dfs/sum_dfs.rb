# -- coding: utf-8
list = gets.chomp!.split(" ").map(&:to_i)
target = gets.chomp!.to_i
puts "init=#{list}, target=#{target}"

def dfs(list, nlist, index, target)
  return true if nlist.inject(:+) == target
  return false if index >= list.size
  nlist1 = nlist.clone.push(list[index])
  nlist2 = nlist.clone
  puts "sum of #{nlist1} = #{target}" if dfs(list, nlist1, index+1, target)
  puts "sum of #{nlist2} = #{target}" if dfs(list, nlist2, index+1, target)
end

dfs(list, [], 0, target)

