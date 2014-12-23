# -- coding: utf-8
linesize = gets.chomp.to_i
list = []
linesize.times {
  list.push(gets.chomp.to_i)
}
puts list.sort!
