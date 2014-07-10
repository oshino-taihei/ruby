# -- coding: utf-8
list = gets.chomp!.split(" ").map(&:to_i)
target = gets
puts "init=#{list}, target=#{target}"

def dfs(list, nlist, index)
  return true if index >= list.size
  nlist1 = nlist.clone.push(list[index])
  nlist2 = nlist.clone
  puts "#{nlist1}" if dfs(list, nlist1, index+1)
  puts "#{nlist2}" if dfs(list, nlist2, index+1)
end

dfs(list, [], 0)

