# -- coding: utf-8
words = gets.split(" ")
wc = Hash.new(0)
words.each { |w|
  wc[w] += 1
}

wc.each{ |key,value|
  puts "#{key} #{value}"
}

