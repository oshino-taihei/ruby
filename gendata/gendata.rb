#!/usr/bin/ruby
require 'date'

# 引数チェック
unless ARGV.size == 1
	puts "#{$0} : <property file>"
	exit 1
end
propfile=ARGV[0]

# ランダム文字列を取得
def random_str(digit = 8)
	o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
	return (0..digit).map { o[rand(o.length)] }.join
end

# 指定された区間の日付をランダムに生成
def random_date(from, to, format)
	days = to - from + 1
	return (from + rand(days)).strftime(format)
end


# プロパティファイルをハッシュデータとして読み込み
prop = eval File.read(propfile)
table = prop[:table]
columns = prop[:columns].map { |item| item[:name] }
num = prop[:rows]

num.times do |i|
	values = []
	prop[:columns].each do |col|
		case col[:type]
		when :date # 日付
			value = random_date(Date.parse(col[:from]), Date.parse(col[:to]), col[:format]).to_s
		when :string # 文字列
			case col[:format]
			when :seq # 連番
				value = ((i+1) % (10 ** col[:digit].to_i)).to_s.rjust(col[:digit], '0')
			when :random # 乱数
				value = rand(col[:digit] * 10 - 1).to_s.rjust(col[:digit], '0')
			when :email # メールアドレス
				value = "x" + (i+1).to_s.rjust(10, '0') + "@" + random_str(4) + ".co.jp"
			when :url # URL
				value = "http://x" + (i+1).to_s.rjust(10, '0') + ".co.jp/" + random_str(6) + ".html"
			when :const # 定数
				constants = col[:values]
				value = constants[rand(constants.size)]
			end
		end
		values << value.to_s
	end
	puts "#{values.join("\t")}"
end

