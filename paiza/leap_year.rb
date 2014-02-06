# -- coding: utf-8
def is_leap_year?(year)
	if year % 400 == 0
		return true
	elsif year % 100 == 0
		return false
	elsif year % 4 == 0
		return true
	end
	return false
end

while year = gets
	break if year.nil?
	year.chomp!
	if is_leap_year?(year.to_i)
		puts "#{year}はうるう年"
	else
		puts "#{year}はうるう年ではない"
	end
end
