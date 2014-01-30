# -- coding: utf-8
require "open-uri"
require "rubygems"
require "nokogiri"
require 'kconv'

#################
# DESCRIPTION
#  新築および中古のマンション検索結果ページから自動でページングして物件情報をtsv出力する
# USAGE
#  1. http://suumo.jp/　のページの新築マンション、または中古マンションページで検索する
#  2. 中古の場合はシンプル一覧表示にする
#  3. URLをコピーし、本プログラムの**suumo URL**のurl変数にセット
#  4. 本プログラムの**物件一覧取得処理**の部分を新築・中古に応じて関数をコメントイン・アウトする
#  5. 以下のコマンドで実行すると、本プログラムと同パスにsuumo.tsvが生成される
#     $ ruby suumo.rb
#  DEPENDENCIES
#   nokogiri: HTMLスクレイピングライブラリ。以下のコマンドでインストール
#     $ gem install nokogiri
#################

# 物件クラス
class Property
	# 共通
	attr_accessor :name, :url, :price, :area, :address, :station, :room
	# 新築
	attr_accessor :period
	# 中古
	attr_accessor :built_date, :balcony

	# ヘッダをタブ区切りで取得
	def self.header_tsv
		return "物件名\t期\t販売価格\t専有面積\t所在地\tバルコニー\t沿線・駅\t間取り\t築年月\tURL"
	end

	# 各項目をタブ区切りで取得
	def to_tsv
		return "#{@name}\t#{@period}\t#{@price}\t#{@area}\t#{@address}\t#{@balcony}\t#{@station}\t#{@room}\t#{@built_date}\t#{@url}"
	end
end

# suumo物件一覧ページクラス
class PropertyListPage
	SUUMO_DOMAIN = 'http://suumo.jp'
	def initialize(url)
		charset = nil
		html = open(url) do |f|
	  		charset = f.charset
	  		f.read
		end
		@doc = Nokogiri::HTML.parse(html.toutf8, nil, charset)
	end

	# 物件クラスのリストを返す (シンプル一覧表示のページ: 中古マンション)
	def make_simple_property_list
		# 物件一覧を取得
		properties = @doc.xpath('//*[@id="js-bukkenList"]//div[@class="property_unit-content"]')
		# 物件ごとに各項目を取得
		prop_list = []
		properties.each { |property|
			prop = Property.new
			# 物件名・詳細ページのURLを取得
			prop.name = property.xpath('./div[@class="property_unit-header"]/h2[@class="property_unit-title_wide"]/a/text()')
			prop.url = "#{SUUMO_DOMAIN}#{property.xpath('./div[@class="property_unit-header"]/h2[@class="property_unit-title_wide"]/a/@href')}"

			# 各種項目値を取得
			dottable = property.xpath('.//div[@class="dottable dottable--cassette"]') 
			dottable_lines = dottable.xpath('./div[@class="dottable-line"]')
			# 販売価格
			prop.price = dottable_lines[0].xpath('.//dd')[0].xpath('./span/text()')
			# 専有面積
			prop.area = dottable_lines[0].xpath('.//dd')[1].xpath('./text()')
			# 所在地
			prop.address = dottable_lines[1].xpath('.//dd')[0].xpath('./text()')
			# バルコニー
			prop.balcony = dottable_lines[1].xpath('.//dd')[1].xpath('./text()')
			# 沿線・駅
			prop.station = dottable_lines[2].xpath('.//dd')[0].xpath('./text()')
			# 間取り
			prop.room = dottable_lines[2].xpath('.//dd')[1].xpath('./text()')
			# 築年月
			prop.built_date = dottable_lines[3].xpath('.//dd/text()')

			# 期
			prop.period = "-"

			prop_list << prop
		}
		return prop_list
	end

	# 物件クラスのリストを返す (リスト一覧表示のページ: 新築マンション)
	def make_property_list
		# 物件一覧を取得
		properties = @doc.xpath('//*[@id="js-bukkenList"]/div[@class="property_unit_group"]/div[@class="property_unit"]')
		# 物件ごとに各項目を取得
		prop_list = []
		properties.each { |property|
					
			# 物件名・詳細ページのURLを取得
			name = property.xpath('.//div[@class="property_unit-header"]/h2[@class="property_unit-title"]/a').text
			url = "#{SUUMO_DOMAIN}#{property.xpath('.//div[@class="property_unit-header"]/h2[@class="property_unit-title"]/a/@href')}"

			# 各種項目値を取得
			dottable = property.xpath('.//div[@class="propertyinfo dottable"]')
			# 所在地
			dlv = dottable.xpath('.//dl[@class="dottable-dlv"]')
			address = dlv.xpath('./dt').text
			# 沿線・駅
			station = dlv.xpath('./dd').text
			
			table_fixes = dottable.xpath('.//table[@class="dottable-fix"]')
			# 第1期,第2期,...ごとに別物件オブジェクトとする
			table_fixes.each { |period|
				prop = Property.new
				prop.name = name
				prop.url = url
				prop.address = address
				prop.station = station
				# 期
				prop.period = period.xpath('.//td')[0].text.gsub(/(\s|　)+/, '').gsub(/^-/,'')
				# 間取り・専有面積
				roomarea = period.xpath('.//td')[1].inner_html.gsub(/(\s|　)+/, '')
				prop.room = roomarea.split("<br>")[0].gsub("<wbr>",'').gsub("</wbr>",'')
				prop.area = roomarea.split("<br>")[1].gsub("<wbr>",'').gsub("</wbr>",'').gsub("<sup>",'').gsub("</sup>",'')
				# 価格
				prop.price = period.xpath('.//td[@class="dottable-accent"]').text.gsub(/(\s|　)+/, '')
				# 築年月
				prop.built_date = "-"
				prop_list << prop
			}	
		}
		return prop_list
	end

	# docから次ページのURLを取得(最終ページならば空文字を返す)
	def search_next_url
		link = @doc.xpath('.//div[@class="pagination_set"]//p[@class="pagination-parts"]/a[text()="次へ"]')[0]
		if link.nil?
			return ""
		else
			path = link.xpath('./@href')
			return "#{SUUMO_DOMAIN}#{path}"
		end
	end
end

#########
# MAIN
#########

######
# **suumo URL**
url = "http://suumo.jp/jj/bukken/ichiran/JJ011FC001/?ar=030&bs=010&ta=13&kt=9999999&kb=1&km=1&mt=9999999&mb=0&tj=0&po=0&pj=1&initFlg=1&bknlistmodeflg=1&pc=100"
######

# tsvファイル出力
STDOUT.sync = true # 出力のバッファリングを無効化
output_file = "suumo.tsv"
File.open(output_file, 'w') { |f|
	f.puts Property.header_tsv.tosjis
	while ! url.empty? do
		prop_page = PropertyListPage.new(url)

		###################################################
		# **物件一覧取得処理**
		# 中古のリストのときはこっち
		#prop_list = prop_page.make_simple_property_list
		# 新築のリストのときはこっち
		prop_list = prop_page.make_property_list
		###################################################
		
		prop_list.each { |prop|
			# 各項目をタブ区切りで出力
			f.puts prop.to_tsv.tosjis
		}

		puts "read #{prop_list.size}: #{url}"
		url = prop_page.search_next_url
	end
}
puts "output #{output_file} finished."