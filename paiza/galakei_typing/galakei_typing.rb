# -- coding: utf-8
str = gets
prevch = ""
ch_count = 0

one = [".","@","-","_","/"," = ","~","1"]
two = ["a","b","c","A","B","C","2"]
three = ["d","e","f","D","E","F","3"]
fore = ["g","h","i","G","H","I","4"]
five = ["j","k","l","J","K","L","5"]
six = ["m","n","o","M","N","O","6"]
seven = ["p","q","r","s","P","Q","R","S","7"]
eight = ["t","u","v","T","U","V","8"]
nine = ["w","x","y","z","W","X","Y","Z","9"]
types = [one,two,three,fore,five,six,seven,eight,nine]

str.split(//).each { |ch|
	if ch == "E"
		type = types[prevch.to_i - 1] 
		print type[ch_count % type.size]
		ch_count = 0
		prevch = ch
		next
	elsif ch == prevch
		ch_count += 1
	elsif prevch.empty? or prevch == "E"
		prevch = ch
		next
	else
		type = types[prevch.to_i - 1] 
		print type[ch_count % type.size]
		ch_count = 0
		prevch = ch
	end
}