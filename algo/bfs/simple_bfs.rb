# -- coding: utf-8
list = gets.chomp!.split(" ").map(&:to_i)
target = gets
puts "init=#{list}, target=#{target}"

def bfs(list, nlist, index)
  return true if index >= list.size
  nlist1 = nlist.clone.push(list[index])
  nlist2 = nlist.clone
  puts "#{nlist1}" if bfs(list, nlist1, index+1)
  puts "#{nlist2}" if bfs(list, nlist2, index+1)
end

bfs(list, [], 0)

