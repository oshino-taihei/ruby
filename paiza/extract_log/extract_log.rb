# -- coding: utf-8
target = gets.chomp
linesize = gets.chomp.to_i

# 指定した検索パターンに対応する正規表現を返す
def get_regpattern(target)
	str = String.new(target)
	str.gsub!(".", "\\.")
	str.gsub!("*", "\\d{1,3}")
	str.gsub!(/\[\d{1,3}-\d{1,3}\]/, "\\d{1,3}")
	return Regexp.new("(#{str})")
end

# 指定したオクテットを取得
def get_octet(target, index)
	target =~ /^([^\.]*)\.([^\.]*)\.([^\.]*)\.([^\.]*)/
	matches =  /^([^\.]*)\.([^\.]*)\.([^\.]*)\.([^\.]*)/.match(target)
	return matches[index]
end
	
# 指定したオクテットが範囲指定されているならば、[最小値, 最大値]の形式の配列を取得
# 範囲指定されていないならば空配列
def get_range(target, index)
	octet = get_octet(target, index)
	octet =~ /\[(\d{1,3})-(\d{1,3})\]/
	if $1.nil? and $2.nil?
		ret = []
	else
		ret = [$1.to_i, $2.to_i]
	end
	return ret
end

r3rd_range = get_range(target, 3)
r4th_range = get_range(target, 4)
need_check_3rd = r3rd_range.size == 2
need_check_4th = r4th_range.size == 2

tarpattern = get_regpattern(target)
linesize.times {
	line = gets.chomp
	# IPアドレス形式のバリデーション
	values = line.split(" ")
	ipaddress = values[0]
	unless ipaddress =~ get_regpattern(target)
		next
	end

	# [0-100]の形式だった場合のバリデーション
	if need_check_3rd
		chkoctet = get_octet(ipaddress, 3).to_i
		next if chkoctet < r3rd_range[0] or chkoctet > r3rd_range[1] 
	end
	if need_check_4th
		chkoctet = get_octet(ipaddress, 4).to_i
		next if chkoctet < r4th_range[0] or chkoctet > r4th_range[1]
	end

	# 条件にマッチするログを整形して出力
	access_date = values[3].gsub!("[", "")
	request = values[6]
	puts "#{ipaddress} #{access_date} #{request}"
}
