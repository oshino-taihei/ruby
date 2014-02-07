# -- coding: utf-8
definitions = gets.chomp.split(" ")
column_num = definitions[0].to_i
row_num = definitions[1].to_i
topk = definitions[2].to_i

def calc_score(c, x)
	score = 0
	if c.size == 0 or x.size == 0
		return 0
	end
	c.each_index { |i|
		score += (c[i].to_f * x[i].to_f)
	}
	return score.round(0)
end

c = []
scores = []
(row_num+1).times { |i|
	items = gets.chomp.split(" ")
	if i == 0
		c = items
	else
		scores[i-1] = calc_score(c, items)
	end
}
scores.sort!.reverse!

topk.times { |k|
	puts scores[k]
}