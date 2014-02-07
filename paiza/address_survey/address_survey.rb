# -- coding: utf-8
linesize = gets.chomp.to_i
linesize.times {
	ipaddress = gets.chomp
	if ipaddress =~ /^\d{1,3}.\d{1,3}\.\d{1,3}\.\d{1,3}$/
		puts "True"
	else
		puts "False"
	end
}
